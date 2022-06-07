import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:provider/provider.dart';
import 'package:smartpay/components/button.dart';
import 'package:smartpay/components/colors.dart';
import 'package:smartpay/components/navigation_box.dart';
import 'package:smartpay/components/style.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:smartpay/models/request_token.dart';
import 'package:smartpay/models/verify_email_token.dart';
import 'package:smartpay/services/provider.dart';
import 'package:smartpay/ui/authentication.dart/signup/country_screen.dart';

class OTPSignUp extends StatefulWidget {
  final String email;
  const OTPSignUp({Key? key, required this.email}) : super(key: key);

  @override
  _OTPSignUpState createState() => _OTPSignUpState();
}

class _OTPSignUpState extends State<OTPSignUp> {
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  final OtpFieldController _otpSignUpController = OtpFieldController();
  String? newpin;
  bool resent = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Authentication>(context, listen: false);
    // used to determined the screen size for responsive design
    var screensize = MediaQuery.of(context).size;

    // method that verify token from user
    Future<void> _verifyToken() async {
      VerifyToken tokenToVerify = VerifyToken(
        email: widget.email,
        token: newpin,
      );
      var provider = Provider.of<Authentication>(context, listen: false);
      await provider.postVerifyToken(tokenToVerify);
      if (provider.verifyTokenisBack) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const ChooseCountry()));
      }
    }

    // resend code method
    Future<void> _getToken() async {
      String email = widget.email;
      TokenData tokenEmail = TokenData(
        email: email,
      );
      var provider = Provider.of<Authentication>(context, listen: false);
      await provider.postGetEmailToken(tokenEmail);
    }

    return Scaffold(
      backgroundColor: AppColor.white,
      body: ListView(
        children: [
          Form(
            key: _globalFormKey,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, right: 24.0, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //navigation button
                      NavigationBox(onTap: () => Navigator.pop(context)),

                      SizedBox(height: screensize.height * 0.05),

                      Text(
                        'Verify it\'s you',
                        style: style.copyWith(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: screensize.height * 0.02),
                      // text that display your email after sending password recovery
                      Text(
                        'We send a code to ( ${widget.email} ). Enter it here to verify your identity',
                        style: style.copyWith(color: AppColor.darkGrey),
                      ),

                      SizedBox(height: screensize.height * 0.05),

                      //Otp text field
                      OTPTextField(
                        controller: _otpSignUpController,
                        length: 5,
                        width: screensize.width,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldWidth: 56,
                        otpFieldStyle: OtpFieldStyle(
                          focusBorderColor: AppColor.orange,
                          borderColor: Colors.transparent,
                          enabledBorderColor: Colors.transparent,
                          backgroundColor: AppColor.lightGrey,
                        ),
                        fieldStyle: FieldStyle.box,
                        outlineBorderRadius: 12,
                        style: TextStyle(
                            fontSize: 24, color: AppColor.primaryColor),
                        onChanged: (pin) {
                          // print("Changed: " + pin);
                        },
                        onCompleted: (pin) {
                          setState(() {
                            newpin = pin;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screensize.height * 0.041),
                // Resend textbutton
                TextButton(
                  onPressed: () async {
                    await _getToken();
                    setState(() {
                      resent = true;
                    });
                  },
                  child: Text(
                    resent ? 'Code Sent' : 'Resend Code',
                    style: style.copyWith(color: AppColor.orange),
                  ),
                ),

                SizedBox(height: screensize.height * 0.09),
                // button Confirm otp entered
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: MainButton(
                        text: provider.verifyTokenloading
                            ? 'Loading...'
                            : 'Confirm',
                        backgroundColor: AppColor.primaryColor,
                        textColor: AppColor.white,
                        onTap: () async {
                          setState(() {});
                          await _verifyToken();
                          _otpSignUpController.clear();
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
