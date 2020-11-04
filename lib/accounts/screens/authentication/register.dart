import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:razzom/razzom/shared/screens/loader.dart';
import 'package:razzom/accounts/services/auth.dart';
import 'package:razzom/razzom/shared/screens/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String phone = "";
  String whatsapp = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  String userType = "";
  String location = "";
  String entrepreneurOffering = "";
  String investorType = "";
  String specify = "";
  int funding;
  String error = "";
  bool loading = false;
  bool entrepreneurOptions = false;
  bool investorOptions = false;
  bool userTypeSelected = false;
  bool otherSelected = false;

  void setEntrepreneurOptions() {
    setState(() {
      entrepreneurOptions = !entrepreneurOptions;
      investorOptions = false;
    });
  }

  void setInvestorOptions() {
    setState(() {
      investorOptions = !investorOptions;
      entrepreneurOptions = false;
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
          child: SingleChildScrollView(
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
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Name'),
                            validator: (val) =>
                                val.isEmpty ? 'Enter name' : null,
                            onChanged: (val) {
                              setState(() {
                                name = val;
                              });
                            },
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
                                phone = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Whatsapp Number'),
                            validator: (val) => val.isEmpty
                                ? 'Enter a valid whatsapp number'
                                : null,
                            onChanged: (val) {
                              setState(() {
                                whatsapp = val;
                              });
                            },
                          ),
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
                            height: 16.0,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Confirm Password'),
                            validator: (val) => password != val
                                ? 'Passwords do not match'
                                : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() {
                                confirmPassword = val;
                              });
                            },
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
                                    print(code.name);
                                    print(code.code);
                                    print(code.dialCode);
                                    print(code.flagUri);
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
                            validator: (val) =>
                                val.isEmpty ? 'Enter your location' : null,
                            onChanged: (val) {
                              setState(() {
                                location = val;
                              });
                            },
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
                                color: Color(0xFF0C1A24),
                                minWidth: 200,
                                height: 50,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(
                                    color: Color(0xFF0C1A24),
                                  ),
                                ),
                                onPressed: () {
                                  print("Investor");
                                  userType = "I";
                                  setInvestorOptions();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'I am here to invest',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              FlatButton(
                                color: Color(0xFF0C1A24),
                                minWidth: 200,
                                height: 50,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(
                                    color: Color(0xFF0C1A24),
                                  ),
                                ),
                                onPressed: () {
                                  print("Entrepreneur");
                                  userType = "E";
                                  setEntrepreneurOptions();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'I am here to raise funds',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: entrepreneurOptions | investorOptions,
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
                            child: ButtonBar(
                              mainAxisSize: MainAxisSize.min,
                              alignment: MainAxisAlignment.center,
                              children: [
                                FlatButton(
                                  color: Color(0xFF0C1A24),
                                  minWidth: 130,
                                  height: 40,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                      color: Color(0xFF0C1A24),
                                    ),
                                  ),
                                  onPressed: () {
                                    entrepreneurOffering = "SaaS";
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'SaaS',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  color: Color(0xFF0C1A24),
                                  minWidth: 130,
                                  height: 40,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                      color: Color(0xFF0C1A24),
                                    ),
                                  ),
                                  onPressed: () {
                                    entrepreneurOffering = "Manufacturing";
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Manufacturing',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  color: Color(0xFF0C1A24),
                                  minWidth: 130,
                                  height: 40,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                      color: Color(0xFF0C1A24),
                                    ),
                                  ),
                                  onPressed: () {
                                    entrepreneurOffering = "Retail";
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Retail',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  color: Color(0xFF0C1A24),
                                  minWidth: 130,
                                  height: 40,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                      color: Color(0xFF0C1A24),
                                    ),
                                  ),
                                  onPressed: () {
                                    entrepreneurOffering = "Service";
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Service',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  color: Color(0xFF0C1A24),
                                  minWidth: 130,
                                  height: 40,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                      color: Color(0xFF0C1A24),
                                    ),
                                  ),
                                  onPressed: () {
                                    entrepreneurOffering = "Software";
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Software',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  color: Color(0xFF0C1A24),
                                  minWidth: 130,
                                  height: 40,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                      color: Color(0xFF0C1A24),
                                    ),
                                  ),
                                  onPressed: () {
                                    entrepreneurOffering = "Other";
                                    toggleOtherSelected();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Other',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
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
                            child: ButtonBar(
                              alignment: MainAxisAlignment.center,
                              children: [
                                FlatButton(
                                  color: Color(0xFF0C1A24),
                                  minWidth: 200,
                                  height: 40,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                      color: Color(0xFF0C1A24),
                                    ),
                                  ),
                                  onPressed: () {
                                    investorType = "Early-Stage/Angel";
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Early-Stage/Angel',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  color: Color(0xFF0C1A24),
                                  minWidth: 200,
                                  height: 40,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                      color: Color(0xFF0C1A24),
                                    ),
                                  ),
                                  onPressed: () {
                                    investorType = "Venture Capitalist";
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Venture Capitalist',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  color: Color(0xFF0C1A24),
                                  minWidth: 200,
                                  height: 40,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                      color: Color(0xFF0C1A24),
                                    ),
                                  ),
                                  onPressed: () {
                                    investorType = "Crowdfunder";
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Crowdfunder',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  color: Color(0xFF0C1A24),
                                  minWidth: 200,
                                  height: 40,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                      color: Color(0xFF0C1A24),
                                    ),
                                  ),
                                  onPressed: () {
                                    investorType = "Other";
                                    toggleOtherSelected();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Other',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
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
                                    specify = val;
                                  });
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: entrepreneurOptions | investorOptions,
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
                                items: [
                                  DropdownMenuItem(
                                    value: 0,
                                    child: Text(
                                      'Funding 1',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text(
                                      'Funding 2',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                                onChanged: (val) {
                                  setState(() {
                                    funding = val;
                                  });
                                },
                              ),
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
                                  items: [
                                    DropdownMenuItem(
                                      value: 0,
                                      child: Text(
                                        'Funding 1',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 1,
                                      child: Text(
                                        'Funding 2',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                  onChanged: (val) {
                                    setState(() {
                                      funding = val;
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
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
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
                                text: 'Already a member? ',
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
