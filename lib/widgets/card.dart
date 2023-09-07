import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../themes/language_data.dart';

class customCard extends StatelessWidget {
  customCard({Key? key, required this.title}) : super(key: key);
  final String? title;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: size.width * 0.1,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.07),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: AutoSizeText(
            "${LanguageData.languageMap['$title']}",
            style: TextStyle(
                color: Colors.white, fontFamily: 'nunito', fontSize: 15),
          ),
        ),
      ),
    );
  }
}
