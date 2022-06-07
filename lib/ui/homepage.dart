import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartpay/components/style.dart';
import 'package:smartpay/models/dashboard.dart';
import 'package:smartpay/services/api.dart/authentication.dart';
import 'package:smartpay/services/provider.dart';
import 'package:smartpay/ui/authentication.dart/signin/otp_signin.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var provider = Provider.of<Authentication>(context, listen: false);
    // logout function
    Future<void> _logOut() async {
      var provider = Provider.of<Authentication>(context, listen: false);
      await provider.postLogOut();
      if (provider.logOutisBack) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const OTPSignIn()));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        leading: IconButton(
          onPressed: () async => await _logOut(),
          icon: const Icon(Icons.logout),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder<Dashboard>(
            future: dashboard(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Center(
                    child: Text(
                      snapshot.data!.data.secret,
                      style: style,
                    ),
                  );
                }
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
