// ignore_for_file: file_names

import 'package:email_password_login/screens/DoctorScreen.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Profile',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "Montserrat Regular",
              ),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 6, 163, 163),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DoctorScreen()));
              }),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Loujayne Khalil",
                style: TextStyle(
                  fontSize: 40.0,
                  color: Color.fromARGB(255, 8, 70, 101),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Patient",
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 8, 70, 101),
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 20,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 40.0),
                  child: const ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.teal,
                      size: 30,
                    ),
                    title: Center(
                      child: Text(
                        "+20 01234586485",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 4, 88, 114),
                            letterSpacing: 1.0),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 20,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 40.0),
                  child: const ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.teal,
                      size: 30,
                    ),
                    title: Center(
                      child: Text(
                        "lougy.khalil@gmail.com",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 4, 88, 114),
                            letterSpacing: 1.0),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 20,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 40.0),
                  child: const ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.teal,
                      size: 30,
                    ),
                    title: Center(
                      child: Text(
                        "38 Shafeek St., New Cairo 1, Cairo, Egypt",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 4, 88, 114),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 20,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 40.0),
                  child: const ListTile(
                    leading: Icon(
                      Icons.date_range,
                      color: Colors.teal,
                      size: 30,
                    ),
                    title: Center(
                      child: Text(
                        "27/09/1952",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 4, 88, 114),
                            letterSpacing: 1.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 70),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Description',
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
              ),
              Card(
                elevation: 30,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  width: 420,
                  height: 125,
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Alzheimer's Disease \nDeaf and Dumb Patient \nSuffers from Tachycardia",
                      style: TextStyle(
                          color: Color.fromARGB(255, 4, 62, 91), fontSize: 20),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      border: Border.all(
                        width: 1.2,
                        color: const Color.fromARGB(255, 1, 109, 99),
                      )),
                ),
              )
            ],
          ),
        ));
  }
}
