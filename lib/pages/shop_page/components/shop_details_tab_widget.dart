import 'package:flutter/material.dart';
import 'package:stockallagent/main.dart';

class ShopDetailsTabWidget extends StatelessWidget {
  final String body;
  final String title;
  final Function()? action;
  final bool? isCopy;
  const ShopDetailsTabWidget({
    super.key,
    required this.body,
    required this.title,
    this.action,
    this.isCopy,
  });

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme();
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.grey.shade100,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(3),
          mouseCursor: action != null
              ? SystemMouseCursors.click
              : null,
          onTap: action,
          child: Container(
            height: 70,
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 8,
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 3,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:
                            theme.mobileTexts.b5.fontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade400,
                      ),
                      title.toUpperCase(),
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: 0,
                          child: Icon(
                            size: 15,
                            Icons.arrow_forward_ios_rounded,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: theme
                                  .mobileTexts
                                  .b3
                                  .fontSize,
                              color: Colors.grey.shade700,
                            ),
                            body,
                          ),
                        ),
                        Opacity(
                          opacity: action != null ? 1 : 0,
                          child: Icon(
                            size: 15,
                            isCopy == true
                                ? Icons.copy
                                : Icons
                                      .arrow_forward_ios_rounded,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
