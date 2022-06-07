import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartpay/services/provider.dart';
import 'package:smartpay/ui/onboarding/onboardingscreen.dart';
import 'package:smartpay/ui/authentication.dart/signin/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Call the sharedPreferences when the app initialized to determine the bool condition of page to show.
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Authentication()),
  ], child: MyApp(showHome: showHome)));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({Key? key, required this.showHome}) : super(key: key);

  // root of the Application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF111827),
        ),
        fontFamily: 'SF Pro Display',
      ),
      home: showHome ? const SignIn() : const OnboardingPage(),
    );
  }
}
