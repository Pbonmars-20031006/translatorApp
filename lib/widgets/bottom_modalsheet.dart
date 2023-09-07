import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:translator2/api/apis.dart';
import 'package:translator2/widgets/card.dart';

import '../themes/language_data.dart';

class bottomModalSheet extends StatefulWidget {
  bottomModalSheet(
      {Key? key,
      required this.tittle,
      required this.resp,
      required this.onLanguageSelected})
      : super(key: key);

  final String tittle;
  final LanguageCallback onLanguageSelected;
  var resp;

  @override
  State<bottomModalSheet> createState() => _bottomModalSheetState();
}

class _bottomModalSheetState extends State<bottomModalSheet> {
  @override
  Widget build(BuildContext context) {
    //print(widget.resp);
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: ApiService().getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
                decoration: BoxDecoration(color: Colors.black),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Container(
                        height: size.height * 0.6,
                        decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(25.0),
                                topRight: const Radius.circular(25.0))),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 5, 10),
                                  child: AutoSizeText(
                                    '${widget.tittle}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'nunito',
                                        fontSize: 25),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  final language = widget.resp['data']
                                      ['languages'][index]['code'];
                                  // print("hereee $language");
                                  final languageName =
                                      LanguageData.languageMap[language];
                                  //print("hereee $languageName");
                                  return GestureDetector(
                                      onTap: () {
                                        widget.onLanguageSelected(
                                            languageName!, language);
                                        Navigator.of(context).pop();
                                      },
                                      child: customCard(
                                          title: widget.resp['data']
                                              ['languages'][index]['code']));
                                },
                                itemCount:
                                    widget.resp['data']['languages'].length,
                              ),
                            ),
                          ],
                        ))));
          } else {
            return Container(
              width: size.width * 0.1,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                strokeWidth: 4.0,
              ),
            );
          }
        });
  }
}

typedef LanguageCallback = void Function(String language, String code);
