// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:email_password_login/screens/login_screen.dart';
import 'package:email_password_login/screens/LocationScreen.dart';
import 'package:email_password_login/screens/HealthReading.dart';

import 'package:email_password_login/model/user_model.dart';

class FamilyScreen extends StatefulWidget {
  const FamilyScreen({Key? key}) : super(key: key);

  @override
  _FamilyScreenState createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color.fromARGB(255, 82, 167, 191),
                  Color.fromARGB(255, 86, 187, 150)
                ])),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 120,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Hello, ',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Color.fromARGB(255, 235, 235, 235),
                                  fontFamily: "Montserrat Regular"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${loggedInUser.firstName} ${loggedInUser.secondName}",
                              style: const TextStyle(
                                  fontFamily: "Montserrat Medium",
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      primary: false,
                      crossAxisCount: 2,
                      children: <Widget>[
                        //Location
                        Card(
                          color: const Color.fromARGB(255, 236, 236, 236),
                          margin: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 10,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LocationScreen()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.location_on),
                                  color:
                                      const Color.fromARGB(255, 11, 122, 141),
                                  iconSize: 100,
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LocationScreen()));
                                  },
                                ),
                                const Text(
                                  '\nLocation',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                        //HealthRecordings
                        Card(
                          margin: const EdgeInsets.all(5),
                          color: const Color.fromARGB(255, 236, 236, 236),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 10,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HealthScreen()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon:
                                      const Icon(Icons.monitor_heart_outlined),
                                  color:
                                      const Color.fromARGB(255, 11, 122, 141),
                                  iconSize: 100,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HealthScreen()));
                                  },
                                ),
                                const Text(
                                  '\n Health Records',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                        //Doctor Chat
                        Card(
                          color: const Color.fromARGB(255, 236, 236, 236),
                          margin: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 10,
                          child: InkWell(
                            onTap: () {
                              // Navigator.of(context).pushReplacement(
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const LocationScreen()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.chat),
                                  color:
                                      const Color.fromARGB(255, 11, 122, 141),
                                  iconSize: 100,
                                  onPressed: () {
                                    // Navigator.of(context).pushReplacement(
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const LocationScreen()));
                                  },
                                ),
                                const Text(
                                  '\nDoctor Chat',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                        //Appointment
                        Card(
                          color: const Color.fromARGB(255, 236, 236, 236),
                          margin: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 10,
                          child: InkWell(
                            onTap: () {
                              // Navigator.of(context).pushReplacement(
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const LocationScreen()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.date_range_rounded),
                                  color:
                                      const Color.fromARGB(255, 11, 122, 141),
                                  iconSize: 100,
                                  onPressed: () {
                                    // Navigator.of(context).pushReplacement(
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const LocationScreen()));
                                  },
                                ),
                                const Text(
                                  '\nAppointment',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const Text(
                                  'Booking',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ActionChip(
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                      elevation: 20,
                      label: const Text("Logout"),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 5, 133, 133),
                      ),
                      backgroundColor: Colors.white70,
                      onPressed: () {
                        logout(context);
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
