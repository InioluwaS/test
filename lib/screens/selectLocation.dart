// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:greatdanic_logistics/models/locationPrice.dart';
// import 'package:greatdanic_logistics/provider/user_provider.dart';
// import 'package:greatdanic_logistics/shared/constants.dart';
// import 'package:greatdanic_logistics/shared/customtext.dart';
// import 'package:provider/provider.dart';

// class SelectLocation extends StatefulWidget {
//   const SelectLocation({Key key}) : super(key: key);

//   @override
//   _SelectLocationState createState() => _SelectLocationState();
// }

// LocationPrice mushin;
// LocationPrice ojo;
// LocationPrice surulere;
// LocationPrice amuwoidofin;
// LocationPrice lagosIsland;
// LocationPrice oshodiIsolo;
// LocationPrice alimosho;
// LocationPrice ikeja;
// LocationPrice apapa;
// LocationPrice kosofe;
// LocationPrice agege;
// LocationPrice ifakoIjaiye;
// LocationPrice etiOsa;
// LocationPrice ibejuLekki;
// LocationPrice ikorodu;
// LocationPrice epe;
// LocationPrice badagry;
// LocationPrice sangoOta;
// LocationPrice abeokuta;
// LocationPrice ibadan;

// class _SelectLocationState extends State<SelectLocation> {
//   UserProvider locationProvider;

//   Widget _buildLocationTile() {
//     List<LocationPrice> locationPriceData;

//     locationPriceData = locationProvider.locationPriceList;

//     return Column(
//         children: locationPriceData.map((e) {
//       return CustomText(text: e.name, size: 16, color: primaryColor);
//     }).toList());
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<LocationPrice> locationPriceData;

//     locationPriceData = locationProvider.locationPriceList;
//     locationProvider = Provider.of<UserProvider>(context);

//     locationProvider.getLocationPrices();
//     return Scaffold(
//         body: Container(
//             height: double.infinity,
//             width: double.infinity,
//             child: ListView(
//               children: [
//                 Column(
//                   children: [
//                     Container(
//                     height: MediaQuery.of(context).size.height,
//                     child: ListView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: locationPriceData.length,
//                       itemBuilder: (_, index) {
//                         return _buildLocationTile();
//                       },
//                     ),
//                   )
//                   ],
//                 ),
//                 Center(
//                   child: _buildLocationTile(),
//                 )
//               ],
//             )));
//   }
// }
