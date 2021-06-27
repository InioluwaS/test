import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greatdanic_logistics/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("User");

  Future<void> updateUserData(
      String fName, String lName, String email, String phoneNumber) async {
    return await userCollection.doc(uid).set({
      "fName": fName,
      "lNmae": lName,
      "email": email,
      "phoneNumber": phoneNumber,
    });
  }

  UserData _userDataFromSnapShots(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      fname: snapshot.get("fName"),
    );
  }


  // Get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots()
      .map(_userDataFromSnapShots);
  }
}
