import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:smartpay/models/dashboard.dart';
import 'package:smartpay/models/login.dart';
import 'package:smartpay/models/register.dart';
import 'package:http/http.dart' as http;
import 'package:smartpay/models/request_token.dart';
import 'package:smartpay/models/verify_email_token.dart';
import 'package:smartpay/services/api.dart/authentication.dart';

class Authentication with ChangeNotifier {
  bool signInloading = false;
  bool signInisBack = false;
  bool logOutloading = false;
  bool logOutisBack = false;
  bool regloading = false;
  bool regisBack = false;
  bool getTokenloading = false;
  bool getTokenisBack = false;
  bool verifyTokenloading = false;
  bool verifyTokenisBack = false;
  bool dashBoardloading = false;
  bool dashBoardisBack = false;

  // post provider signIn api
  Future<void> postLogin(User body) async {
    signInloading = true;
    notifyListeners();
    http.Response response = (await login(body))!;

    if (response.statusCode == 200) {
      signInisBack = true;
      var newdata = jsonDecode(response.body);
      var token = Login.fromJson(newdata).data.token;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userToken', token);
    }
    signInloading = false;
    notifyListeners();
  }

  // post provider logout api
  Future<void> postLogOut() async {
    logOutloading = true;
    notifyListeners();
    http.Response response = (await logOut())!;
    if (response.statusCode == 200) {
      logOutisBack = true;
    }
    logOutloading = false;
    notifyListeners();
  }

  // post provider signUp api
  Future<void> postRegister(UserRegister body) async {
    regloading = true;
    notifyListeners();
    http.Response response = (await register(body))!;
    if (response.statusCode == 200) {
      regisBack = true;
    }
    regloading = false;
    notifyListeners();
  }

  // post provider get token api
  Future<void> postGetEmailToken(TokenData body) async {
    getTokenloading = true;
    notifyListeners();
    http.Response response = (await getEmailToken(body))!;

    if (response.statusCode == 200) {
      getTokenisBack = true;
    }
    getTokenloading = false;
    notifyListeners();
  }

  // post provider verify sent token api
  Future<void> postVerifyToken(VerifyToken body) async {
    verifyTokenloading = true;
    notifyListeners();
    http.Response response = (await verifyToken(body))!;

    if (response.statusCode == 200) {
      verifyTokenisBack = true;
    }
    verifyTokenloading = false;
    notifyListeners();
  }

  // get provider to fetch data from dashboard api
  // Future<void> getDashBoard() async {
  //   dashBoardloading = true;
  //   notifyListeners();
  // final response = (await dashboard());

  //   if (response.statusCode == 200) {
  //     dashBoardisBack = true;
  //   }
  //   dashBoardloading = false;
  //   notifyListeners();
  // }

  // Future<SecretData> dashboard() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString('userToken')!;
  //   // dashBoardloading = true;
  //   // notifyListeners();
  //   final response = await http.get(
  //       Uri.parse('https://smart-pay-mobile.herokuapp.com/api/v1/dashboard'),
  //       headers: {
  //         "Content-Type": "application/json",
  //         'token': '386|4fMQjKOO7dZSoJYF4lM7tc2Cmw2y5xaK4RLFnykf',
  //       });
  //   if (response.statusCode == 200) {
  //     // dashBoardisBack = true;
  //     final _data = jsonDecode(response.body);
  //     final userResponse = SecretData.fromJson(_data);
  //     return userResponse;
  //   } else {
  //     // dashBoardloading = false;
  //     // notifyListeners();
  //     throw Exception('Failed to load Users');
  //   }
  // }
}
