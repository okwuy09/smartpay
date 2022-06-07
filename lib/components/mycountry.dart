// import 'package:flutter/material.dart';
// import 'package:smartpay/components/data.dart';
// import 'package:smartpay/models/country.dart';

// class dropdown extends StatelessWidget {
//   const dropdown({
//     Key? key,
//     required this.locale,
//   }) : super(key: key);

//   final Locale? locale;

  

//   @override
//   Widget build(BuildContext context) {
//     final List<Country> country = [Country(countryCode: , countryFlag: ,countryName: countryName.toString(),)];


//     _getFlag(String code) {
//       switch (code) {
//         case 'es':
//           return "🇪🇸";
//         case 'de':
//           return "🇩🇪";
//         case 'fr':
//           return "🇫🇷";
//         case 'nl':
//           return "🇳🇱";
//         case 'zh':
//           return "🇨🇳";
//         default:
//           return "🇬🇧";
//       }
//     }

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton(
//           icon: const Icon(
//             Icons.language,
//             color: Colors.red,
//           ),
//           items: I10n.all.map((locale) {
//             final flag = _getFlag(locale.languageCode);
//             return DropdownMenuItem(
//               child: Center(
//                   child: Text(
//                 flag,
//                 style: const TextStyle(fontSize: 20),
//               )),
//               value: locale,
//               onTap: () {
//                 // final provider =
//                 //     Provider.of<LocaleProvider>(context, listen: false);
//                 // provider.setLocale(locale);
//               },
//             );
//           }).toList(),
//           onChanged: (_) {},
//         ),
//       ),
//     );
//   }
// }
