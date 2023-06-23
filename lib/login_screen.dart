import 'package:elred_todo/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

import 'home_screen.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void listenSignIn() async {
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      if (account != null) {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => const HomeScreen()),
              (route) => false);
        }
      }
    });
    await _googleSignIn.signInSilently();
    /* bool isLogIn=await isLoggedIn();
    if(_currentUser==null&&!isLogIn) {
      try{
        _googleSignIn.signOut();
        _googleSignIn.disconnect();
      }catch(e){
        Util.log("erro");
      }
    }*/
  }

  @override
  void initState() {
    super.initState();
    listenSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<LoginProvider>(
              builder: (_, loginProvider, child) => Center(
                    child: SignInButton(
                        buttonType: ButtonType.google,
                        onPressed: () {
                          loginProvider.login();
                        }),
                  )),
        ],
      ),
    );
  }
}
