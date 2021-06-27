import 'package:flutter/material.dart';
import 'package:greatdanic_logistics/screens/callNumberButton.dart';
import 'package:greatdanic_logistics/shared/constants.dart';
import 'package:greatdanic_logistics/shared/customtext.dart';

class Tracking extends StatefulWidget {
  const Tracking({ Key key }) : super(key: key);

  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: MediaQuery.of(context).size.height * 0.1,
                      child:
                          Icon(Icons.arrow_back, size: 30, color: primaryColor),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        CustomText(
                              text: "Tracking",
                              size: 28,
                              color: primaryColor,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(width: 5),
                        CustomText(
                              text: "your package",
                              size: 28,
                              color: Colors.black,
                              // weight: FontWeight.w500,
                            ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height*0.1,
                    width: double.infinity,
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6.0,
                                  spreadRadius: 0.5,
                                  offset: Offset(0.7, 0.7))
                            ],
                            borderRadius: BorderRadius.circular(15),

                      ),
                      child: ListTile(
                        leading: Icon(Icons.search, color: primaryColor,),
                        trailing: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.track_changes, color: Colors.white,),
                        ),
                        title: TextFormField(
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          cursorColor: primaryColor,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Tracking Number",
                            hintStyle: TextStyle(
                              color: Colors.black12,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
                  Container(
                    height: MediaQuery.of(context).size.height*0.3,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*0.3,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200].withOpacity(0.7),
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        Positioned(
                          bottom: 50.0,
                          left: 30.0,
                          child: Row(
                            children: [
                              Icon(Icons.bus_alert, color: Colors.black38, size: 30,),
                              SizedBox(width: 18),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: "09TYR4256784564", size: 16, color: primaryColor, weight: FontWeight.bold,),
                                  SizedBox(height: 8,),
                                  CustomText(text: "from Lagos to Owerri", size: 14, color: Colors.black26, weight: FontWeight.bold,),
                                  CustomText(text: "the parcel is waiting for collection", size: 14, color: Colors.black26, weight: FontWeight.bold,),
                                ],
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height*0.1,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.purple[50].withOpacity(0.4),
              ),
              child: Icon(Icons.alarm, color: Colors.purple[700]),
            ),
                            title: CustomText(
                              text: "Shipment history",
                              size: 17,
                              color: primaryColor,
                              weight: FontWeight.bold,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios, color: Colors.black26, size: 17,),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: CallNumberButton(phoneNumber: "+234 90 39884103",),
    );
  }
}