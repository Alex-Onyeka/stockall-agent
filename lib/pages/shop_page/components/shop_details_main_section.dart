import 'package:flutter/material.dart';
import 'package:stockallagent/classes/shop_info.dart';
import 'package:stockallagent/main.dart';

class ShopDetailsMainSection extends StatefulWidget {
  const ShopDetailsMainSection({
    super.key,
    required this.shop,
    required this.widgett,
    required this.title,
  });

  final ShopInfo shop;
  final Widget widgett;
  final String title;

  @override
  State<ShopDetailsMainSection> createState() =>
      _ShopDetailsMainSectionState();
}

class _ShopDetailsMainSectionState
    extends State<ShopDetailsMainSection> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    var theme = returnTheme();
    return Ink(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(12, 0, 0, 0),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        // spacing: 5,
        children: [
          InkWell(
            mouseCursor: SystemMouseCursors.click,
            onTap: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                15.0,
                15,
                15,
                15,
              ),
              child: Row(
                spacing: 10,
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    style: TextStyle(
                      fontSize:
                          theme.mobileTexts.b2.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    '${isOpen ? 'Hide' : 'Show'} ${widget.title}',
                  ),
                  Icon(
                    size: 20,
                    isOpen
                        ? Icons
                              .keyboard_double_arrow_up_outlined
                        : Icons
                              .keyboard_double_arrow_down_outlined,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isOpen,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                15.0,
                10,
                15,
                15,
              ),
              child: widget.widgett,
            ),
          ),
        ],
      ),
    );
  }
}
