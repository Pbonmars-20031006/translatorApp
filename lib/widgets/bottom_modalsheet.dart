import 'package:flutter/material.dart';
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
    return Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final language =
                        widget.resp['data']['languages'][index]['code'];
                    // print("hereee $language");
                    final languageName = LanguageData.languageMap[language];
                    //print("hereee $languageName");
                    return GestureDetector(
                        onTap: () {
                          widget.onLanguageSelected(languageName!, language);
                          Navigator.of(context).pop();
                        },
                        child: customCard(
                            title: widget.resp['data']['languages'][index]
                                ['code']));
                  },
                  itemCount: widget.resp['data']['languages'].length,
                ))));
  }
}

typedef LanguageCallback = void Function(String language, String code);
