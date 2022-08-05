import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartpay/components/button.dart';
import 'package:smartpay/components/colors.dart';
import 'package:smartpay/components/navigation_box.dart';
import 'package:smartpay/components/social_container.dart';
import 'package:smartpay/components/style.dart';
import 'package:smartpay/components/textform.dart';
import 'package:smartpay/models/request_token.dart';
import 'package:smartpay/services/provider.dart';
import 'package:smartpay/ui/authentication.dart/signin/signin.dart';
import 'package:smartpay/ui/authentication.dart/signup/otp_signup.dart';
import 'package:provider/provider.dart';
import 'package:smartpay/ui/onboarding/onboardingscreen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

TextEditingController _emailField = TextEditingController();
TextEditingController _passwordField = TextEditingController();
TextEditingController _fullName = TextEditingController();

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    // used to determined the screen size for responsive design
    var screensize = MediaQuery.of(context).size;
    var provider = Provider.of<Authentication>(context, listen: false);

// method that send api request when a user enter email
    Future<void> _getToken() async {
      String email = _emailField.text.trim();
      TokenData tokenEmail = TokenData(
        email: email,
      );
      var provider = Provider.of<Authentication>(context, listen: false);
      await provider.postGetEmailToken(tokenEmail);
      if (provider.getTokenisBack) {
        // pass and display token instead of email for testing.
        // final prefs = await SharedPreferences.getInstance();
        // var token = prefs.getString("token");
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => OTPSignUp(email: email)));
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
                      //page navigation button
                      NavigationBox(onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('showHome', false);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const OnboardingPage(),
                          ),
                        );
                      }),

                      SizedBox(height: screensize.height * 0.05),

                      Row(
                        children: [
                          Text(
                            'Create a',
                            style: style.copyWith(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            'Smartpay',
                            style: style.copyWith(
                              fontSize: 24.0,
                              color: AppColor.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'account',
                        style: style.copyWith(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: screensize.height * 0.04),
                      // sign up full name form
                      MyTextForm(
                        obscureText: false,
                        labelText: 'Full name',
                        controller: _fullName,
                        validatior: (input) =>
                            input!.isEmpty ? "Please enter fullname" : null,
                      ),
                      SizedBox(height: screensize.height * 0.02),
                      // sign up email form
                      MyTextForm(
                        obscureText: false,
                        labelText: 'Email',
                        controller: _emailField,
                        validatior: (input) => !(input?.contains('@') ?? false)
                            ? "Please enter valid Email"
                            : null,
                      ),

                      SizedBox(height: screensize.height * 0.02),
                      // sign up password form
                      MyTextForm(
                        obscureText: _isObscure,
                        controller: _passwordField,
                        labelText: 'Password',
                        validatior: (value) {
                          bool passValid =
                              RegExp("^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).*")
                                  .hasMatch(value!);
                          if (value.isEmpty || !passValid) {
                            return 'Please enter Valid Pasword*';
                          }
                          return null;
                        },
                        // (input != null && input.length < 6)
                        //     ? "Password should be more than 5 characters"
                        //     : null,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColor.darkGrey,
                          ),
                          onPressed: () {
                            if (_globalFormKey.currentState!.validate()) {
                              setState(
                                () {
                                  _isObscure = !_isObscure;
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screensize.height * 0.03),
                // navigate to sign in page, if you have account already
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: MainButton(
                        text:
                            provider.getTokenloading ? 'Loading...' : 'Sign Up',
                        backgroundColor: AppColor.primaryColor,
                        textColor: AppColor.white,
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString('email', _emailField.text);
                          prefs.setString('password', _passwordField.text);
                          prefs.setString('name', _fullName.text);
                          setState(() {});
                          await _getToken();
                        },
                      ),
                    )
                  ],
                ),

                SizedBox(height: screensize.height * 0.05),
                // divider with centered 'OR'.
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    children: [
                      Expanded(child: Divider(color: AppColor.grey)),
                      const SizedBox(width: 12),
                      Text(
                        'OR',
                        style: style.copyWith(
                            fontSize: 14, color: AppColor.darkGrey),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Divider(color: AppColor.grey)),
                    ],
                  ),
                ),

                // Sign in with google 0r apple
                SizedBox(height: screensize.height * 0.05),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    children: [
                      InkWell(
                        child: const SocialContainer(
                          image: AssetImage('assets/google_icon.png'),
                        ),
                        onTap: () {},
                      ),
                      Expanded(child: Container()),
                      InkWell(
                        child: const SocialContainer(
                          image: AssetImage('assets/Apple_logo.png'),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screensize.height * 0.07),

                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: style.copyWith(color: AppColor.darkGrey),
                      ),
                      const SizedBox(width: 3),
                      InkWell(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignIn(),
                          ),
                        ),
                        child: Text(
                          'Sign In',
                          style: style.copyWith(color: AppColor.orange),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
