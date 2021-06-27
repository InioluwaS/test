import 'package:flutter/material.dart';
import 'package:greatdanic_logistics/shared/constants.dart';

class BackButton extends StatelessWidget {
  const BackButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height * 0.1,
        child: Icon(Icons.arrow_back, size: 30, color: primaryColor),
      ),
    );
  }
}
