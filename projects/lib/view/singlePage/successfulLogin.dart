import 'package:flutter/material.dart';
import 'package:projects/controller/wiki/loginHandler.dart';

class SuccessfulLogin extends StatelessWidget {
  final String userCode;

  SuccessfulLogin(
    this.userCode,
  );

  @override
  Widget build(BuildContext context) {
    LoginHandler().getTokens(userCode);
    return Scaffold(
      appBar: AppBar(
        title: Text("Successfully logged in"),
      ),
      body: Center(
        child: Text(userCode),
      ),
    );
  }
}
