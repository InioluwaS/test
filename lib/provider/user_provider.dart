import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greatdanic_logistics/models/locationPrice.dart';
// import 'package:greatdanic_logistics/models/locationPrice.dart';
import 'package:greatdanic_logistics/models/userModel.dart';
// import 'package:provider/provider.dart';
// import 'package:greatdanic_logistics/screens/authenticate/signup.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> userModelList = [];

  UserModel userModel;

  //Get User Data From Firebase

  Future<void> getUserData() async {
    List<UserModel> newUserList = [];
    User currentUser = FirebaseAuth.instance.currentUser;

    QuerySnapshot userSnapShots =
        await FirebaseFirestore.instance.collection("User").get();
    userSnapShots.docs.forEach((element) {
      if (currentUser.uid == element.get("UserId")) {
        userModel = UserModel(
          firstName: element.get("fName"),
          lastName: element.get("lName"),
          phoneNumber: element.get("PhoneNumber"),
          email: element.get("UserEmail"),
        );
        newUserList.add(userModel);
      }
      userModelList = newUserList;
      // print(userModelList);
    });

    notifyListeners();
  }

  List<UserModel> get getUserModelList {
    return userModelList;
  }

  //Notifications
  List<String> notificationList = [];

  void addNotification(String notification) {
    notificationList.add(notification);
  }

  int get getNotificationIndex {
    return notificationList.length;
  }

  //Getting Location and prices

  List<LocationPrice> locationPriceList = [];

  LocationPrice locationPrice;

  Future<void> getLocationPrices() async {
    List<LocationPrice> newPriceList = [];

    QuerySnapshot locationSnapShot = await FirebaseFirestore.instance
        .collection("LocationPrices")
        .doc("aJEKsgdJ6uzkUveL7Kp7")
        .collection("LoctionPricesData")
        .get();
    locationSnapShot.docs.forEach((element) {
      locationPrice =
          LocationPrice(name: element.get("name"), price: element.get("price"));

      newPriceList.add(locationPrice);

      locationPriceList = newPriceList;
    });

    notifyListeners();
  }

  List<LocationPrice> get getLocationPriceList {
    return locationPriceList;
  }

  // List<LocationPrice> get getLocationPriceList {
  //   return locationPriceList;
  // }

  // FirebaseFirestore.instance.collection("UserOrder").where("userId", isEqualTo: currentUser.uid).get()

  notifyListeners();
}
