// ignore_for_file: file_names

import 'package:email_password_login/screens/HomeScreen.dart';
import 'package:email_password_login/screens/SpeechToText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/foundation.dart';

enum TtsState { playing, stopped }

class TtsScreen extends StatefulWidget {
  const TtsScreen({Key? key}) : super(key: key);

  @override
  _TtsState createState() => _TtsState();
}

class _TtsState extends State<TtsScreen> {
  late FlutterTts flutterTts;
  dynamic languages;
  String? language;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  late String _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    _getLanguages();

    flutterTts.setStartHandler(() {
      setState(() {
        if (kDebugMode) {
          print("playing");
        }
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        if (kDebugMode) {
          print("Complete");
        }
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        if (kDebugMode) {
          print("error: $msg");
        }
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    // if (kDebugMode) {
    //   print("Available languages $languages");
    // }
    if (languages != null) setState(() => languages);
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText.isNotEmpty) {
      var result = await flutterTts.speak(_newVoiceText);
      if (result == 1) setState(() => ttsState = TtsState.playing);
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  List<DropdownMenuItem<String>> getLanguageDropDownMenuItems() {
    var items = <DropdownMenuItem<String>>[];
    for (String type in languages) {
      items.add(DropdownMenuItem(value: type, child: Text(type)));
    }
    return items;
  }

  void changedLanguageDropDownItem(selectedType) {
    setState(() {
      language = selectedType;
      flutterTts.setLanguage(language!);
    });
  }

  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
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
                            builder: (context) => const HomeScreen()));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.mic),
                      iconSize: 40,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const SpeechScreen()));
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
                    Text('Text to Speech',
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
              const SizedBox(height: 30),
              Container(
                height: 1500,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60.0),
                      topRight: Radius.circular(60.0)),
                ),
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: [
                      const SizedBox(height: 30),
                      _inputSection(),
                      languages != null
                          ? _languageDropDownSection()
                          : const TextField(),
                      const SizedBox(height: 30),
                      _buildSliders(),
                      const SizedBox(height: 25),
                      bottomBar(),
                    ])),
              ),
            ],
          ),
        ));
  }

  Widget _inputSection() => Container(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: TextField(
        maxLines: null,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(30),
            hintText: ("Enter your Text"),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        onChanged: (String value) {
          _onChange(value);
        },
      ));

  Widget _languageDropDownSection() => Container(
      padding: const EdgeInsets.only(top: 50.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(
          Icons.language,
          color: Color.fromARGB(255, 53, 140, 146),
          size: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(25)),
            child: DropdownButton(
              hint: const Text("    Select a Language"),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              iconSize: 40,
              underline: const SizedBox(),
              value: language,
              items: getLanguageDropDownMenuItems(),
              onChanged: changedLanguageDropDownItem,
            ),
          ),
        ),
      ]));

  Widget _buildSliders() {
    return Column(
      children: [_volume(), _pitch(), _rate()],
    );
  }

  Widget _volume() {
    return Center(
        child: Column(children: [
      const Text(
        'Volume ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      Slider(
          value: volume,
          onChanged: (newVolume) {
            setState(() => volume = newVolume);
          },
          min: 0.0,
          max: 10.0,
          divisions: 10,
          label: "Volume: $volume")
    ]));
  }

  Widget _pitch() {
    return Center(
        child: Column(children: [
      const Text(
        'Pitch ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.left,
      ),
      Slider(
        value: pitch,
        onChanged: (newPitch) {
          setState(() => pitch = newPitch);
        },
        min: 0.5,
        max: 2.0,
        divisions: 15,
        label: "Pitch: $pitch",
        activeColor: const Color.fromARGB(255, 241, 28, 74),
      ),
    ]));
  }

  Widget _rate() {
    return Center(
      child: Column(
        children: [
          const Text(
            'Rate ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Slider(
            value: rate,
            onChanged: (newRate) {
              setState(() => rate = newRate);
            },
            min: 0.0,
            max: 2.0,
            divisions: 4,
            label: rate.round().toString(),
            activeColor: const Color.fromARGB(255, 6, 163, 111),
          ),
        ],
      ),
    );
  }

  bottomBar() => Container(
        margin: const EdgeInsets.all(20.0),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
              onPressed: _speak,
              child: const Icon(Icons.play_arrow),
              backgroundColor: const Color.fromARGB(255, 8, 174, 185),
            ),
            FloatingActionButton(
              onPressed: _stop,
              backgroundColor: const Color.fromARGB(255, 241, 28, 74),
              child: const Icon(Icons.stop),
            ),
          ],
        ),
      );
}
