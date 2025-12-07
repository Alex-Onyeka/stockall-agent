import 'package:flutter/material.dart';
import 'package:stockallagent/classes/ref_payments_class.dart';
import 'package:stockallagent/components/dialog_template.dart';
import 'package:stockallagent/components/empty_widget.dart';
import 'package:stockallagent/components/main_top_bar.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/main.dart';

class Payments extends StatefulWidget {
  final Function()? popPage;
  final Function()? profileNavAction;
  const Payments({
    super.key,
    this.profileNavAction,
    this.popPage,
  });

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  int currentSelection = 0;

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        widget.popPage!();
      },
      child: Scaffold(
        body: Column(
          children: [
            MainTopBar(
              profileNavAction: widget.profileNavAction,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                        color:
                            theme.lightModeColor.prColor300,
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Earnings:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: theme
                                  .mobileTexts
                                  .b3
                                  .fontSize,
                            ),
                          ),
                          Text(
                            formatMoney(
                              returnRefPaymentsProvider(
                                context: context,
                              ).getTotalPayments(),
                            ),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: theme
                                  .mobileTexts
                                  .h4
                                  .fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment(1.05, -1.2),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(
                            30,
                            255,
                            255,
                            255,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator.adaptive(
                onRefresh: () {
                  return returnRefPaymentsProvider(
                    context: context,
                    listen: false,
                  ).getPayments();
                },
                backgroundColor: Colors.white,
                color: theme.lightModeColor.prColor250,
                child: Builder(
                  builder: (context) {
                    if (returnRefPaymentsProvider(
                      context: context,
                    ).payments.isNotEmpty) {
                      return ListView(
                        padding: EdgeInsets.fromLTRB(
                          20,
                          10,
                          20,
                          15,
                        ),
                        children:
                            returnRefPaymentsProvider(
                                  context: context,
                                ).payments
                                .map(
                                  (pay) =>
                                      PaymentTile(pay: pay),
                                )
                                .toList(),
                      );
                    } else {
                      return ListView(
                        children: [
                          SizedBox(
                            height:
                                MediaQuery.of(
                                  context,
                                ).size.height -
                                200,
                            child: EmptyWidget(
                              isDashboard: false,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentTile extends StatelessWidget {
  final RefPaymentsClass pay;
  const PaymentTile({super.key, required this.pay});

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(5, 0, 0, 0),
                blurRadius: 5,
              ),
            ],
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return DialogTemplate(
                    cancelActionText: 'Close',
                    mainWidget: PaymentDetails(
                      paymentsClass: pay,
                    ),
                  );
                },
              );
            },
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),

              child: Row(
                spacing: 10,
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                    ),
                    child: Icon(
                      size: 18,
                      Icons.receipt_long_outlined,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      spacing: 10,
                      children: [
                        Expanded(
                          child: Text(
                            style: TextStyle(
                              fontSize: theme
                                  .mobileTexts
                                  .b1
                                  .fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                            formatMoney(pay.amount ?? 0),
                          ),
                        ),
                        Text(
                          style: TextStyle(
                            fontSize: theme
                                .mobileTexts
                                .b3
                                .fontSize,
                            fontWeight: FontWeight.normal,
                          ),
                          formatDate(pay.createdDate),
                        ),
                        Icon(
                          size: 18,
                          color: Colors.grey,
                          Icons.arrow_forward_ios_rounded,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentDetails extends StatelessWidget {
  final RefPaymentsClass paymentsClass;
  const PaymentDetails({
    super.key,
    required this.paymentsClass,
  });

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return Column(
      children: [
        Stack(
          alignment: AlignmentGeometry.xy(0, 0),
          children: [
            Text(
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                // color: theme
                //     .lightModeColor
                //     .secColor200,
              ),
              formatMoney(paymentsClass.amount ?? 0),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(
                  17,
                  255,
                  153,
                  0,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(35),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(
                    33,
                    255,
                    153,
                    0,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Divider(
            height: 25,
            color: Colors.grey.shade200,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            spacing: 10,
            children: [
              Text(
                style: TextStyle(
                  fontSize: theme.mobileTexts.b3.fontSize,
                  fontWeight: FontWeight.normal,
                ),
                'Total Stores:',
              ),
              Text(
                style: TextStyle(
                  fontSize: theme.mobileTexts.b2.fontSize,
                  fontWeight: FontWeight.bold,
                ),
                formatNumber(
                  (paymentsClass.totalStores ?? 0)
                      .toDouble(),
                ).split('.').first,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Divider(
            height: 25,
            color: Colors.grey.shade200,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            spacing: 10,
            children: [
              Text(
                style: TextStyle(
                  fontSize: theme.mobileTexts.b3.fontSize,
                  fontWeight: FontWeight.normal,
                ),
                'Total Payments:',
              ),
              Text(
                style: TextStyle(
                  fontSize: theme.mobileTexts.b2.fontSize,
                  fontWeight: FontWeight.bold,
                ),
                formatMoney(paymentsClass.monthTotal ?? 0),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Divider(
            height: 25,
            color: Colors.grey.shade200,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            spacing: 10,
            children: [
              Text(
                style: TextStyle(
                  fontSize: theme.mobileTexts.b3.fontSize,
                  fontWeight: FontWeight.normal,
                ),
                'Earning Percentage:',
              ),
              Text(
                style: TextStyle(
                  fontSize: theme.mobileTexts.b2.fontSize,
                  fontWeight: FontWeight.bold,
                ),
                '${referralCut * 100}%',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Divider(
            height: 25,
            color: Colors.grey.shade200,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            spacing: 10,
            children: [
              Text(
                style: TextStyle(
                  fontSize: theme.mobileTexts.b3.fontSize,
                  fontWeight: FontWeight.normal,
                ),
                'Date:',
              ),
              Text(
                style: TextStyle(
                  fontSize: theme.mobileTexts.b2.fontSize,
                  fontWeight: FontWeight.bold,
                ),
                formatDate(paymentsClass.createdDate),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
