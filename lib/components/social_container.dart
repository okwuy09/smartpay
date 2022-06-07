import 'package:flutter/material.dart';
import 'package:smartpay/components/colors.dart';

class SocialContainer extends StatelessWidget {
  final ImageProvider<Object> image;
  const SocialContainer({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return Container(
        height: 56,
        width: screensize.width * 0.415,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColor.grey),
        ),
        child: SizedBox(
          height: 23.21,
          width: 19.52,
          child: Image(
            image: image,
          ),
        ));
  }
}
