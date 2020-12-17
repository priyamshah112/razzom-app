import 'package:flutter/material.dart';
import 'package:razzom/accounts/screens/authentication/forgotPassword.dart';
import 'package:razzom/accounts/screens/wrapper.dart';
import 'package:razzom/investor/screens/idashboard.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/screens/constants.dart';
import 'package:razzom/razzom/shared/screens/loader.dart';
import 'package:razzom/accounts/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  FToast fToast;
  FToast fToast2;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    fToast2 = FToast();
    fToast2.init(context);
    loading = false;
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color(0xFF0C1A24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.mail,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            "Please verify your email before signing in.",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 5),
    );
  }

  _showToast2() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color(0xFF0C1A24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Password reset link sent to your email.",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    fToast2.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loader();
    } else {
      if (fromRegister) {
        fromRegister = false;
        Future.delayed(Duration.zero, () async {
          _showToast();
        });
      }
      if (fromForgotPassword) {
        fromForgotPassword = false;
        Future.delayed(Duration.zero, () async {
          _showToast2();
        });
      }

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
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
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
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            validator: (val) =>
                                val.isEmpty ? 'Enter a password' : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                            textInputAction: TextInputAction.done,
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
                                  signinError = "";
                                });
                                dynamic result;
                                try {
                                  result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);
                                  print("signin");
                                  if (result == null) {
                                    setState(() {
                                      signinError =
                                          "Invalid Credentials. Please try again.";
                                      loading = false;
                                    });
                                  } else {
                                    print(result);

                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => Wrapper()),
                                        (Route<dynamic> route) => false);
                                  }
                                  // setState(() {
                                  //   loading = false;
                                  // });
                                  // Navigator.of(context).pushAndRemoveUntil(
                                  //     MaterialPageRoute(
                                  //         builder: (context) => Idashboard()),
                                  //     (Route<dynamic> route) => false);
                                } catch (e) {
                                  print(e);
                                  if (this.mounted) {
                                    setState(() {
                                      signinError = e.toString();
                                      loading = false;
                                    });
                                  }
                                }
                              }
                            },
                          ),
                          Visibility(
                            visible: !(signinError == ""),
                            child: SizedBox(
                              height: 10.0,
                            ),
                          ),
                          Text(
                            signinError,
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
                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPassword(),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
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

                                    // print("RESULT EMAIL: " +
                                    //     result.profile['email']);

                                    if (result == null) {
                                      if (this.mounted) {
                                        // check whether the state object is in tree
                                        setState(() {
                                          signinError =
                                              "Please register first.";
                                          loading = false;
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        loading = false;
                                      });
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => Wrapper()),
                                          (Route<dynamic> route) => false);
                                    }
                                    // else {
                                    //   print('signin else reached');
                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => Wrapper()),
                                    // );

                                    // }
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
