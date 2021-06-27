import 'package:flutter/material.dart';
import 'package:greatdanic_logistics/provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:greatdanic_logistics/screens/splashscreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // bool isLoading = false;
    return MultiProvider(
        providers: [
          ListenableProvider<UserProvider>(
            create: (ctx) => UserProvider(),
          )
        ],
        child: MaterialApp(
          title: 'Dan Logistics',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              // primarySwatch: Colors.white,
              ),
          // home: StreamBuilder(
          //   stream: FirebaseAuth.instance.authStateChanges(),
          //   builder: (ctx, snapshot) {
          //     if (snapshot.hasData) {
          //       return HomePage();
          //     } else {
          //       return Login();
          //     }
          //   },
          // ),
          home: WelcomeScreen(),
        ));
    //
  }
}
