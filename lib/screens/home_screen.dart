import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:translator2/widgets/bottom_modalsheet.dart';
import 'package:translator2/widgets/customTextField.dart';
import 'package:translator2/api/apis.dart';
import 'package:http/http.dart' as http;

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  String inputText = "Hello";
  String outputText = "Hello";
  var data;
  String userInput = "Hello";
  String selectedLanguage1 = "English";
  String selectedCode1 = "en";
  String selectedLanguage2 = "English";
  String selectedCode2 = "en";
  TextEditingController txt = TextEditingController();
  TextEditingController txt2 = TextEditingController();
  void handleLanguageSelected(String language, String code) {
    setState(() {
      selectedLanguage1 = language;
      selectedCode1 = code;
    });
  }

  void handleLanguageSelected2(String language, String code) {
    setState(() {
      selectedLanguage2 = language;
      selectedCode2 = code;
    });
  }

  void handleOutputTextChanged(String value) {
    setState(() {
      outputText = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    txt.text = "Hello";
    txt2.text = "Hello";
    super.initState();
  }

  final ApiService apiService = ApiService();
  Future getData() async {
    try {
      final responseData = await apiService.getData();
      setState(() {
        data = responseData;
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  Future fetchData(String input) async {
    try {
      final responseData =
          await apiService.fetchData(input, selectedCode1, selectedCode2);
      setState(() {
        outputText = responseData;
        txt2.text = responseData;
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          AutoSizeText(
                            "Text Translation",
                            style: TextStyle(
                                fontFamily: "nunito",
                                fontSize: 18,
                                color: Color(0xff72767a)),
                          ),
                        ],
                      ),
                      Divider(
                        color: Color(0xff72767a),
                        thickness: 1,
                        indent: size.width * 0.01,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await getData();
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                enableDrag: true,
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30)),
                                ),
                                builder: (context) => bottomModalSheet(
                                      tittle: "From",
                                      resp: data,
                                      onLanguageSelected:
                                          handleLanguageSelected,
                                    ));
                          },
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.35,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: AutoSizeText(
                                "$selectedLanguage1",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "nunito"),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              String tempLang = selectedLanguage1;
                              String tempCode = selectedCode1;
                              String tempText = txt.text;
                              setState(() {
                                selectedCode1 = selectedCode2;
                                selectedLanguage1 = selectedLanguage2;
                                selectedCode2 = tempCode;
                                selectedLanguage2 = tempLang;
                                userInput = outputText;
                                txt.text = txt2.text;
                                txt2.text = tempText;
                                //outputText = tempText;
                              });
                            },
                            icon: Icon(
                              FontAwesomeIcons.repeat,
                              color: Color(0xff72767a),
                            )),
                        GestureDetector(
                          onTap: () async {
                            await getData();
                            showModalBottomSheet(
                                enableDrag: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30)),
                                ),
                                builder: (context) => bottomModalSheet(
                                      tittle: "To",
                                      resp: data,
                                      onLanguageSelected:
                                          handleLanguageSelected2,
                                    ));
                          },
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.35,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: AutoSizeText(
                                "$selectedLanguage2",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "nunito"),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: AutoSizeText(
                    "Translate from $selectedLanguage1",
                    style: TextStyle(
                        fontFamily: "nunito",
                        fontSize: 18,
                        color: Color(0xff72767a)),
                  ),
                ),
                Container(
                  child: CustomTextField(
                    controller: txt,
                    onTextChanged: (String value) async {
                      setState(() {
                        userInput = txt.text;
                      });
                      await fetchData(userInput);
                      print(outputText);
                    },
                    //initialText: inputText,
                    onChanged: (String value) {
                      setState(() {
                        userInput = value;
                      });
                    },
                    maxLines: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: AutoSizeText(
                    "Translate to $selectedLanguage2",
                    style: TextStyle(
                        fontFamily: "nunito",
                        fontSize: 18,
                        color: Color(0xff72767a)),
                  ),
                ),
                Container(
                  child: CustomTextField(
                    controller: txt2,
                    onTextChanged: (String value) async {
                      setState(() {
                        outputText = txt2.text;
                      });
                      await fetchData(outputText);
                      print(inputText);
                    },
                    //initialText: inputText,
                    onChanged: (String value) {
                      setState(() {
                        userInput = value;
                      });
                    },
                    maxLines: 5,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
