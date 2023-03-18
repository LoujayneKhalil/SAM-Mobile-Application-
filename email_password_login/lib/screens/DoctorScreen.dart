// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, unused_local_variable, prefer_const_constructors

// import 'package:email_password_login/screens/HealthReading.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_password_login/model/user_model.dart';
import 'package:email_password_login/screens/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:email_password_login/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HealthReading.dart';

// import 'HealthReading.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({Key? key}) : super(key: key);

  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // to get size
    var size = MediaQuery.of(context).size;

    // style
    var cardTextStyle = const TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));

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
                  ]))),
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
                          width: 40,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Doctor',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontFamily: "Montserrat Regular"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${loggedInUser.firstName} ${loggedInUser.secondName}",
                              style: TextStyle(
                                  fontFamily: "Montserrat Medium",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 40),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                          width: 500,

                          //Patient 1
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: ListTile(
                              title: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HealthScreen()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilePage()));
                                        },
                                        child: Material(
                                          elevation: 30,
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          child: CircleAvatar(
                                            radius: 35,
                                            backgroundColor: Color.fromARGB(
                                                255, 0, 107, 152),
                                            child: CircleAvatar(
                                              radius: 32,
                                              backgroundImage: AssetImage(
                                                  'assets/images/avatar.jpeg'),
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    Text(
                                      'Loujayne Khalil',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Color.fromARGB(255, 0, 107, 152),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            elevation: 10,
                            shadowColor: Color.fromARGB(255, 202, 225, 255),
                            margin: EdgeInsets.only(left: 10, right: 10),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 100,
                          width: 500,

                          //Patient 2 => Dummy
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: ListTile(
                              title: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HealthScreen()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Navigator.of(context).pushReplacement(
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             ProfilePage()));
                                        },
                                        child: Material(
                                          elevation: 30,
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          child: CircleAvatar(
                                            radius: 35,
                                            backgroundColor: Color.fromARGB(
                                                255, 0, 107, 152),
                                            child: CircleAvatar(
                                              radius: 32,
                                              backgroundImage: AssetImage(
                                                  'assets/images/avatar.jpeg'),
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    Text(
                                      'Ahmed Marwan',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Color.fromARGB(255, 0, 107, 152),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            elevation: 10,
                            shadowColor: Color.fromARGB(255, 202, 225, 255),
                            margin: EdgeInsets.only(left: 10, right: 10),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 100,
                          width: 500,

                          //Patient 3 => Dummy
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: ListTile(
                              title: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HealthScreen()));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HealthScreen()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Navigator.of(context).pushReplacement(
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             ProfilePage()));
                                        },
                                        child: Material(
                                          elevation: 30,
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          child: CircleAvatar(
                                            radius: 35,
                                            backgroundColor: Color.fromARGB(
                                                255, 0, 107, 152),
                                            child: CircleAvatar(
                                              radius: 32,
                                              backgroundImage: AssetImage(
                                                  'assets/images/avatar.jpeg'),
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    Text(
                                      'Sarah Mohamed',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Color.fromARGB(255, 0, 107, 152),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            elevation: 10,
                            shadowColor: Color.fromARGB(255, 202, 225, 255),
                            margin: EdgeInsets.only(left: 10, right: 10),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 100,
                          width: 500,

                          //Patient 4 => Dummy

                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: ListTile(
                              title: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HealthScreen()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Navigator.of(context).pushReplacement(
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             ProfilePage()));
                                        },
                                        child: Material(
                                          elevation: 30,
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          child: CircleAvatar(
                                            radius: 35,
                                            backgroundColor: Color.fromARGB(
                                                255, 0, 107, 152),
                                            child: CircleAvatar(
                                              radius: 32,
                                              backgroundImage: AssetImage(
                                                  'assets/images/avatar.jpeg'),
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    Text(
                                      'Mark Samy',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Color.fromARGB(255, 0, 107, 152),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            elevation: 10,
                            shadowColor: Color.fromARGB(255, 202, 225, 255),
                            margin: EdgeInsets.only(left: 10, right: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ActionChip(
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                      label: const Text("Logout"),
                      elevation: 20,
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
