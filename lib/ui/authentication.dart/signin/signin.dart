import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartpay/components/button.dart';
import 'package:smartpay/components/colors.dart';
import 'package:smartpay/components/navigation_box.dart';
import 'package:smartpay/components/social_container.dart';
import 'package:smartpay/components/style.dart';
import 'package:smartpay/components/textform.dart';
import 'package:smartpay/models/login.dart';
import 'package:smartpay/services/provider.dart';
import 'package:smartpay/ui/authentication.dart/signin/password_recovery.dart';
import 'package:smartpay/ui/authentication.dart/signup/signup.dart';
import 'package:smartpay/ui/homepage.dart';
import 'package:smartpay/ui/onboarding/onboardingscreen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

TextEditingController _emailField = TextEditingController();
TextEditingController _passwordField = TextEditingController();

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    // used to determined the screen size for responsive design
    var screensize = MediaQuery.of(context).size;
    var provider = Provider.of<Authentication>(context, listen: false);

    // sigin api accept registered email and password
    Future<void> _login() async {
      String email = _emailField.text.trim();
      String password = _passwordField.text.trim();
      User userLoginDetail =
          User(email: email, password: password, deviceName: 'mobile');
      var provider = Provider.of<Authentication>(context, listen: false);
      await provider.postLogin(userLoginDetail);
      if (provider.signInisBack) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HomePage()));
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
                      //navigation button
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

                      Text(
                        'Hi There! 👋',
                        style: style.copyWith(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: screensize.height * 0.01),

                      Text(
                        'Welcome back, Sign in to your account',
                        style: style.copyWith(color: AppColor.darkGrey),
                      ),

                      SizedBox(height: screensize.height * 0.05),
                      // signin email form
                      MyTextForm(
                        obscureText: false,
                        labelText: 'Email',
                        controller: _emailField,
                        validatior: (input) => !(input?.contains('@') ?? false)
                            ? "Please enter valid Email"
                            : null,
                      ),

                      SizedBox(height: screensize.height * 0.02),
                      // signin password form
                      MyTextForm(
                        obscureText: _isObscure,
                        controller: _passwordField,
                        labelText: 'Password',
                        validatior: (input) =>
                            (input != null && input.length < 6)
                                ? "Password should be more than 5 characters"
                                : null,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColor.darkGrey,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                _isObscure = !_isObscure;
                              },
                            );
                          },
                        ),
                      ),

                      SizedBox(height: screensize.height * 0.02),
                      //recover password navigation rout
                      TextButton(
                        onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PasswordRecovery())),
                        child: Text(
                          'Forgot Password?',
                          style: style.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.orange),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(height: screensize.height * 0.02),

                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: MainButton(
                        text: provider.signInloading ? 'Loading...' : 'Sign In',
                        backgroundColor: AppColor.primaryColor,
                        textColor: AppColor.white,
                        onTap: () async {
                          setState(() {});
                          await _login();
                        },
                      ),
                    )
                  ],
                ),

                SizedBox(height: screensize.height * 0.057),
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
                      const SocialContainer(
                        image: AssetImage('assets/google_icon.png'),
                      ),
                      Expanded(child: Container()),
                      const SocialContainer(
                        image: AssetImage('assets/Apple_logo.png'),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screensize.height * 0.08),
                // nevigate to register page, if you dont have account yet
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: style.copyWith(color: AppColor.darkGrey),
                      ),
                      const SizedBox(width: 3),
                      InkWell(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignUp(),
                          ),
                        ),
                        child: Text(
                          'Sign Up',
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
