import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:greatdanic_logistics/screens/homepage.dart';
// import 'package:greatdanic_logistics/services/auth.dart';
import 'package:greatdanic_logistics/shared/changescreen.dart';
import 'package:greatdanic_logistics/shared/constants.dart';
import 'package:greatdanic_logistics/shared/customtext.dart';
// import 'package:greatdanic_logistics/shared/loading.dart';

import 'package:greatdanic_logistics/shared/myButton.dart';

import 'login.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;

  const SignUp({Key key, this.toggleView}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// final AuthServices _auth = AuthServices();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

bool loading = false;
String error = '';
RegExp regExp = new RegExp(p);
bool obserText = true;
String email;
String phoneNumber;
bool isMale = true;
String password;
String fName;
String lName;

class _SignUpState extends State<SignUp> {
  void validation() async {
    setState(() {
      loading = true;
    });
    final FormState _form = _formKey.currentState;
    await Firebase.initializeApp();
    if (!_form.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        setState(() {
          loading = false;
        });
        FirebaseFirestore.instance.collection("User").doc(result.user.uid).set({
          "fName": fName,
          "lName": lName,
          "UserId": result.user.uid,
          "UserEmail": email,
          // "UserGender": isMale == true ? "Male" : "Female",
          "PhoneNumber": phoneNumber,
          "Password": password
        });
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (ctx) => HomePage()), (route) => false);
        // myDialogBox();
      } on PlatformException catch (e) {
        print(e.message.toString());
        // ignore: deprecated_member_use
        // _scaffoldKey.currentState.showSnackBar(
        //   SnackBar(
        //     content: Text(e.message),
        //   ),
        // );

      }
    } else {}
  }

  Future<void> myDialogBox() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: Icon(Icons.login, color: Colors.purple),
                    title: CustomText(
                      text: "Sign Up Successful \nTap to Proceed to Login",
                      color: primaryColor,
                      size: 16,
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) => Login()));
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            height: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                Column(
                  
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (ctx) => Login(),
                                ),
                              );
                            },
                            child: Container(
                              height: 50,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Colors.purple[100].withOpacity(0.2),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5))),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.purple,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // CustomText(
                          //   text: "Hello!",
                          //   size: 34,
                          //   color: Colors.purple[300],
                          //   weight: FontWeight.bold,
                          // ),
                          CustomText(
                            text: "Signup to",
                            size: 34,
                            color: Colors.purple,
                            weight: FontWeight.bold,
                          ),
                          CustomText(
                            text: "get started",
                            size: 34,
                            color: Colors.purple,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  fName = value;
                                });
                              },
                              validator: (value) {
                                if (value == "") {
                                  return "Please fill your First Name";
                                } else if (value.length > 10) {
                                  return "First is Too Short";
                                }
                                return "";
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: primaryColor),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: primaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: primaryColor),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                      width: 1,
                                    )),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: primaryColor)),
                                labelText: "First Name",
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  lName = value;
                                });
                              },
                              validator: (value) {
                                if (value == "") {
                                  return "Please fill your Last Name";
                                } else if (value.length > 10) {
                                  return "Last Name is Too Short";
                                }
                                return "";
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: primaryColor),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: primaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: primaryColor),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                      width: 1,
                                    )),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: primaryColor)),
                                labelText: "Last Name",
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == "") {
                                  return "Please fill Email";
                                } else if (!regExp.hasMatch(value)) {
                                  return "Email Is Invalid";
                                }
                                return "";
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: primaryColor),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: primaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: primaryColor),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                      width: 1,
                                    )),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: primaryColor)),
                                labelText: "Email",
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                  print(email);
                                });
                              },
                            ),
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                  print(password);
                                });
                              },
                              obscureText: obserText,
                              validator: (value) {
                                if (value == "") {
                                  return "Please FIll Password";
                                } else if (value.length < 8) {
                                  return "Password is too short";
                                }
                                return "";
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: primaryColor),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: primaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: primaryColor),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                      width: 1,
                                    )),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: primaryColor)),
                                labelText: "Password",
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obserText = !obserText;
                                    });
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: Icon(
                                    obserText == true
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black,
                                  ),
                                ),
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     setState(() {
                            //       isMale = !isMale;
                            //     });
                            //   },
                            //   child: Container(
                            //     height: 60,
                            //     padding: EdgeInsets.only(left: 10),
                            //     width: double.infinity,
                            //     decoration: BoxDecoration(
                            //         border: Border.all(
                            //       color: Colors.grey,
                            //     )),
                            //     child: Center(
                            //       child: Row(
                            //         children: [
                            //           Text(
                            //             isMale == true ? "Male" : "Female",
                            //             style: TextStyle(
                            //                 color: Colors.black87, fontSize: 18),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: 10,),
                            Padding(
                              padding: EdgeInsets.only(
             bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    phoneNumber = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == "") {
                                    return "Please Fill Phone Number";
                                  } else if (value.length < 11) {
                                    return "Phone Number Must Be 11 Digits";
                                  }
                                  return "";
                                },
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: primaryColor),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: primaryColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                        width: 1, color: primaryColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(
                                        width: 1,
                                      )),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(
                                          width: 1, color: primaryColor)),
                                  labelText: "Phone Number",
                                  labelStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            // ignore: deprecated_member_use
                            MyButton(
                                name: "SignUp",
                                onPressed: () async {
                                  validation();

                                  // if(_formKey.currentState.validate()){
                                  //   setState(() => loading = true);
                                  //   dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                                  //   if(result == null) {
                                  //     setState(() {
                                  //       loading = false;
                                  //       error = 'Please supply valid credentials';
                                  //     });
                                  //   }
                                  // }
                                }),
                            SizedBox(height: 12.0),
                            Text(
                              error,
                              style: TextStyle(
                                  color: Colors.red, fontSize: 14.0),
                            ),
                            ChangeScreen(
                              name: "Login",
                              whichAccount: "I Have An Account Already",
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => Login(),
                                  ),
                                );
                              },
                            ),
                          ],
                        )),
                    Visibility(
                        visible: loading,
                        child: Center(child: CircularProgressIndicator())),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
