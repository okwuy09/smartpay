import 'package:flutter/material.dart';
import 'package:smartpay/components/button.dart';
import 'package:smartpay/components/colors.dart';
import 'package:smartpay/ui/authentication.dart/signin/signin.dart';
import 'package:smartpay/ui/onboarding/firstslide.dart';
import 'package:smartpay/ui/onboarding/secondslide.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  bool isLastPage = false;

//dispose the pageView controller
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
            onPageChanged: (index) {
              // assign the index of the last page to a bool variable
              setState(() => isLastPage = index == 1);
            },
            controller: controller,
            children: [
              // firast slide customised widget
              FirstSlide(
                onTap: () => controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                ),
              ),

              // second slide click and move to the Sign In Screen
              SecondSlide(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SignIn(),
                    ),
                  );
                },
              )
            ]),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: AppColor.white,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 10),

            //  smoothpageindicator package to sow the current page with circular dots
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 2,
                effect: ExpandingDotsEffect(
                  radius: 500,
                  dotWidth: 6,
                  dotHeight: 6,
                  dotColor: AppColor.grey,
                  activeDotColor: AppColor.primaryColor,
                ),
                onDotClicked: (index) => controller.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn),
              ),
            ),
            const SizedBox(height: 20),

            // get started button
            Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: MainButton(
                text: 'Get Started',
                backgroundColor: AppColor.primaryColor,
                textColor: AppColor.white,
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SignIn(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
