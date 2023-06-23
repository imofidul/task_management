import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);
class LoginProvider extends ChangeNotifier{
  void login()async{
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      _googleSignIn.disconnect();
      _googleSignIn.signOut();
    }
  }
}