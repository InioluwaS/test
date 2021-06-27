// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:greatdanic_logistics/models/locationPrice.dart';
import 'package:greatdanic_logistics/provider/user_provider.dart';
import 'package:greatdanic_logistics/screens/checkOut.dart';
// import 'package:greatdanic_logistics/screens/selectLocation.dart';
// import 'package:greatdanic_logistics/shared/constants.dart';
import 'package:greatdanic_logistics/shared/customtext.dart';
import 'package:greatdanic_logistics/shared/myButton.dart';
import 'package:provider/provider.dart';
// import 'package:country_state_city_picker/country_state_city_picker.dart';

class CreateOrder extends StatefulWidget {
  final Function toggleView;

  const CreateOrder({Key key, this.toggleView}) : super(key: key);

  @override
  _CreateOrderState createState() => _CreateOrderState();
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
String senderName;
String beneficiaryName;
String beneficiaryPhoneNumber;
String pickUpAdress;
String beneficiaryAdress;
String itemDescription;
String beneficiaryLandMark;
String pickUpLandMark;
UserProvider locationProvider;

class _CreateOrderState extends State<CreateOrder> {
  // UserProvider locationPriceProvider;

  void validation(Widget checkOut) async {
    setState(() {
      loading = true;
    });
    final FormState _form = _formKey.currentState;
    await Firebase.initializeApp();
    if (!_form.validate()) {
      try {
        User currentUser = FirebaseAuth.instance.currentUser;
        FirebaseFirestore.instance
            .collection("UserOrder")
            .doc()
            .set({
          "itemDescription": itemDescription,
          "beneficiaryName": beneficiaryName,
          "UserId": currentUser.uid,
          "beneficiaryPhoneNumber": beneficiaryPhoneNumber,
          // "UserGender": isMale == true ? "Male" : "Female",
          "beneficiaryAdress": beneficiaryAdress,
          "destination": selectedValue,
          
        });
        Navigator.push (context,
            MaterialPageRoute(builder: (ctx) => checkOut), );
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
    } else {

    }
  }

  String selectedValue;
  List categoryItemList = [];

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<UserProvider>(context);

    locationProvider.getLocationPrices();
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Consumer<UserProvider>(builder: (context, data, child) {
        // print("consumer runinng!");
        // print(data.locationPriceList);
        return SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              height: 3000,
              width: double.infinity,
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
                              // onTap: () {
                              //   Navigator.of(context).pushReplacement(
                              //     MaterialPageRoute(
                              //       builder: (ctx) => Login(),
                              //     ),
                              //   );
                              // },
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Fill Details",
                              size: 34,
                              color: Colors.purple[300],
                              weight: FontWeight.bold,
                            ),
                            // CustomText(
                            //   text: "your order",
                            //   size: 34,
                            //   color: Colors.purple,
                            //   weight: FontWeight.bold,
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // TextFormField(
                              //   onChanged: (value) {
                              //     setState(() {
                              //       senderName = value;
                              //     });
                              //   },
                              //   validator: (value) {
                              //     if (value == "") {
                              //       return "Please fill Sender Name";
                              //     } else if (value.length < 5) {
                              //       return "Sender name is Too Short";
                              //     }
                              //     return "";
                              //   },
                              //   decoration: InputDecoration(
                              //     labelText: "Sender's Name",
                              //     labelStyle:
                              //         TextStyle(color: Colors.black),
                              //     border: OutlineInputBorder(),
                              //   ),
                              // ),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    beneficiaryName = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == "") {
                                    return "Please fill your Beneficiary Name";
                                  } else if (value.length < 5) {
                                    return "Beneficiary name is Too Short";
                                  }
                                  return "";
                                },
                                decoration: InputDecoration(
                                  labelText: "Beneficiary's Name",
                                  labelStyle: TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(),
                                ),
                              ),

