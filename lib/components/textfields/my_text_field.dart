import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stockallagent/main.dart';

class MyTextFieldMain extends StatefulWidget {
  final String? validatorText;
  final String? title;
  final TextEditingController controller;
  final bool isEmail;
  final bool showTitle;
  final bool isNumber;
  final String hintText;
  final bool isOptional;
  final bool isPassword;
  final Function(String value)? onSubmit;
  final Function(String value)? onChange;
  final int? lines;
  final bool? autoFocus;

  const MyTextFieldMain({
    super.key,
    this.validatorText,
    required this.controller,
    required this.isEmail,
    required this.showTitle,
    required this.isNumber,
    required this.isOptional,
    required this.hintText,
    this.title,
    required this.isPassword,
    this.onSubmit,
    this.onChange,
    this.lines,
    this.autoFocus,
  });

  @override
  State<MyTextFieldMain> createState() =>
      _MyTextFieldMainState();
}

class _MyTextFieldMainState extends State<MyTextFieldMain> {
  bool hideText = true;
  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.showTitle,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                style: TextStyle(
                  fontSize: theme.mobileTexts.b3.fontSize,
                  fontWeight: FontWeight.bold,
                ),
                '${widget.title}${widget.isOptional ? ' (Optional)' : '*'}',
              ),
              SizedBox(height: 2),
            ],
          ),
        ),
        TextFormField(
          autofocus: widget.autoFocus ?? false,
          onChanged: widget.onChange,
          maxLines: widget.lines ?? 1,
          onFieldSubmitted: widget.onSubmit,
          obscureText: widget.isPassword ? hideText : false,
          keyboardType: widget.isNumber
              ? TextInputType.number
              : widget.isEmail
              ? TextInputType.emailAddress
              : TextInputType.text,
          enableSuggestions: widget.isPassword
              ? false
              : true,
          inputFormatters: widget.isNumber
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          textCapitalization:
              widget.isEmail || widget.isPassword
              ? TextCapitalization.none
              : TextCapitalization.words,
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: widget.isPassword
                ? InkWell(
                    mouseCursor: SystemMouseCursors.click,
                    onTap: () {
                      setState(() {
                        hideText = !hideText;
                      });
                    },
                    child: Icon(
                      size: 20,
                      hideText
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  )
                : null,
            hintText:
                "${widget.hintText}${widget.isOptional ? '' : "*"}",
            hintStyle: TextStyle(
              fontSize: theme.mobileTexts.b2.fontSize,
            ),
            isCollapsed: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (widget.isOptional) {
              return null;
            } else {
              if (value != null && value.isNotEmpty) {
                return null;
              } else {
                return widget.validatorText;
              }
            }
          },
        ),
      ],
    );
  }
}
