import 'package:flutter/material.dart';
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
  bool loading = false;
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
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
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
                  color: Colors.pink[400],
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      print("signin");
                      if (result == null) {
                        setState(() {
                          error = "ERROR";
                          loading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 12.0,
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
                  child: Text('Register here'),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}

// TextFormField(
//                 style: TextStyle(
//                   color: Color(0xFFFFFFFF),
//                 ),
//                 decoration: InputDecoration(
//                   hintText: 'Name',
//                   hintStyle: TextStyle(
//                     color: Color(0xFFFFFFFF),
//                   ),
//                   fillColor: Color(0xFF0C1A24),
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Color(0xFF0C1A24),
//                     ),
//                     borderRadius: const BorderRadius.all(
//                       const Radius.circular(20.0),
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Color(0xFF0C1A24),
//                     ),
//                     borderRadius: const BorderRadius.all(
//                       const Radius.circular(20.0),
//                     ),
//                   ),
//                 ),
//                 textInputAction: TextInputAction.next,
//               ),
