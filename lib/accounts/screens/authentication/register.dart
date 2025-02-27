import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:razzom/accounts/screens/authentication/authentication.dart';
import 'package:razzom/accounts/screens/authentication/signin.dart';
import 'package:razzom/razzom/models/customUser.dart';
import 'package:razzom/razzom/shared/data/lists.dart';
import 'package:razzom/razzom/shared/data/vars.dart';
import 'package:razzom/razzom/shared/screens/loader.dart';
import 'package:razzom/accounts/services/auth.dart';
import 'package:razzom/razzom/shared/screens/constants.dart';
import 'package:razzom/razzom/shared/screens/no_internet.dart';
import 'package:razzom/razzom/shared/services/check_internet.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  CustomUser user = new CustomUser();
  bool entrepreneurOptions = false;
  bool investorOptions = false;
  bool userTypeSelected = false;
  bool otherSelected = false;

  bool showPassword;
  bool showConfirmPassword;

  @override
  void initState() {
    super.initState();
    checkInternet().checkConnection(context);
    showPassword = false;
    showConfirmPassword = false;
  }

  @override
  void dispose() {
    checkInternet().listener.cancel();
    super.dispose();
  }

  void setEntrepreneurOptions() {
    print(user.location['country']);
    setState(() {
      entrepreneurOptions = !entrepreneurOptions;
      investorOptions = false;
      otherSelected = false;
    });
  }

  void setInvestorOptions() {
    setState(() {
      investorOptions = !investorOptions;
      entrepreneurOptions = false;
      otherSelected = false;
    });
  }

  void toggleOtherSelected() {
    setState(() {
      otherSelected = !otherSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loader();
    } else {
      setState(() {
        registerError = "";
      });
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
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          child: internetAvailable
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/logo.png'),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                            child: Column(
                              children: [
                                Text(
                                  'razzom.com',
                                  style: TextStyle(
                                    color: Color(0xFF0CE5DF),
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Connect.Empower.Grow.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
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
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Name'),
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter name' : null,
                                  onChanged: (val) {
                                    setState(() {
                                      user.name = val;
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
                                      hintText: 'Phone Number'),
                                  validator: (val) => val.isEmpty
                                      ? 'Enter a valid phone number'
                                      : null,
                                  onChanged: (val) {
                                    setState(() {
                                      user.phone = val;
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
                                      hintText:
                                          'Whatsapp Number (Eg: +971123456)'),
                                  validator: (val) => val.isEmpty
                                      ? 'Enter a valid whatsapp number'
                                      : null,
                                  onChanged: (val) {
                                    setState(() {
                                      user.whatsapp = val;
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
                                      hintText: 'Email'),
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter an email' : null,
                                  onChanged: (val) {
                                    setState(() {
                                      user.email = val;
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
                                    hintText: 'Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          showPassword = !showPassword;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (val) => val.length < 6
                                      ? 'Enter an password 6+ characters long'
                                      : null,
                                  obscureText: !showPassword,
                                  onChanged: (val) {
                                    setState(() {
                                      user.password = val;
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
                                    hintText: 'Confirm Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        showConfirmPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          showConfirmPassword =
                                              !showConfirmPassword;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (val) => user.password != val
                                      ? 'Passwords do not match'
                                      : null,
                                  obscureText: !showConfirmPassword,
                                  onChanged: (val) {
                                    setState(() {
                                      user.confirmPassword = val;
                                    });
                                  },
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    // color: Color(0xFF0C1A24),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Country:\t\t',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      CountryListPick(
                                        appBar: AppBar(
                                          backgroundColor: Color(0xFF0C1A24),
                                          title: Text('Select Country'),
                                        ),
                                        theme: CountryTheme(
                                          isShowFlag: true,
                                          isShowTitle: true,
                                          isShowCode: false,
                                          isDownIcon: true,
                                          showEnglishName: true,
                                        ),
                                        initialSelection: '+971',
                                        onChanged: (CountryCode code) {
                                          user.location['country'] = code.name;
                                          print(user.location['country']);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Location'),
                                  validator: (val) => val.isEmpty
                                      ? 'Enter your location'
                                      : null,
                                  onChanged: (val) {
                                    setState(() {
                                      user.location['city'] = val;
                                    });
                                  },
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'How Can we Help You?',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                ButtonBar(
                                  alignment: MainAxisAlignment.center,
                                  children: [
                                    FlatButton(
                                      color: investorOptions
                                          ? Color(0xFF0CE5DF)
                                          : Color(0xFF0C1A24),
                                      minWidth: 200,
                                      height: 55,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        side: BorderSide(
                                          color: investorOptions
                                              ? Color(0xFF0CE5DF)
                                              : Color(0xFF0C1A24),
                                        ),
                                      ),
                                      onPressed: () {
                                        print("Investor");
                                        user.userType = "Investor";
                                        setInvestorOptions();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          'I am here to invest',
                                          style: TextStyle(
                                            color: investorOptions
                                                ? Colors.black
                                                : Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    FlatButton(
                                      color: entrepreneurOptions
                                          ? Color(0xFF0CE5DF)
                                          : Color(0xFF0C1A24),
                                      minWidth: 200,
                                      height: 55,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        side: BorderSide(
                                          color: entrepreneurOptions
                                              ? Color(0xFF0CE5DF)
                                              : Color(0xFF0C1A24),
                                        ),
                                      ),
                                      onPressed: () {
                                        print("Entrepreneur");
                                        user.userType = "Entrepreneur";
                                        setEntrepreneurOptions();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          'I am here to raise funds',
                                          style: TextStyle(
                                            color: entrepreneurOptions
                                                ? Colors.black
                                                : Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible:
                                      entrepreneurOptions | investorOptions,
                                  child: SizedBox(
                                    height: 16.0,
                                  ),
                                ),
                                Visibility(
                                  visible: entrepreneurOptions,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'What do you offer?',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: entrepreneurOptions,
                                  child: SizedBox(
                                    height: 8.0,
                                  ),
                                ),
                                Visibility(
                                  visible: entrepreneurOptions,
                                  child: Container(
                                    width: 250,
                                    child: DropdownButtonFormField(
                                        isDense: true,
                                        hint: Text(
                                          'Select...',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        dropdownColor: Color(0xFF0C1A24),
                                        decoration: textInputDecoration,
                                        items: ENTREPRENEUR_TYPES.map((type) {
                                          return DropdownMenuItem(
                                            value: type,
                                            child: Text(
                                              '$type',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          setState(() {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            user.entrepreneurOffering = val;
                                            print(user.entrepreneurOffering);
                                            if (val == 'Other') {
                                              otherSelected = true;
                                            } else {
                                              otherSelected = false;
                                            }
                                          });
                                        }),
                                  ),
                                ),
                                Visibility(
                                  visible: investorOptions,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'What type of Investor are you?',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: investorOptions,
                                  child: SizedBox(
                                    height: 8.0,
                                  ),
                                ),
                                Visibility(
                                  visible: investorOptions,
                                  child: Container(
                                    width: 250,
                                    child: DropdownButtonFormField(
                                        isDense: true,
                                        hint: Text(
                                          'Select...',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        dropdownColor: Color(0xFF0C1A24),
                                        decoration: textInputDecoration,
                                        items: INVESTOR_TYPES.map((type) {
                                          return DropdownMenuItem(
                                            value: type,
                                            child: Text(
                                              '$type',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          setState(() {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            user.investorType = val;
                                            if (val == 'Other') {
                                              otherSelected = true;
                                            } else {
                                              otherSelected = false;
                                            }
                                          });
                                        }),
                                  ),
                                ),
                                Visibility(
                                  visible: otherSelected,
                                  child: SizedBox(
                                    height: 10.0,
                                  ),
                                ),
                                Visibility(
                                  visible: otherSelected,
                                  child: Container(
                                    width: 250,
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: 'Specify',
                                        hintStyle: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                        ),
                                        fillColor: Color(0xFF0C1A24),
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF0C1A24),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(20.0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF0C1A24),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                      validator: (val) =>
                                          val.isEmpty ? 'Please specify' : null,
                                      onChanged: (val) {
                                        setState(() {
                                          if (user.userType == "Entrepreneur") {
                                            user.entrepreneurOffering = val;
                                          } else {
                                            user.investorType = val;
                                          }
                                        });
                                      },
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      entrepreneurOptions | investorOptions,
                                  child: SizedBox(
                                    height: 16,
                                  ),
                                ),
                                Visibility(
                                  visible: entrepreneurOptions,
                                  child: Container(
                                    width: 250,
                                    child: DropdownButtonFormField(
                                        isDense: true,
                                        hint: Text(
                                          'Funding Required',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        dropdownColor: Color(0xFF0C1A24),
                                        decoration: textInputDecoration,
                                        items: FUNDING_OPTIONS.map((funding) {
                                          return DropdownMenuItem(
                                            value: FUNDING_OPTIONS
                                                .indexOf(funding),
                                            child: Text(
                                              '$funding',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          setState(() {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            user.funding = val;
                                            print(user.funding);
                                          });
                                        }),
                                  ),
                                ),
                                Visibility(
                                  visible: investorOptions,
                                  child: Container(
                                    width: 250,
                                    child: DropdownButtonFormField(
                                        isDense: true,
                                        hint: Text(
                                          'Funding Budget',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        dropdownColor: Color(0xFF0C1A24),
                                        decoration: textInputDecoration,
                                        items: FUNDING_OPTIONS.map((funding) {
                                          return DropdownMenuItem(
                                            value: FUNDING_OPTIONS
                                                .indexOf(funding),
                                            child: Text(
                                              '$funding',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          setState(() {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            user.funding = val;
                                            print(user.funding);
                                          });
                                        }),
                                  ),
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
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () async {
                                    print(user);
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        registerError = "";
                                        loading = true;
                                      });
                                      dynamic result = await _auth
                                          .registerWithEmailAndPassword(user);
                                      print("RESULT: " + result.toString());
                                      if (result == "registered") {
                                        setState(() {
                                          showSignIn = true;
                                          registerError =
                                              "Email already registered. Please Sign In.";
                                          loading = false;
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                              Authentication()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                        });
                                      } else if (result == null) {
                                        showSignIn = false;
                                        setState(() {
                                          registerError =
                                              "Sign up failed. Please try again.";
                                          loading = false;
                                        });
                                        await _auth.signOut().then((res) {
                                          // showSignIn = true;
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                              Authentication()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                        });
                                      } else if (result ==
                                          "registration successful") {
                                        showSignIn = true;
                                        fromRegister = true;
                                        loading = false;
                                        // setState(() {
                                        //   loading = false;
                                        // });
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            Authentication()),
                                                (Route<dynamic> route) =>
                                                    false);
                                      }
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  registerError,
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
                                      text: 'Already a user? ',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Sign In',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(text: ' here.'),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : NoInternet(notifyParent: refresh),
        ),
      );
    }
  }

  refresh() {
    setState(() {});
  }
}
