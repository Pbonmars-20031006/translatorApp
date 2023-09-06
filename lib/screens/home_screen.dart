import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:translator2/widgets/bottom_modalsheet.dart';
import 'package:translator2/widgets/customTextField.dart';
import 'package:translator2/api/apis.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  String text = "";
  var data;

  String selectedLanguage1 = "English";
  String selectedCode1 = "en";
  String selectedLanguage2 = "English";
  String selectedCode2 = "en";

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

  final ApiService apiService = ApiService(
    apiKey: 'e72c05246bmsh41091605a84bc8ep10028cjsna2db09285406',
    apiUrl:
        'https://google-translate1.p.rapidapi.com/language/translate/v2/languages',
  );
  Future getData() async {
    try {
      final responseData = await apiService.getData('languages');
      setState(() {
        data = responseData;
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
          child: Column(children: [
            CustomTextField(
              borderCurve: 20,
              onChanged: (String value) {
                setState(() {
                  text = value;
                });
              },
            ),
            Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: () async {
                    await getData();
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30)),
                        ),
                        builder: (context) => bottomModalSheet(
                              tittle: "From",
                              resp: data,
                              onLanguageSelected: handleLanguageSelected,
                            ));
                  },
                  child: Container(
                    height: size.height * 0.06,
                    width: size.width * 0.3,
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
                      setState(() {
                        selectedCode1 = selectedCode2;
                        selectedLanguage1 = selectedLanguage2;
                        selectedCode2 = tempCode;
                        selectedLanguage2 = tempLang;
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
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30)),
                        ),
                        builder: (context) => bottomModalSheet(
                              tittle: "From",
                              resp: data,
                              onLanguageSelected: handleLanguageSelected2,
                            ));
                  },
                  child: Container(
                    height: size.height * 0.06,
                    width: size.width * 0.3,
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
            )
          ]),
        ),
      ),
    );
  }
}
