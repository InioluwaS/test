// import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:greatdanic_logistics/provider/user_provider.dart';
import 'package:provider/provider.dart';

class NotificationButton extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    UserProvider productProvider = Provider.of<UserProvider>(context);
    return Badge(
        position: BadgePosition(start: 25, top: 8),
        badgeContent: Text(
          productProvider.getNotificationIndex.toString(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        badgeColor: Colors.red,
        child: IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {}));
  }
}
