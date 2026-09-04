import 'package:flutter/material.dart';
import 'package:stockallagent/main.dart';

void showSnackbar({
  required String message,
  required String title,
  required BuildContext context,
  required String actionResult,
}) {
  var theme = returnTheme(context: context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          border: Border.all(
            color: const Color.fromARGB(100, 158, 158, 158),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(50, 0, 0, 0),
              blurRadius: 5,
              // spreadRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    style: TextStyle(
                      fontSize:
                          theme.mobileTexts.b1.fontSize,
                      color: actionResult == 'success'
                          ? const Color.fromARGB(
                              255,
                              44,
                              148,
                              70,
                            )
                          : actionResult == 'error'
                          ? Colors.redAccent
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    "${actionResult == 'success'
                        ? '✔'
                        : actionResult == 'error'
                        ? '❌'
                        : '❔'} ${title.toUpperCase()}",
                  ),
                ),
                Opacity(
                  opacity: 0,
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      mouseCursor: SystemMouseCursors.click,
                      onTap: () {
                        // ScaffoldMessenger.of(
                        //   context,
                        // ).removeCurrentSnackBar();
                      },
                      child: Icon(Icons.clear),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    style: TextStyle(
                      fontSize:
                          theme.mobileTexts.b2.fontSize,
                      color: Colors.black,
                    ),
                    message,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
