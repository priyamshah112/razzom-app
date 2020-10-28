import 'package:flutter/material.dart';
import 'package:razzom/razzom/screens/shared/loader.dart';
import 'package:razzom/accounts/services/auth.dart';
import 'package:razzom/razzom/screens/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;
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
                  height: 16.0,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
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
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Password'),
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
                    'Sign up',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password);
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
                  child: Text('Signin here'),
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
