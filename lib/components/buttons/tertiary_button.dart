import 'package:flutter/material.dart';
import 'package:stockallagent/main.dart';

class TertiaryButton extends StatelessWidget {
  final String title;
  final Function()? action;
  final bool? isLoading;

  const TertiaryButton({
    super.key,
    required this.title,
    this.action,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.transparent,
          border: Border.all(
            color: theme.lightModeColor.prColor300,
            width: 1.3,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            action == null ? {} : action!();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),

            child: Center(
              child: Builder(
                builder: (context) {
                  if (isLoading != null &&
                      isLoading == true) {
                    return SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return Text(
                      style: TextStyle(
                        color:
                            theme.lightModeColor.prColor300,
                        fontSize:
                            theme.mobileTexts.b2.fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                      title,
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
