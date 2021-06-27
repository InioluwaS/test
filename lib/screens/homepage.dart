import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greatdanic_logistics/models/userModel.dart';
import 'package:greatdanic_logistics/provider/user_provider.dart';
import 'package:greatdanic_logistics/screens/book_now.dart';
import 'package:greatdanic_logistics/screens/callNumberButton.dart';
import 'package:greatdanic_logistics/screens/profileScreen.dart';
import 'package:greatdanic_logistics/screens/tracking.dart';
import 'package:greatdanic_logistics/shared/constants.dart';
import 'package:greatdanic_logistics/shared/customtext.dart';
import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class HomePage extends StatefulWidget {
  // final BuildContext context;
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserProvider userProvider;
  //  final _store = Provider.of<UserProvider>(context, listen: false);
  Widget _buildCards(String name, Function onTap, IconData icon) {
    return Card(
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width * 0.5,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.purple[50].withOpacity(0.4),
              ),
              child: Icon(icon, color: Colors.yellow[700]),
              // child: CircleAvatar(
              //   radius: 30,
              //   backgroundImage: AssetImage(image),
              //   backgroundColor: Colors.purple[50].withOpacity(0.4)
              // ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomText(text: name, size: 16, color: primaryColor)
          ],
        ),
      ),
    );
  }
  // Widget _buildCategoryProduct(String image, int color) {
  //   return CircleAvatar(
  //     maxRadius: 32,
  //     backgroundColor: Color(color),
  //     backgroundImage: NetworkImage(image),
  //   );
  // }

  bool homeColor = true;

  bool cartColor = false;

  bool aboutColor = false;

  bool contactUsColor = false;
  bool profileColor = false;

  Widget accountHeader() {
    List<UserModel> userModel = userProvider.userModelList;
    return Row(
      children: userModel.map((e) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(
              text: '${e.firstName} ${e.lastName}',
              size: 20,
              color: Colors.black,
              weight: FontWeight.w500,
            ),
            SizedBox(
              height: 8,
            ),
            CustomText(
              text: e.email,
              size: 16,
              color: Colors.black54,
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildUserAccountsDrawerHeader() {
    // List<UserModel> userModel = userProvider.userModelList;

    return UserAccountsDrawerHeader(
      accountName: accountHeader(),
      // accountName: Text(
      //   // userModel.elementAt(0).firstName + userModel.elementAt(0).lastName,
      //   'uhjjj ${userModel.map((value) => value.firstName).toString()}',
      //   style: TextStyle(color: Colors.black),
      // ),
      currentAccountPicture: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/logo.png"),
          ),
        ),
      ),
      decoration: BoxDecoration(color: Color(0xfff2f2f2)),
      // accountEmail: Text(
      //   // userModel.elementAt(0).email.toUpperCase(),
      //   userModel.map((value) => value.email).toString(),
      //   style: TextStyle(color: Colors.black),
      // ),
    );
  }

  Widget _buildMyDrawer() {
    return Drawer(
      child: ListView(
        children: [
          _buildUserAccountsDrawerHeader(),
          ListTile(
            hoverColor: Colors.yellowAccent,
            selected: homeColor,
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => HomePage()));
              setState(() {
                homeColor = true;
                contactUsColor = false;
                cartColor = false;
                aboutColor = false;
                profileColor = false;
              });
            },
            leading: Icon(Icons.home),
            title: Text("Home"),
          ),
          ListTile(
            selected: cartColor,
            onTap: () {
              setState(() {
                cartColor = true;
                contactUsColor = false;
                homeColor = false;
                aboutColor = false;
                profileColor = false;
              });
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => Book()));
            },
            leading: Icon(Icons.shopping_cart),
            title: Text("Book Now"),
          ),
          ListTile(
            selected: profileColor,
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => ProfileScreen()));
              setState(() {
                aboutColor = false;
                contactUsColor = false;
                cartColor = false;
                homeColor = false;
                profileColor = true;
              });
            },
            leading: Icon(Icons.account_box_sharp),
            title: Text("Profile"),
          ),
          // ListTile(
          //   selected: contactUsColor,
          //   onTap: () {
          //     setState(() {
          //       contactUsColor = true;
          //       homeColor = false;
          //       cartColor = false;
          //       aboutColor = false;
          //       profileColor = false;
          //     });
          //     Navigator.of(context).pushReplacement(
          //       MaterialPageRoute(
          //         builder: (ctx) => Tracking(),
          //       ),
          //     );
          //   },
          //   leading: Icon(Icons.track_changes),
          //   title: Text("Tracking"),
          // ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }

  Widget _firstSection() {
    List<UserModel> userModel = userProvider.userModelList;
    return Container(
      child: Row(
        children: userModel.map((e) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                text: "Hello ${e.firstName.toString()}",
                size: 36,
                color: primaryColor,
                weight: FontWeight.w500,
              ),
              SizedBox(
                height: 8,
              ),
              CustomText(
                text: "Ready to start your day?",
                size: 16,
                color: Colors.black54,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // userProvider = Provider.of<UserProvider>(context);
    // userProvider.getUserData();
    // Provider.of<UserProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);

    userProvider.getUserData();

    return Scaffold(
      key: _key,
      drawer: _buildMyDrawer(),
      // appBar: AppBar(
      //   title: Container(
      //   height: 60,
      //   width: 60,
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage("images/logo.png")
      //       ),
      //   ),
      // ),
      //   centerTitle: true,
      //   elevation: 0.0,
      //   backgroundColor: Colors.grey[100],
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.menu,
      //       color: Colors.black,
      //       size: 34,
      //     ),
      //     onPressed: () {
      //       _key.currentState.openDrawer();
      //     },
      //   ),
      // ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: primaryColor,
                            size: 34,
                          ),
                          onPressed: () {
                            _key.currentState.openDrawer();
                          },
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: Container(
                        //     height: 60,
                        //     width: 40,
                        //     decoration: BoxDecoration(
                        //       image: DecorationImage(
                        //         image: AssetImage("images/logo.png"),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        IconButton(
                          icon: Icon(
                            Icons.notifications,
                            color: primaryColor,
                            size: 24,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 30),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: double.infinity,
                    // color: Colors.blue,
                    child: _firstSection(),
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: double.infinity,
                      // color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) => Book()));
                                  },
                                  child: _buildCards("Book Now", () {
                                    // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ))
                                  }, Icons.book_online),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) => Tracking()));
                                  },
                                  child: _buildCards("Tracking", () {
                                    // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ))
                                  }, Icons.track_changes_outlined),
                                ),
                              ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       flex: 1,
                          //       child: _buildCards("Rates", () {
                          //         // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ))
                          //       }, Icons.money),
                          //     ),
                          //     Expanded(
                          //       flex: 1,
                          //       child: _buildCards("NearBy", () {
                          //         // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ))
                          //       }, Icons.near_me),
                          //     ),
                          //   ],
                          // ),
                        ],
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Reviews",
                          color: primaryColor,
                          size: 30,
                          weight: FontWeight.w500,
                        ),
                        //
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Stack(
                        children: [
                          Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset("images/bg_2.jpeg")),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: Colors.yellow[700],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.star,
                                            color: Colors.yellow[900],
                                            size: 20,
                                          ),
                                        ),
                                        Text("4.5"),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned.fill(
                              child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                gradient: LinearGradient(
                                  //where the Linear gradient begins and ends
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  //Add one stop for each color. Stops should increase from
                                  colors: [
                                    //Colors are easy thanks to Flutter colors class
                                    Colors.black.withOpacity(0.8),
                                    Colors.black.withOpacity(0.7),
                                    Colors.black.withOpacity(0.6),
                                    Colors.black.withOpacity(0.6),
                                    Colors.black.withOpacity(0.4),
                                    Colors.black.withOpacity(0.1),
                                    Colors.black.withOpacity(0.05),
                                    Colors.black.withOpacity(0.025),
                                  ],
                                ),
                              ),
                            ),
                          )),
                          Positioned.fill(
                              child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(12, 8, 8, 8),
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: "Reviews \n",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                      TextSpan(
                                          text: "about \n",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white)),
                                      TextSpan(
                                        text: "Us",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      )
                                    ], style: TextStyle(color: Colors.black))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: "Check it \n out.",
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white))
                                      ], style: TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: CallNumberButton(
        phoneNumber: "+234 90 39884103",
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: primaryColor,
      //   child: Icon(Icons.phone),
      //   onPressed: () {
      //     UrlLauncher.launch('tel://+2349036926557');
      //   },
      // ),
    );
  }
}
