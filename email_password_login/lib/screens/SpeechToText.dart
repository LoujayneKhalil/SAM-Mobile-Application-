// ignore_for_file: file_names, avoid_print

// ignore: import_of_legacy_library_into_null_safe
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'HomeScreen.dart';
import 'TextToSpeech.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({Key? key}) : super(key: key);

  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final Map<String, HighlightedWord> _highlights = {
    'Ahmed': HighlightedWord(
        onTap: () => print('Ahmed'),
        textStyle: const TextStyle(
          color: Colors.purple,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        )),
    'voice': HighlightedWord(
        onTap: () => print('voice'),
        textStyle: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        )),
    'danger': HighlightedWord(
        onTap: () => print('danger'),
        textStyle: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        )),
    'calling': HighlightedWord(
        onTap: () => print('calling'),
        textStyle: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        )),
    'exercise': HighlightedWord(
        onTap: () => print('exercise'),
        textStyle: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        )),
  };

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
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
                      icon: const Icon(Icons.volume_up),
                      iconSize: 40,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const TtsScreen()));
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
                    Text('Speech to Text',
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
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(40.0, 50.0, 30.0, 30.0),
                    child: TextHighlight(
                      text: _text,
                      words: _highlights,
                      textStyle: const TextStyle(
                        fontSize: 26.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: AvatarGlow(
            animate: _isListening,
            glowColor: Theme.of(context).primaryColor,
            endRadius: 100.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: true,
            child: Container(
              margin: const EdgeInsets.all(20),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: const Color.fromARGB(255, 6, 163, 163),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    onPressed: _listen,
                    child: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // body: ListView(
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.only(top: 15.0, left: 10.0),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: <Widget>[
          //           IconButton(
          //             icon: const Icon(Icons.arrow_back_ios_new),
          //             color: Colors.white,
          //             onPressed: () {
          //               Navigator.of(context).pushReplacement(MaterialPageRoute(
          //                   builder: (context) => const HomeScreen()));
          //             },
          //           ),
          //           IconButton(
          //             icon: const Icon(Icons.volume_up),
          //             iconSize: 40,
          //             color: Colors.white,
          //             onPressed: () {
          //               Navigator.of(context).pushReplacement(MaterialPageRoute(
          //                   builder: (context) => const TtsScreen()));
          //             },
          //           ),
          //         ],
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 100.0),
          //       child: Row(
          //         children: const <Widget>[
          //           Text('Speech to Text',
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                   fontFamily: 'Montserrat',
          //                   color: Colors.white,
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 50.0)),
          //           SizedBox(width: 10.0),
          //         ],
          //       ),
          //     ),
          //     const SizedBox(height: 40),
          //     Container(
          //       height: 680,
          //       decoration: const BoxDecoration(
          //         color: Colors.white,
          //         borderRadius:
          //             BorderRadius.only(topLeft: Radius.circular(75.0)),
          //       ),
          //       child: SingleChildScrollView(
          //         reverse: true,
          //         child: Container(
          //           padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          //           child: TextHighlight(
          //             text: _text,
          //             words: _highlights,
          //             textStyle: const TextStyle(
          //               fontSize: 26.0,
          //               color: Colors.black,
          //               fontWeight: FontWeight.w400,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ));
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {}
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
