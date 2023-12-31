import 'package:flutter/material.dart';

import 'reusable_widgets/reusable_widget.dart';
import 'signup_screen.dart';
import 'utils/color_utils.dart';
import 'utils/image_constant.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _emailCorrect = 0; //means the email is not typed
  int _passwordCorrect = 0; //means the password is not typed
  bool _isLoading = false;
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("98FB98"),
            hexStringToColor("006400"),
            hexStringToColor("001C2E")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      "SOP Motion Time Tracker",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0x77ffffff),
                        hintText: 'EMPLOYEE MAIL ID',
                        hintStyle: TextStyle(
                            fontFamily: "Poppins", color: Colors.white38),
                        enabled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 10.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(20),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: new BorderRadius.circular(25),
                        ),
                      ),
                      validator: (value) {
                        if (value!.length == 0) {
                          return "Email cannot be empty";
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return ("Please enter a valid email");
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        emailController.text = value!;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _isObscure3,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure3
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure3 = !_isObscure3;
                              });
                            }),
                        filled: true,
                        fillColor: Color(0x77ffffff),
                        hintText: 'PASSWORD',
                        hintStyle: TextStyle(
                            fontFamily: "Poppins", color: Colors.white38),
                        enabled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 10.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(20),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: new BorderRadius.circular(25),
                        ),
                      ),
                      validator: (value) {
                        RegExp regex = new RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        }
                        if (!regex.hasMatch(value)) {
                          return ("please enter valid password min. 6 character");
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        passwordController.text = value!;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    //increase the width of the MaterialButton below
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width - 100,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      elevation: 5.0,
                      height: 50,
                      onPressed: () {
                        setState(() {
                          visible = true;
                        });
                      },
                      child: !_isLoading
                          ? const Text(
                              'Log in',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            )
                          : const CircularProgressIndicator(color: Colors.blue),
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have account?",
                            style: TextStyle(color: Colors.white70)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: const Text(
                            " Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
