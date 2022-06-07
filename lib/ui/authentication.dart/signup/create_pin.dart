import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartpay/components/button.dart';
import 'package:smartpay/components/colors.dart';
import 'package:smartpay/components/navigation_box.dart';
import 'package:smartpay/components/style.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:smartpay/models/register.dart';
import 'package:smartpay/services/provider.dart';
import 'package:smartpay/ui/authentication.dart/signup/country_screen.dart';
import 'package:smartpay/ui/authentication.dart/signup/register_successful.dart';

class CreatePin extends StatefulWidget {
  const CreatePin({Key? key}) : super(key: key);

  @override
  _CreatePinState createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  final OtpFieldController _pinController = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    // used to determined the screen size for responsive design
    var screensize = MediaQuery.of(context).size;
    var provider = Provider.of<Authentication>(context, listen: false);

    // registraion api
    Future<void> _registration() async {
      final prefs = await SharedPreferences.getInstance();
      String? name = prefs.getString('name');
      String? email = prefs.getString('email');
      String? password = prefs.getString('password');
      String? country = prefs.getString('country');

      UserRegister signUpBody = UserRegister(
        fullName: name!,
        email: email!,
        password: password!,
        deviceName: 'mobile',
        country: country,
      );
      var provider = Provider.of<Authentication>(context, listen: false);
      await provider.postRegister(signUpBody);
      if (provider.regisBack) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const RegisterSuccessful()));
      }
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
                      //back navigation button
                      NavigationBox(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ChooseCountry(),
                          ),
                        ),
                      ),

                      SizedBox(height: screensize.height * 0.05),

                      // Title text
                      Text(
                        'Set your PIN code',
                        style: style.copyWith(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: screensize.height * 0.02),
                      // Page description text
                      Text(
                        'We use state-of-the-art security measures to protect your information at all times',
                        style: style.copyWith(color: AppColor.darkGrey),
                      ),

                      SizedBox(height: screensize.height * 0.06),

                      //PIN text field
                      OTPTextField(
                        controller: _pinController,
                        length: 5,
                        width: screensize.width,
                        obscureText: true,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldWidth: 48,
                        otpFieldStyle: OtpFieldStyle(
                          focusBorderColor: AppColor.orange,
                          borderColor: Colors.orange,
                          enabledBorderColor: Colors.orange,
                        ),
                        fieldStyle: FieldStyle.underline,
                        outlineBorderRadius: 12,
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColor.primaryColor,
                        ),
                        onChanged: (pin) {
                          // print("Changed: " + pin);
                        },
                        onCompleted: (pin) {
                          // print("Completed: " + pin);
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screensize.height * 0.14),
                // button  Create Pin
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: MainButton(
                        text: provider.regloading ? 'Loading...' : 'Create Pin',
                        backgroundColor: AppColor.primaryColor,
                        textColor: AppColor.white,
                        onTap: () async {
                          setState(() {});
                          await _registration();
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
