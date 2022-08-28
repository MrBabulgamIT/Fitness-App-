import 'dart:convert';

import 'package:fitness_app/extra_file/nextpage.dart';
import 'package:fitness_app/extra_file/spinkit.dart';
import 'package:fitness_app/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ExcercisesModel> alldata = [];

  String linkApi =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";
  bool isValue = false;
  fachData() async {
    try {
      var response = await http.get(Uri.parse(linkApi));

      print("status code is ${response.statusCode}");

      if (response.statusCode == 200) {
        setState(() {
          isValue = true;
        });
        final item = jsonDecode(response.body);
        for (var data in item["exercises"]) {
          ExcercisesModel excercisesModel = ExcercisesModel(
            id: data["id"],
            title: data["title"],
            thumbnail: data["thumbnail"],
            gif: data["gif"],
            seconds: data["seconds"],
          );
          setState(() {
            alldata.add(excercisesModel);
          });
        }

        print("total lenth is ${alldata.length}");
      } else {
        showtoast("Something Is Wrong");
      }
      setState(() {
        isValue = false;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    fachData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        backgroundColor: Colors.orange,
        title: Text('Fitness App'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isValue == true,
        progressIndicator: spinkit,
        child: Container(
          width: double.infinity,
          child: ListView.builder(
            itemCount: alldata.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NextPage(
                                excercisesModel: alldata[index],
                              )));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  height: 150,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          "${alldata[index].thumbnail}",
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 65,
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.black12,
                                      Colors.black38,
                                      Colors.black87
                                    ])),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${alldata[index].id}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "${alldata[index].title}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
