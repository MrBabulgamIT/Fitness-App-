import 'dart:async';


import 'package:audioplayers/audioplayers.dart';
import 'package:fitness_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FinalPage extends StatefulWidget {
  FinalPage({Key? key, this.excercisesModel, this.second}) : super(key: key);
  ExcercisesModel? excercisesModel;
  int? second;

  @override
  State<FinalPage> createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  late Timer timer;
  bool isComplete = false;
  bool isPlaying = false;
  String path = "audio.mp3";
  int startSound = 0;

  void playAudio() async {
    print("doneeeeeeee");
  }

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == widget.second) {
        timer.cancel();
        setState(() {
          isComplete = true;
          playAudio();
          Navigator.pop(context);
        });
      }
      setState(() {
        startSound = timer.tick;
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Image.network(
              "${widget.excercisesModel!.gif}",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.topLeft,
                child: MaterialButton(onPressed: (){
                  Navigator.pop(context);
                },
                    child: Icon(Icons.arrow_back,size: 40,color: Colors.orange,)),
              ),),
            Positioned(
                left: 0,
                right: 0,
                bottom: 30,
                child: Center(
                    child: Text(
                  "${startSound}/${widget.second}",
                  style: TextStyle(fontSize: 40),
                ))),
          ],
        ),
      ),
    );
  }
}
