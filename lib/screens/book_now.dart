import 'package:flutter/material.dart';
import 'package:greatdanic_logistics/screens/callNumberButton.dart';
import 'package:greatdanic_logistics/screens/createorderScreen.dart';
import 'package:greatdanic_logistics/shared/constants.dart';
import 'package:greatdanic_logistics/shared/customtext.dart';

class Book extends StatefulWidget {
  const Book({Key key}) : super(key: key);

  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: "Create new \norder!",
                            size: 36,
                            color: primaryColor),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6.0,
                                  spreadRadius: 0.5,
                                  offset: Offset(0.7, 0.7))
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Icon(Icons.save_alt,
                                    size: 50,
                                    color: Colors.pinkAccent.withOpacity(0.6)),
                                // child: CircleAvatar(
                                //   radius: 30,
                                //   backgroundImage: AssetImage(image),
                                //   backgroundColor: Colors.purple[50].withOpacity(0.4)
                                // ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text: "Saved orders",
                                size: 16,
                                color: primaryColor,
                                weight: FontWeight.w500,
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6.0,
                                  spreadRadius: 0.5,
                                  offset: Offset(0.7, 0.7)),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Icon(Icons.save,
                                    size: 50, color: Colors.yellow[700]),
                                // child: CircleAvatar(
                                //   radius: 30,
                                //   backgroundImage: AssetImage(image),
                                //   backgroundColor: Colors.purple[50].withOpacity(0.4)
                                // ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text: "Custom orders",
                                size: 16,
                                color: primaryColor,
                                weight: FontWeight.w500,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => CreateOrder()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          CustomText(
                            text: "Create from scratch",
                            size: 16,
                            color: Colors.yellow[700],
                            weight: FontWeight.bold,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        floatingActionButton: CallNumberButton(phoneNumber: "+234 90 39884103",),
      ),
    );
  }
}
