import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartpay/components/button.dart';
import 'package:smartpay/components/countryfield.dart';
import 'package:smartpay/components/colors.dart';
import 'package:smartpay/components/navigation_box.dart';
import 'package:smartpay/components/style.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:smartpay/ui/authentication.dart/signup/create_pin.dart';

class ChooseCountry extends StatefulWidget {
  const ChooseCountry({Key? key}) : super(key: key);

  @override
  _ChooseCountryState createState() => _ChooseCountryState();
}

class _ChooseCountryState extends State<ChooseCountry> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String? choosedCountry;

  @override
  Widget build(BuildContext context) {
    // used to determined the screen size for responsive design
    var screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
      body: ListView(
        children: [
          Form(
            key: globalFormKey,
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
                        'Country of Residence',
                        style: style.copyWith(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: screensize.height * 0.02),
                      // page instruction
                      Text(
                        'Please select all the countries that you\'re a tax recident in',
                        style: style.copyWith(color: AppColor.darkGrey),
                      ),

                      SizedBox(height: screensize.height * 0.05),

                      //selected country field
                      CountryField(
                        // Use the code variable from "CountryCode" class to access country name, code, dialcode and flag
                        onChanged: (CountryCode? code) {
                          setState(() {
                            choosedCountry = code!.code;
                          });
                        },
                      )
                    ],
                  ),
                ),

                SizedBox(height: screensize.height * 0.47),
                // button to Continue
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: MainButton(
                        text: 'Continue',
                        backgroundColor: AppColor.primaryColor,
                        textColor: AppColor.white,
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString('country', choosedCountry!);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CreatePin(),
                            ),
                          );
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
