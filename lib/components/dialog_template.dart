import 'package:flutter/material.dart';
import 'package:stockallagent/components/buttons/primary_button.dart';
import 'package:stockallagent/components/buttons/secondary_button.dart';
import 'package:stockallagent/main.dart';

class DialogTemplate extends StatelessWidget {
  final Widget? mainWidget;
  final String? title;
  final String? subTitle;
  final String? message;
  final Function()? action;
  final String? mainActionText;
  final String? cancelActionText;

  const DialogTemplate({
    super.key,
    this.mainWidget,
    this.title,
    this.subTitle,
    this.message,
    this.action,
    this.mainActionText,
    this.cancelActionText,
  });

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        constraints: BoxConstraints(
          maxWidth: 500,
          maxHeight: 500,
        ),
        insetPadding: EdgeInsets.all(20),
        contentPadding: EdgeInsets.all(0),
        content: Container(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          width: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Visibility(
                  visible: title != null,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 200,
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:
                            theme.mobileTexts.h4.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                      title?.toUpperCase() ?? '',
                    ),
                  ),
                ),
                Visibility(
                  visible: subTitle != null,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 5),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 200,
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: theme
                                .mobileTexts
                                .b3
                                .fontSize,
                            fontWeight: FontWeight.normal,
                          ),
                          subTitle ?? '',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 2.5,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: theme.lightModeColor.secColor200,
                  ),
                ),
                SizedBox(height: 15),
                Visibility(
                  visible: message != null,
                  child: Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:
                          theme.mobileTexts.b2.fontSize,
                      fontWeight: FontWeight.normal,
                    ),
                    message ?? '',
                  ),
                ),
                mainWidget ?? Container(),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        title: cancelActionText ?? 'Cancel',
                        action: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Visibility(
                      visible: action != null,
                      child: Expanded(
                        child: PrimaryButton(
                          isLoading: returnResourceProvider(
                            context: context,
                          ).isLoading,
                          title:
                              mainActionText ?? 'Proceed',
                          action: action,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
