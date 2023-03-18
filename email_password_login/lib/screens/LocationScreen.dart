// ignore_for_file: file_names, avoid_print, non_constant_identifier_names, avoid_unnecessary_containers

// ignore: import_of_legacy_library_into_null_safe

import 'dart:async';

import 'package:email_password_login/screens/FamilyScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher_string.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with SingleTickerProviderStateMixin {
  var defaultText = const TextStyle(color: Colors.black);
  var linkText = const TextStyle(color: Colors.blue);

  bool messvalue = true;
  var _Longitudetext = '0.0000';
  var _Latitudetext = '0.0000';

  late StreamSubscription _LongitudeStream;
  late StreamSubscription _LatitudeStream;

  @override
  void initState() {
    super.initState();
  }

  final dbRef = FirebaseDatabase.instance.reference();

  onUpdate() {
    _LongitudeStream = dbRef
        .child('UsersData/WWiZjPPTcGS4BFjgnWsNw9GNHJf1/longitude/float')
        .onValue
        .listen((event) {
      final Object? long = event.snapshot.value;

      _LatitudeStream = dbRef
          .child('UsersData/WWiZjPPTcGS4BFjgnWsNw9GNHJf1/latitude/float')
          .onValue
          .listen((event) {
        final Object? lat = event.snapshot.value;

        setState(() {
          messvalue = !messvalue;
          _Longitudetext = '$long';
          _Latitudetext = '$lat';
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 8, 174, 185),
          body: ListView(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 10.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const FamilyScreen()));
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text('Location',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0)),
                    SizedBox(width: 10.0),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                alignment: Alignment.center,
                height: 612,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60.0),
                      topRight: Radius.circular(60.0)),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 300,
                                  width: 425,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(20),
                                  margin: const EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/map.png'),
                                          fit: BoxFit.fitHeight),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5),
                                      ]),
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 65, right: 65),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5),
                                        ]),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              style: linkText,
                                              text:
                                                  "https://maps.google.com/?q=$_Latitudetext,$_Longitudetext",
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () async {
                                                  var url =
                                                      "https://maps.google.com/?q=$_Latitudetext,$_Longitudetext";
                                                  if (await canLaunchUrlString(
                                                      url)) {
                                                    await launchUrlString(url);
                                                  } else {
                                                    throw "Cannot load the Location";
                                                  }
                                                }),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FloatingActionButton.extended(
                                onPressed: () {
                                  onUpdate();
                                },
                                label: const Text("Receive Location"),
                                elevation: 20,
                                backgroundColor:
                                    const Color.fromARGB(255, 8, 174, 185),
                                icon: messvalue
                                    ? const Icon(Icons.location_on_sharp)
                                    : const Icon(Icons.visibility_off)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void deactivate() {
    _LongitudeStream.cancel();
    _LatitudeStream.cancel();
    super.deactivate();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('_Longitudetext', _Longitudetext));
    properties.add(StringProperty('_Latitudetext', _Latitudetext));
  }
}
