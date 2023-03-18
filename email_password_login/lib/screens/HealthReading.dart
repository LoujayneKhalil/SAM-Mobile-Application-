// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({Key? key}) : super(key: key);

  @override
  _HealthScreenState createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen>
    with SingleTickerProviderStateMixin {
  bool values = true;
  var _HeartText = '     ';
  var _Spo2Text = '     ';
  var _TempText = '     ';
  var _BPUpperText = '     ';
  var _BPLowerText = '     ';
  late StreamSubscription _HRateStream;
  late StreamSubscription _SpO2Stream;
  late StreamSubscription _TempStream;
  late StreamSubscription _BPUpperStream;
  late StreamSubscription _BPLowerStream;

  late TextEditingController _bpupperController, _bplowerController;
  final dbRef = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    _bpupperController = TextEditingController();
    _bplowerController = TextEditingController();
  }

  onUpdate() {
    _HRateStream = dbRef
        .child('UsersData/WWiZjPPTcGS4BFjgnWsNw9GNHJf1/heartRate/int')
        .onValue
        .listen((event) {
      final Object? HR = event.snapshot.value;
      _SpO2Stream = dbRef
          .child('UsersData/WWiZjPPTcGS4BFjgnWsNw9GNHJf1/spo2/int')
          .onValue
          .listen((event) {
        final Object? spo2 = event.snapshot.value;
        _TempStream = dbRef
            .child('UsersData/WWiZjPPTcGS4BFjgnWsNw9GNHJf1/temperature/int')
            .onValue
            .listen((event) {
          final Object? temp = event.snapshot.value;
          _BPUpperStream =
              dbRef.child('Data/BloodPressure/Upper').onValue.listen((event) {
            final Object? BPU = event.snapshot.value;
            _BPLowerStream =
                dbRef.child('Data/BloodPressure/Lower').onValue.listen((event) {
              final Object? BPL = event.snapshot.value;

              setState(() {
                values = values;

                _HeartText = ' $HR';
                _Spo2Text = ' $spo2';
                _TempText = ' $temp';
                _BPUpperText = '$BPU/';
                _BPLowerText = '$BPL';
              });
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 174, 185),
      body: StreamBuilder(
          stream: dbRef.child("Data").onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                !snapshot.hasError &&
                snapshot.data != null) {
              return ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 5.0, left: 10.0, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new),
                          color: Colors.white,
                          iconSize: 30,
                          onPressed: () {
                            // Navigator.of(context).pushReplacement(
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             const DoctorScreen()));
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          iconSize: 30,
                          color: Colors.white,
                          onPressed: () {
                            OpenDialog();
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text('Today',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 50.0)),
                        SizedBox(width: 10.0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 615,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60.0),
                          topRight: Radius.circular(60)),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 40.0, left: 40, right: 40),
                      child: Container(
                        height: 100,
                        width: 50,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              topRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50)),
                        ),
                        child: Stack(
                          children: [
                            //BPM
                            Positioned(
                                child: Container(
                              height: 100,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 10, 162, 198),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40),
                                    bottomLeft: Radius.circular(40),
                                    bottomRight: Radius.circular(40)),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 37.0),
                                    child: SizedBox(
                                      width: 80,
                                      child: Image.asset("images/bpm.png"),
                                    ),
                                  ),
                                  Text(
                                    '  $_HeartText',
                                    style: const TextStyle(
                                      fontSize: 70,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "  bpm", //dummy
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            )),

                            // //SpO2
                            Padding(
                              padding: const EdgeInsets.only(top: 125),
                              child: Positioned(
                                  child: Container(
                                height: 100,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 50, 182, 168),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40.0),
                                      topRight: Radius.circular(40),
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(40)),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 40.0),
                                      child: SizedBox(
                                        width: 75,
                                        child: Image.asset("images/spo2.png"),
                                      ),
                                    ),
                                    Text(
                                      '  $_Spo2Text',
                                      style: const TextStyle(
                                          fontSize: 70,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "  %", //dummy
                                      style: TextStyle(
                                        fontSize: 60,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                            ),

                            // //Temperature
                            Padding(
                              padding: const EdgeInsets.only(top: 250),
                              child: Container(
                                height: 100,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 0, 207, 210),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40.0),
                                      topRight: Radius.circular(40),
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(40)),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 37.0),
                                      child: SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: Image.asset("images/temp.png"),
                                      ),
                                    ),
                                    Text(
                                      '  $_TempText',
                                      style: const TextStyle(
                                          fontSize: 70,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "  °C", // dummy
                                      style: TextStyle(
                                        fontSize: 60,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            //Blood Pressure
                            Padding(
                              padding: const EdgeInsets.only(top: 375),
                              child: Positioned(
                                  child: Container(
                                height: 100,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 63, 202, 188),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40.0),
                                      topRight: Radius.circular(40),
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(40)),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 45.0),
                                      child: SizedBox(
                                        height: 100,
                                        width: 65,
                                        child: Image.asset(
                                            "images/bloodpressure.png"),
                                      ),
                                    ),
                                    Text(
                                      ' $_BPUpperText',
                                      style: const TextStyle(
                                          fontSize: 56,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      _BPLowerText,
                                      style: const TextStyle(
                                          fontSize: 45,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "  mmHg",
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                            ),

                            // ON_OFF
                            Padding(
                              padding: const EdgeInsets.only(top: 500),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FloatingActionButton.extended(
                                      onPressed: () {
                                        onUpdate();
                                        writeData();
                                      },
                                      label: values
                                          ? const Text("ON")
                                          : const Text("OFF"),
                                      elevation: 20,
                                      backgroundColor: const Color.fromARGB(
                                          255, 8, 174, 185),
                                      icon: values
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return const Center(
              child: SizedBox(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
                height: 50,
                width: 50,
              ),
            );
          }),
    );
  }

  @override
  void deactivate() {
    _HRateStream.cancel();
    _SpO2Stream.cancel();
    _TempStream.cancel();
    _BPUpperStream.cancel();
    _BPLowerStream.cancel();
    super.deactivate();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('_HeartText', _HeartText));
    properties.add(StringProperty('_TempText', _TempText));
    properties.add(StringProperty('_Spo2Text', _Spo2Text));
    properties.add(StringProperty('_BPUpperText', _BPUpperText));
    properties.add(StringProperty('_BPLowerText', _BPLowerText));
  }

  Future<void> writeData() async {
    dbRef.child("LightState").set({"switch": !values});
  }

  void updateBP() async {
    Object BPU = _bpupperController.text;
    Object BPL = _bplowerController.text;

    Map<String, dynamic> BloodPressure = {
      'Upper': BPU,
      'Lower': BPL,
    };

    dbRef.child("Data/BloodPressure").update(BloodPressure).then((value) {
      Navigator.pop(context);
    });
  }

  Future OpenDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Blood Pressure'),
            content: Container(
              width: 200,
              height: 150,
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _bpupperController,
                    decoration: InputDecoration(
                        labelText: 'Upper Value',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _bplowerController,
                    decoration: InputDecoration(
                        labelText: 'Lower Value',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    label: const Text(
                      'Submit',
                      textAlign: TextAlign.center,
                    ),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    backgroundColor: const Color.fromARGB(255, 8, 174, 185),
                    onPressed: () {
                      updateBP();
                      _bpupperController.clear();
                      _bplowerController.clear();
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ));
}
