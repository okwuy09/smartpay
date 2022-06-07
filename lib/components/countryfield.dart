import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:smartpay/components/colors.dart';
import 'package:smartpay/components/navigation_box.dart';
import 'package:smartpay/components/style.dart';

class CountryField extends StatelessWidget {
  final Function(CountryCode?)? onChanged;
  const CountryField({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 56,
      decoration: BoxDecoration(
        color: AppColor.lightGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: CountryListPick(
          // customise selecting country page header
          appBar: AppBar(
            toolbarHeight: 65,
            elevation: 0,
            backgroundColor: AppColor.white,
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  right: 8.0,
                  left: 20,
                  bottom: 10.0,
                ),
                child: NavigationBox(onTap: () => Navigator.pop(context)),
              ),
              Expanded(child: Container()),
              Center(
                child: Text(
                  'Select country',
                  style: style.copyWith(fontSize: 16),
                ),
              ),
              Expanded(flex: 2, child: Container()),
            ],
          ),

          // customise my own country display field
          pickerBuilder: (context, CountryCode? countryCode) {
            return Row(
              children: <Widget>[
                // Flag of the selected country
                Image.asset(
                  countryCode!.flagUri!,
                  package: 'country_list_pick',
                  width: 32,
                  height: 24,
                ),
                const SizedBox(width: 10),

                // the name of the selected country
                Center(
                  child: Text(
                    countryCode.name!,
                    textAlign: TextAlign.center,
                    style: style,
                  ),
                ),

                // expanded to fit in all device
                Expanded(child: Container()),
                const Icon(Icons.keyboard_arrow_down),
              ],
            );
          },

          // customize the Country picker page
          theme: CountryTheme(
            isShowFlag: true,
            isShowTitle: true,
            isShowCode: true,
            isDownIcon: true,
            showEnglishName: false,
            alphabetSelectedTextColor: AppColor.white,
            alphabetSelectedBackgroundColor: AppColor.orange,
            labelColor: AppColor.primaryColor,
          ),
          // initialSelection: '+1'
          // or
          initialSelection: 'US',
          // onchange for the selected country
          onChanged: onChanged,
        ),
      ),
    );
  }
}
