import 'package:flutter/material.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/screens/constants.dart';
import 'package:razzom/razzom/shared/screens/loader.dart';
import 'package:razzom/accounts/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";
  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loader();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Razzom',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontFamily: 'Bahnschrift',
              fontWeight: FontWeight.bold,
              letterSpacing: 1.8,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF0C1A24),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/logo2.png',
                          ),
                          Text(
                            'razzom.com',
                            style: TextStyle(
                              color: Color(0xFF0CE5DF),
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Connect.Empower.Grow.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) =>
                                val.isEmpty ? 'Enter an email' : null,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            validator: (val) => val.length < 6
                                ? 'Enter an password 6+ characters long'
                                : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          RaisedButton(
                            color: Color(0xFF0CE5DF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(
                                color: Color(0xFF0CE5DF),
                              ),
                            ),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                print("signin");
                                if (result == null) {
                                  setState(() {
                                    error = "ERROR";
                                    loading = false;
                                  });
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              }
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            error,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 10.0,
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              widget.toggleView();
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Not a user? ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: ' here.'),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    dynamic result =
                                        await _auth.signInWithGoogle();
                                    print("RESULT: " + result.toString());
                                    if (result == null) {
                                      setState(() {
                                        error = "ERROR";
                                        loading = false;
                                      });
                                    }
                                  },
                                  child: Container(
                                    child: Image.asset(
                                      'assets/images/google.png',
                                      scale: 2,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
