import 'package:flutter/material.dart';
import 'package:smartpay/components/colors.dart';
import 'package:smartpay/components/style.dart';

class FirstSlide extends StatelessWidget {
  final Function()? onTap;
  const FirstSlide({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return Container(
      color: AppColor.lightGrey,
      child: Padding(
        padding: const EdgeInsets.only(top: 68),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: InkWell(
                  //Click to move to the next slide
                  onTap: onTap,
                  child: Text(
                    'Skip',
                    style: style.copyWith(color: AppColor.orange),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screensize.height * 0.11,
          ),
          // stack to position the graph image on top the device image
          Stack(
            children: [
              // the device image
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Container(
                  color: Colors.transparent,
                  width: screensize.width,
                  child: Image.asset(
                    'assets/device.png',
                    height: screensize.height * 0.58,
                  ),
                ),
              ),

              // the graph image
              Positioned(
                top: 15,
                right: -10,
                left: 2,
                child: Image.asset(
                  'assets/graph.png',
                  height: screensize.height * 0.39,
                ),
              ),

              // the title and description text container
              Positioned(
                bottom: 0,
                child: Container(
                  color: AppColor.white,
                  height: screensize.height * 0.22,
                  width: screensize.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // the tile text
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Finance app the safest \n and most trusted',
                          style: style.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // description text
                      const SizedBox(height: 16),
                      Text(
                        'Your finance work starts here. Our here to help\n you track and deal with speeding up your\n transactions.',
                        style: style.copyWith(
                          fontSize: 14,
                          color: AppColor.darkGrey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
