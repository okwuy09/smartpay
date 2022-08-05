import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:smartpay/models/dashboard.dart';
import 'package:smartpay/models/login.dart';
import 'package:smartpay/models/register.dart';
import 'package:smartpay/models/request_token.dart';
import 'package:smartpay/models/verify_email_token.dart';

// login api call
Future<http.Response?> login(User data) async {
  http.Response? response;
  try {
    response = await http.post(
        Uri.parse('https://smart-pay-mobile.herokuapp.com/api/v1/auth/login'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: jsonEncode(data.toJson()));
  } catch (e) {
    log(e.toString());
  }

  return response;
}

// logout api call
Future<http.Response?> logOut() async {
  http.Response? response;
  try {
    response = await http.post(
      Uri.parse('https://smart-pay-mobile.herokuapp.com/api/v1/auth/logout'),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
      },
    );
  } catch (e) {
    log(e.toString());
  }

  return response;
}

// signUp api call
Future<http.Response?> register(UserRegister data) async {
  http.Response? response;
  try {
    response = await http.post(
        Uri.parse(
            'https://smart-pay-mobile.herokuapp.com/api/v1/auth/register'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: jsonEncode(data.toJson()));
  } catch (e) {
    log(e.toString());
  }
  return response;
}

// get token api call
Future<http.Response?> getEmailToken(TokenData data) async {
  http.Response? response;
  try {
    response = await http.post(
        Uri.parse('https://smart-pay-mobile.herokuapp.com/api/v1/auth/email'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: jsonEncode(data.toJson()));
  } catch (e) {
    log(e.toString());
  }
  return response;
}

// verify token api call
Future<http.Response?> verifyToken(VerifyToken data) async {
  http.Response? response;
  try {
    response = await http.post(
        Uri.parse(
            'https://smart-pay-mobile.herokuapp.com/api/v1/auth/email/verify'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: jsonEncode(data.toJson()));
  } catch (e) {
    log(e.toString());
  }
  return response;
}

// dashboard api call
// Future<DashBoardData?> dashboard() async {
//   final prefs = await SharedPreferences.getInstance();
//   var token = prefs.getString('userToken');

//   try {
//     var response = await http.get(
//         Uri.parse(
//             'https://smart-pay-mobile.herokuapp.com/api/v1/auth/email/verify'),
//         headers: {
//           'Accept': 'application/json',
//           'token': token!,
//         });
//     return response;
//   } catch (e) {
//     log(e.toString());
//   }
// }

// having problem in debuging the dasboard fetch data api, due to limited time, i build the app still working on the solution.

Future<Dashboard> dashboard() async {
  // final prefs = await SharedPreferences.getInstance();
  // var token = prefs.getString('userToken')!;
  var response = await http.get(
      Uri.parse('https://smart-pay-mobile.herokuapp.com/api/v1/dashboard'),
      headers: {
        "Content-Type": "application/json",
        "Accept": 'application/json',
        "token": '404|B3cp1pT2r5THNWls0qKteblMbm6e5cSB3ewOLELH',
      });
  if (response.statusCode == 200) {
    final _data = jsonDecode(response.body);
    final userResponse = Dashboard.fromJson(_data);
    return userResponse;
  } else {
    throw Exception('Failed to load data');
  }
}
