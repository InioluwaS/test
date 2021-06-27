import 'package:flutter/material.dart';
import 'package:greatdanic_logistics/screens/wrapper.dart';
import 'package:greatdanic_logistics/shared/constants.dart';
import 'package:splashscreen/splashscreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new Wrapper(),
        title: new Text('Welcome to Great Danic Logistics! \nFast And Reliable Delivery Services',
            style: TextStyle(color: primaryColor, fontSize: 16)),
        image: new Image.asset('images/logo.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 70.0,
        loaderColor: primaryColor);
  }
}
