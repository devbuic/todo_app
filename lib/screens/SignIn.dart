import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/services/AuthenticationService.dart';
import 'package:todo_app/utils/Constants.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 150.0),
                child: Center(
                  child:
                      Container(width: 200, height: 150, child: Placeholder()),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter your email'),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter your password'),
                ),
              ),
              SizedBox(height: 40),
              Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: RaisedButton(
                  color: Constants.lightPrimary,
                  onPressed: () async {
                    await context.read<AuthenticationService>().signIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim());

                    final bool success = await context
                        .read<AuthenticationService>()
                        .isSignedIn();
                    if (success) {
                      Toast.show("Signed in...", context,
                          gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    } else {
                      Toast.show("Incorrect sign in credentials.", context,
                          gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                    }
                  },
                  child: Text("Sign In",
                      style: TextStyle(
                          fontSize: Constants.normalFontSize,
                          color: Constants.clearWhite)),
                ),
              ),
              SizedBox(
                height: 130,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New User? ",
                      style: TextStyle(fontSize: Constants.normalFontSize)),
                  Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: Constants.normalFontSize,
                      fontWeight: FontWeight.bold,
                      color: Constants.lightPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
