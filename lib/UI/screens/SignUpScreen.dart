import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './HomeScreen.dart';
import 'package:tasty_toast/tasty_toast.dart';
import '../../services/AuthService.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/signUp";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email = "";
  String password = "";
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  void _submitLoginForm(BuildContext context) async {
    try {
      bool formIsValid = _formKey.currentState!.validate();

      if (!formIsValid) {
        return;
      }
      _formKey.currentState!.save();

      setState(() {
        _isLoading = !_isLoading;
      });

      await context
          .read<AuthenticationService>()
          .signUpUser(email: email, password: password);

      setState(() {
        _isLoading = !_isLoading;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("User registration succesful"),
        duration: Duration(seconds: 3),
      ));

      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (e) {
      showToast(context, e.toString(),
          textStyle: TextStyle(color: Colors.white),
          background: BoxDecoration(color: Colors.red),
          alignment: Alignment.topCenter,
          duration: Duration(seconds: 5));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 30,
                    width: 200,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Sign Up',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Enter your email",
                          labelStyle: TextStyle(color: Colors.black),
                          labelText: "Email",
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email ";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          email = value!;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          suffix: IconButton(
                            icon: _obscureText
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility_outlined),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          hintText: "Enter your password",
                          labelStyle: TextStyle(color: Colors.black),
                          labelText: "Password",
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your password ";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          password = value!;
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 40,
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      onPressed: () => _submitLoginForm(context),
                      child: _isLoading
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.black,
                            )
                          : Text(
                              "Sign Up",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 16),
                    )),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(children: [
                        Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.chevron_right_outlined)
                      ]),
                    ))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