                              // TextFormField(
                              //   validator: (value) {
                              //     if (value == "") {
                              //       return "Please fill Email";
                              //     } else if (!regExp.hasMatch(value)) {
                              //       return "Email Is Invalid";
                              //     }
                              //     return "";
                              //   },
                              //   decoration: InputDecoration(
                              //     labelText: "Email",
                              //     labelStyle:
                              //         TextStyle(color: Colors.black),
                              //     border: OutlineInputBorder(),
                              //   ),
                              //   onChanged: (value) {
                              //     setState(() {
                              //       email = value;
                              //       print(email);
                              //     });
                              //   },
                              // ),

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
                              // TextFormField(
                              //   keyboardType: TextInputType.number,
                              //   onChanged: (value) {
                              //     setState(() {
                              //       phoneNumber = value;
                              //     });
                              //   },
                              //   validator: (value) {
                              //     if (value == "") {
                              //       return "Please Fill Phone Number";
                              //     } else if (value.length < 11) {
                              //       return "Phone Number Must Be 11 Digits";
                              //     }
                              //     return "";
                              //   },
                              //   decoration: InputDecoration(
                              //     labelText: "Pick up Phone Number",
                              //     labelStyle:
                              //         TextStyle(color: Colors.black),
                              //     border: OutlineInputBorder(),
                              //   ),
                              // ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    beneficiaryPhoneNumber = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == "") {
                                    return "Please Fill Beneficiary Phone Number";
                                  } else if (value.length < 11) {
                                    return "Phone Number Must Be 11 Digits";
                                  }
                                  return "";
                                },
                                decoration: InputDecoration(
                                  labelText: "Beneficiary Phone Number",
                                  labelStyle: TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              // TextFormField(
                              //   onChanged: (value) {
                              //     setState(() {
                              //       pickUpAdress = value;
                              //     });
                              //   },
                              //   validator: (value) {
                              //     if (value == "") {
                              //       return "Please fill pick up Address";
                              //     } else if (value.length < 10) {
                              //       return "Pickup Address is Too Short";
                              //     }
                              //     return "";
                              //   },
                              //   decoration: InputDecoration(
                              //     labelText: "Pickup Address",
                              //     labelStyle:
                              //         TextStyle(color: Colors.black),
                              //     border: OutlineInputBorder(),
                              //   ),
                              // ),
                              // TextFormField(
                              //   onChanged: (value) {
                              //     setState(() {
                              //       pickUpLandMark = value;
                              //     });
                              //   },
                              //   validator: (value) {
                              //     if (value == "") {
                              //       return "Please fill pickup Landmark and Direction";
                              //     } else if (value.length < 10) {
                              //       return "Pickup Landmark and Direction is Too Short";
                              //     }
                              //     return "";
                              //   },
                              //   decoration: InputDecoration(
                              //     labelText:
                              //         "Add pickup Landmark and Direction",
                              //     labelStyle:
                              //         TextStyle(color: Colors.black),
                              //     border: OutlineInputBorder(),
                              //   ),
                              // ),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    beneficiaryAdress = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == "") {
                                    return "Please fill beneficiary Address";
                                  } else if (value.length < 10) {
                                    return "Benefciary Address is Too Short";
                                  }
                                  return "";
                                },
                                decoration: InputDecoration(
                                  labelText: "Beneficiary Address",
                                  labelStyle: TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              // TextFormField(
                              //   onChanged: (value) {
                              //     setState(() {
                              //       beneficiaryLandMark = value;
                              //     });
                              //   },
                              //   validator: (value) {
                              //     if (value == "") {
                              //       return "Please fill beneficiary Landmark and Direction";
                              //     } else if (value.length < 10) {
                              //       return "Beneficiary Landmark and Direction is Too Short";
                              //     }
                              //     return "";
                              //   },
                              //   decoration: InputDecoration(
                              //     labelText:
                              //         "Add beneficiary Landmark and Direction",
                              //     labelStyle:
                              //         TextStyle(color: Colors.black),
                              //     border: OutlineInputBorder(),
                              //   ),
                              // ),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    itemDescription = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == "") {
                                    return "Please fill item description";
                                  } else if (value.length < 5) {
                                    return "Item Description is Too Short";
                                  }
                                  return "";
                                },
                                decoration: InputDecoration(
                                  labelText: "Item Description",
                                  labelStyle: TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              DropdownButton(
                                isExpanded: true,
                                hint: Text("Select Destination"),
                                value: selectedValue,
                                items:
                                    data.locationPriceList.map((locationPrice) {
                                  return DropdownMenuItem(
                                    value: locationPrice.name +
                                        ',' +
                                        locationPrice.price.toString(),
                                    child: Text(locationPrice.name),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value;
                                    print(selectedValue);
                                  });
                                },
                              ),
                              MyButton(
                                  name: "PROCEED TO CHECKOUT",
                                  onPressed: () async {
                                    validation(CheckOut(
                                        price: selectedValue.toString()));
                                  }),

                              SizedBox(height: 12.0),
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
