// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:greatdanic_logistics/screens/authenticate/signup.dart';
// import 'package:greatdanic_logistics/services/auth.dart';
import 'package:greatdanic_logistics/shared/changescreen.dart';
import 'package:greatdanic_logistics/shared/constants.dart';
// import 'package:greatdanic_logistics/shared/constants.dart';
import 'package:greatdanic_logistics/shared/customtext.dart';
// import 'package:greatdanic_logistics/shared/loading.dart';
import 'package:greatdanic_logistics/shared/myButton.dart';

class Login extends StatefulWidget {
  final Function toggleView;

  const Login({Key key, this.toggleView}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// final AuthServices _auth = AuthServices();
String error = '';
bool loading = false;
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
String email;
String password;


bool obserText = true;

class _LoginState extends State<Login> {
  Future <void> validation() async {
   setState(() {
      loading = true;
    });
  final FormState _form = _formKey.currentState;
  if (!_form.validate()) {
    try {
       
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
          setState(() {
      loading = false;
    });
      print(result.user.uid);
    } on PlatformException catch (e) {
      print(e.message);
      // ignore: deprecated_member_use
      // _scaffoldKey.currentState.showSnackBar(SnackBar(
      //   content: Text(e.message),
      // ));
    }
  } else {
    print("No");
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
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
                                    builder: (ctx) => SignUp(),
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
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // CustomText(
                            //   text: "Hello Again!",
                            //   size: 34,
                            //   color: Colors.purple[300],
                            //   weight: FontWeight.bold,
                            // ),
                            CustomText(
                              text: "Welcome",
                              size: 34,
                              color: Colors.purple,
                              weight: FontWeight.bold,
                            ),
                            CustomText(
                              text: "back!",
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
                          height: MediaQuery.of(context).size.height * 0.5,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
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
     borderRadius: BorderRadius.all(Radius.circular(4)),
     borderSide: BorderSide(width: 1,color: primaryColor),
   ),
   disabledBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(4)),
     borderSide: BorderSide(width: 1,color: primaryColor),
   ),
   enabledBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(4)),
     borderSide: BorderSide(width: 1,color: primaryColor),
   ),
   border: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(4)),
     borderSide: BorderSide(width: 1,)
   ),
   errorBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(4)),
     borderSide: BorderSide(width: 1,color: Colors.red)
   ),
   focusedErrorBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(4)),
     borderSide: BorderSide(width: 1,color: primaryColor)
   ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.black),
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
     borderRadius: BorderRadius.all(Radius.circular(4)),
     borderSide: BorderSide(width: 1,color: primaryColor),
   ),
   disabledBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(4)),
     borderSide: BorderSide(width: 1,color: primaryColor),
   ),
   enabledBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(4)),
     borderSide: BorderSide(width: 1,color: primaryColor),
   ),
   border: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(4)),
     borderSide: BorderSide(width: 1,)
   ),
   errorBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(4)),
     borderSide: BorderSide(width: 1,color: Colors.red)
   ),
   focusedErrorBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(4)),
     borderSide: BorderSide(width: 1,color: primaryColor)
   ),
                                  hintText: "Password",
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
                                  hintStyle: TextStyle(color: Colors.black),
                                  
                                ),
                              ),

                              // SizedBox(height: 10,),

                              // ignore: deprecated_member_use
                              MyButton(
                                onPressed: () async {
                                  // if(_formKey.currentState.validate()){
                                  //   setState(() => loading = true);
                                  //   dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                                  //   if(result == null) {
                                  //     setState(() {
                                  //       loading = false;
                                  //       error = 'Could not sign in with those credentials';
                                  //     });
                                  //   }
                                  // }
                                  validation();
                                },
                                name: "Login ",
                              ),
                              SizedBox(height: 12.0),
                              Text(
                                error,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0),
                              ),
                              ChangeScreen(
                                name: "Sign Up",
                                whichAccount: "I Have No Account !",
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (ctx) => SignUp(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )),
                          Visibility(visible: loading, child: Center(child: CircularProgressIndicator()))
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
