

import 'package:fitness_app/extra_file/finalpage.dart';
import 'package:fitness_app/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class NextPage extends StatefulWidget {
  NextPage({Key? key, this.excercisesModel}) : super(key: key);

  ExcercisesModel? excercisesModel;
  @override
  State<NextPage> createState() => _nextPageState();
}

class _nextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Image.network(
          "${widget.excercisesModel!.thumbnail}",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),Positioned(
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
          bottom: 20,
          child: Column(
            children: [

              SleekCircularSlider(
                  innerWidget: (value) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${second.toStringAsFixed(0)}S",
                        style:
                            TextStyle(color: Colors.pinkAccent, fontSize: 30),
                      ),
                    );
                  },
                  min: 3,
                  max: 60,
                  initialValue: second,
                  appearance: CircularSliderAppearance(
                    customColors: CustomSliderColors(
                        progressBarColor: Colors.yellow,
                        dotColor: Color.fromARGB(255, 243, 6, 85)),
                  ),
                  onChange: (double value) {
                    setState(() {
                      second = value;
                    });
                  }),
              Container(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FinalPage(
                                  excercisesModel: widget.excercisesModel,
                                  second: second.toInt(),
                                )));
                  },
                  color: Colors.yellow,
                  child: Text("Start"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  double second = 3;
}
