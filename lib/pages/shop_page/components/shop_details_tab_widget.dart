import 'package:flutter/material.dart';
import 'package:stockallagent/main.dart';

class ShopDetailsTabWidget extends StatelessWidget {
  final String body;
  final String title;
  const ShopDetailsTabWidget({
    super.key,
    required this.body,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme();
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.grey.shade100,
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            spacing: 3,
            children: [
              Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: theme.mobileTexts.b5.fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade400,
                ),
                title.toUpperCase(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:
                            theme.mobileTexts.b3.fontSize,
                        color: Colors.grey.shade700,
                      ),
                      body,
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
}
