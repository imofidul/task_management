import 'package:elred_todo/data/respository/shared_pref_manager.dart';
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
        SharedPrefManager.instance.saveData(SharedPrefManager.userId, account.id);
        if (mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => const HomeScreen()),
              (route) => false);
        }
      }
      else{
        try{
          _googleSignIn.signOut();
          _googleSignIn.disconnect();
        }catch(e){
          print(e);
        }
      }
    });
    await _googleSignIn.signInSilently();

  }

  @override
  void initState() {
    super.initState();
    listenSignIn();
  }
  void login()async{
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      _googleSignIn.disconnect();
      _googleSignIn.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
                child: SignInButton(
                    buttonType: ButtonType.google,
                    onPressed: () {
                      login();
                    }),
              ),
        ],
      ),
    );
  }
}
