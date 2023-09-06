import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../themes/language_data.dart';

class customCard extends StatelessWidget {
  customCard({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.07)),
        child: Center(
          child: AutoSizeText(
            "${LanguageData.languageMap['$title']}",
            style: TextStyle(
                color: Colors.white, fontFamily: 'nunito', fontSize: 25),
          ),
        ),
      ),
    );
  }
}
