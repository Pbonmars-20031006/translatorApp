import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.onChanged,
    required this.onTextChanged,
    this.autofocus = false,
    this.validator,
    this.label = '',
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.enabled = true,
    this.initialText,
    this.maxLength,
    this.obscureText = false,
    this.leadingIcon,
    this.borderColor,
    this.maxLines = 1,
    this.suffixIcon,
    this.showHelper = true,
    this.expanded = false,
    this.labelStyle,
    this.floatingLabelBehavior,
    this.fillColor,
    this.style,
    this.borderCurve,
    this.cursorcolor,
    this.autoCorrect = false,
    this.enblsug = false,
  }) : super(key: key);
  final Function onChanged;
  final Function? validator;
  final String label;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final AutovalidateMode autovalidateMode;
  final bool enabled;
  final String? initialText;
  final int? maxLength;
  final bool obscureText;
  final Widget? leadingIcon;
  final Color? borderColor;
  final int maxLines;
  final IconButton? suffixIcon;
  final bool showHelper;
  final bool expanded;
  final TextStyle? labelStyle;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final Color? fillColor;
  final TextStyle? style;
  final double? borderCurve;
  final Color? cursorcolor;
  final bool autoCorrect;
  final bool enblsug;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    if (width > height) {
      width = height;
    }
    return Container(
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
          autofocus: autofocus,
          autocorrect: autoCorrect,
          enableSuggestions: enblsug,
          //textDirection: TextDirection.ltr,
          textAlignVertical: TextAlignVertical.top,
          cursorColor: cursorcolor,
          maxLines: expanded ? null : maxLines,
          expands: expanded,
          style: style ?? TextStyle(color: Colors.white, fontSize: 18),
          obscureText: obscureText,
          enabled: enabled,
          maxLength: maxLength,
          initialValue: initialText,
          autovalidateMode: autovalidateMode,
          textInputAction: textInputAction,
          decoration: InputDecoration(
              hintText: 'Text Translation',
              hintStyle:
                  TextStyle(color: Color(0xff72767a), fontFamily: "nunito"),
              contentPadding: EdgeInsets.fromLTRB(5.0, 10, 5.0, 10),
              isDense: true,
              floatingLabelBehavior:
                  floatingLabelBehavior ?? FloatingLabelBehavior.auto,
              prefixIcon: leadingIcon,
              fillColor: fillColor ?? Colors.transparent,
              helperText: showHelper ? null : '  ',
              helperStyle: TextStyle(color: Colors.amber),
              counterText: showHelper ? null : "   ",
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderCurve ?? 10.0),
                borderSide: BorderSide(color: borderColor ?? Color(0xff72767a)),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderCurve ?? 10.0),
                borderSide: BorderSide(
                    color: borderColor ?? Color(0xff72767a).withOpacity(0.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderCurve ?? 10.0),
                borderSide: BorderSide(color: borderColor ?? Color(0xff72767a)),
              ),
              labelText: label,
              labelStyle: labelStyle ??
                  (borderColor == null
                      ? null
                      : const TextStyle(color: Colors.white)),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff72767a))),
              suffixIcon: suffixIcon),
          keyboardType: keyboardType,
          validator: (value) {
            if (validator == null) {
              return null;
            } else {
              String? message = validator!(value);
              return message;
            }
          },
          onChanged: (value) {
            onChanged(value);
            onTextChanged(value);
          },
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus),
    );
  }

  final Function(String) onTextChanged;
}
