import 'package:flutter/material.dart';
import 'package:stockallagent/classes/user_class.dart';
import 'package:stockallagent/components/empty_widget.dart';
import 'package:stockallagent/components/main_top_bar.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/agent_page/agent_page.dart';
import 'package:stockallagent/theme/theme_provider.dart';

class Agents extends StatefulWidget {
  final Function()? popPage;
  final Function()? profileNavAction;
  const Agents({
    super.key,
    this.profileNavAction,
    this.popPage,
  });

  @override
  State<Agents> createState() => _AgentsState();
}

class _AgentsState extends State<Agents> {
  int currentSelection = 1;
  void switchSelection(int index) {
    setState(() {
      currentSelection = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      returnUserProvider().getAgents();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<UserClass> agents =
        returnUserProvider(context: context).agents
            .where(
              (item) => item.roleId == currentSelection,
            )
            .toList();
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
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(
                    41,
                    17,
                    82,
                    134,
                  ),
                ),
                child: Row(
                  children: [
                    TopStoreFilterButton(
                      mainIndex: currentSelection,
                      myIndex: 1,
                      title: 'In-House',
                      action: () {
                        switchSelection(1);
                      },
                    ),
                    TopStoreFilterButton(
                      mainIndex: currentSelection,
                      myIndex: 2,
                      title: 'Freelance',
                      action: () {
                        switchSelection(2);
                      },
                    ),
                    TopStoreFilterButton(
                      mainIndex: currentSelection,
                      myIndex: 3,
                      title: 'Installers',
                      action: () {
                        switchSelection(3);
                      },
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 10),
            Expanded(
              child: RefreshIndicator.adaptive(
                onRefresh: () {
                  return returnUserProvider().getAgents();
                },
                backgroundColor: Colors.white,
                color: theme.lightModeColor.prColor250,
                child: Builder(
                  builder: (context) {
                    if (agents.isEmpty) {
                      return EmptyWidget(
                        isDashboard: false,
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 20,
                        ),
                        child: ListView(
                          children: agents
                              .map(
                                (item) => AgentListTile(
                                  theme: theme,
                                  agent: item,
                                ),
                              )
                              .toList(),
                        ),
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

class AgentListTile extends StatelessWidget {
  const AgentListTile({
    super.key,
    required this.theme,
    required this.agent,
  });

  final ThemeProvider theme;
  final UserClass agent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AgentPage(
                    agentUuid: agent.userId!,
                  );
                },
              ),
            );
          },
          mouseCursor: SystemMouseCursors.click,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(5, 0, 0, 0),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              spacing: 5,
              children: [
                Row(
                  spacing: 5,
                  children: [
                    Icon(
                      size: 20,
                      color: Colors.amber,
                      Icons.person,
                    ),
                    Text(
                      style: TextStyle(
                        fontSize:
                            theme.mobileTexts.b3.fontSize,
                        // fontWeight:
                        //     FontWeight
                        //         .bold,
                      ),
                      "${agent.name} ${agent.lastName ?? ''}",
                    ),
                  ],
                ),
                Icon(
                  size: 20,
                  color: Colors.grey,
                  Icons.arrow_forward_ios_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class AgentTileMain extends StatefulWidget {
//   final UserClass agent;
//   final bool isAll;
//   const AgentTileMain({
//     super.key,
//     required this.agent,
//     required this.isAll,
//   });

//   @override
//   State<AgentTileMain> createState() =>
//       _AgentTileMainState();
// }

// class _AgentTileMainState extends State<AgentTileMain> {
//   @override
//   Widget build(BuildContext context) {
//     var theme = returnTheme(context: context);
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 5),
//       child: Material(
//         type: MaterialType.transparency,
//         child: Ink(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(5),
//             border: Border(
//               bottom: BorderSide(
//                 color: Colors.grey.shade100,
//               ),
//             ),
//           ),
//           child: InkWell(
//             mouseCursor: SystemMouseCursors.click,
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (dialogContext) {
//                   return StatefulBuilder(
//                     builder: (context, setState) => DialogTemplate(
//                       cancelActionText: 'Close',
//                       action:
//                           returnUserProvider(
//                                 context: context,
//                               ).isAgentPaid(
//                                 widget.agent,
//                                 context,
//                               ) ||
//                               widget.isAll
//                           ? null
//                           : () {
//                               if (returnBankProvider(
//                                     context: context,
//                                     listen: false,
//                                   ).banks
//                                   .where(
//                                     (ban) =>
//                                         ban.userId ==
//                                         widget.agent.userId,
//                                   )
//                                   .isEmpty) {
//                                 showDialog(
//                                   context: context,
//                                   builder: (confirmDialog) {
//                                     return DialogTemplate(
//                                       title:
//                                           'Bank Detailts Not Set',
//                                       message:
//                                           'This agents bank details is not set. They need to set their bank details before you can proceed with payment.',
//                                     );
//                                   },
//                                 );
//                               } else {
//                                 showDialog(
//                                   context: context,
//                                   builder: (confirmDialog) {
//                                     return DialogTemplate(
//                                       action: () async {
//                                         returnResourceProvider(
//                                           context: context,
//                                           listen: false,
//                                         ).toggleLoading(
//                                           true,
//                                         );
//                                         var payment = RefPaymentsClass(
//                                           userId: widget
//                                               .agent
//                                               .userId!,
//                                           amount:
//                                               widget
//                                                       .agent
//                                                       .role ==
//                                                   'Employed'
//                                               ? (returnSubPaymentsProvider(
//                                                       context:
//                                                           context,
//                                                       listen:
//                                                           false,
//                                                     ).getAgentsCutForMonthsPayment(
//                                                       widget
//                                                           .agent
//                                                           .referralCode!,
//                                                       widget
//                                                           .agent
//                                                           .role!,
//                                                       context,
//                                                     ) +
//                                                     getAgentsSalary(
//                                                       returnShopProvider(
//                                                             context: context,
//                                                             listen: false,
//                                                           )
//                                                           .getHeadQuaters()
//                                                           .where(
//                                                             (
//                                                               sh,
//                                                             ) =>
//                                                                 sh.refCode ==
//                                                                     widget.agent.referralCode &&
//                                                                 (sh.createdAt.isAfter(
//                                                                       monthStart(),
//                                                                     ) ||
//                                                                     sh.createdAt.isAtSameMomentAs(
//                                                                       monthStart(),
//                                                                     )),
//                                                           )
//                                                           .length,
//                                                     ))
//                                               : returnSubPaymentsProvider(
//                                                   context:
//                                                       context,
//                                                   listen:
//                                                       false,
//                                                 ).getAgentsCutForMonthsPayment(
//                                                   widget
//                                                       .agent
//                                                       .referralCode!,
//                                                   widget
//                                                       .agent
//                                                       .role!,
//                                                   context,
//                                                 ),
//                                           monthTotal:
//                                               returnSubPaymentsProvider(
//                                                 context:
//                                                     context,
//                                                 listen:
//                                                     false,
//                                               ).getAgentsTotalForMonth(
//                                                 widget
//                                                     .agent
//                                                     .referralCode!,
//                                                 context,
//                                               ),
//                                           totalStores:
//                                               returnSubPaymentsProvider(
//                                                     context:
//                                                         context,
//                                                     listen:
//                                                         false,
//                                                   )
//                                                   .getAgentsSubPaymentsList(
//                                                     context,
//                                                     widget
//                                                         .agent
//                                                         .referralCode!,
//                                                   )
//                                                   .length,
//                                         );
//                                         await returnRefPaymentsProvider(
//                                           context: context,
//                                           listen: false,
//                                         ).makePayment(
//                                           payment,
//                                         );
//                                         returnResourceProvider(
//                                           // ignore: use_build_context_synchronously
//                                           context: context,
//                                           listen: false,
//                                         ).toggleLoading(
//                                           false,
//                                         );
//                                         Navigator.of(
//                                           // ignore: use_build_context_synchronously
//                                           confirmDialog,
//                                         ).pop();
//                                       },
//                                       title:
//                                           'Are you Sure?',
//                                       message:
//                                           'Are you sure you want to proceed to pay this agent for the month?',
//                                     );
//                                   },
//                                 ).then((_) {
//                                   setState(() {});
//                                   returnResourceProvider(
//                                     // ignore: use_build_context_synchronously
//                                     context: context,
//                                     listen: false,
//                                   ).toggleLoading(false);
//                                 });
//                               }
//                             },
//                       mainActionText: "Make Payment",
//                       mainWidget: Column(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(15),
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade100,
//                               borderRadius:
//                                   BorderRadius.circular(5),
//                             ),
//                             child: Row(
//                               spacing: 10,
//                               children: [
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: Colors.amber,
//                                   ),
//                                   child: Image.asset(
//                                     profileIcon,
//                                     height: 45,
//                                   ),
//                                 ),
//                                 Column(
//                                   spacing: 1,
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment
//                                           .start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text(
//                                           textAlign:
//                                               TextAlign
//                                                   .right,
//                                           style: TextStyle(
//                                             fontSize: theme
//                                                 .mobileTexts
//                                                 .b2
//                                                 .fontSize,
//                                             fontWeight:
//                                                 FontWeight
//                                                     .bold,
//                                           ),
//                                           '${widget.agent.name} | ',
//                                         ),
//                                         Text(
//                                           textAlign:
//                                               TextAlign
//                                                   .right,
//                                           style: TextStyle(
//                                             fontSize: theme
//                                                 .mobileTexts
//                                                 .b4
//                                                 .fontSize,
//                                             fontWeight:
//                                                 FontWeight
//                                                     .bold,
//                                             color: Colors
//                                                 .grey
//                                                 .shade500,
//                                           ),
//                                           ' ${widget.agent.role?.toUpperCase()}',
//                                         ),
//                                       ],
//                                     ),
//                                     Text(
//                                       textAlign:
//                                           TextAlign.right,
//                                       style: TextStyle(
//                                         fontSize: theme
//                                             .mobileTexts
//                                             .b3
//                                             .fontSize,
//                                         color: Colors
//                                             .grey
//                                             .shade700,
//                                         fontWeight:
//                                             FontWeight
//                                                 .normal,
//                                       ),
//                                       widget.agent.email,
//                                     ),
//                                     SizedBox(height: 1),
//                                     Text(
//                                       textAlign:
//                                           TextAlign.right,
//                                       style: TextStyle(
//                                         fontSize: theme
//                                             .mobileTexts
//                                             .b3
//                                             .fontSize,
//                                         color: Colors
//                                             .grey
//                                             .shade700,
//                                         fontWeight:
//                                             FontWeight
//                                                 .normal,
//                                       ),
//                                       widget.agent.phone ??
//                                           'Phone Not Set',
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(
//                                   horizontal: 10.0,
//                                 ),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment
//                                           .spaceBetween,
//                                   spacing: 10,
//                                   children: [
//                                     Expanded(
//                                       child: AgentProfileInfo(
//                                         title:
//                                             'Total Registered',
//                                         data:
//                                             returnShopProvider(
//                                                   context:
//                                                       context,
//                                                   listen:
//                                                       false,
//                                                 )
//                                                 .getHeadQuaters()
//                                                 .where(
//                                                   (sh) =>
//                                                       sh.refCode ==
//                                                       widget
//                                                           .agent
//                                                           .referralCode,
//                                                 )
//                                                 .length
//                                                 .toStringAsFixed(
//                                                   0,
//                                                 ),
//                                       ),
//                                     ),
//                                     Container(
//                                       height: 25,
//                                       width: 1,
//                                       color: Colors
//                                           .grey
//                                           .shade100,
//                                     ),
//                                     Expanded(
//                                       child: AgentProfileInfo(
//                                         title: 'This Month',
//                                         data:
//                                             returnShopProvider(
//                                                   context:
//                                                       context,
//                                                   listen:
//                                                       false,
//                                                 )
//                                                 .getHeadQuaters()
//                                                 .where(
//                                                   (sh) =>
//                                                       sh.refCode ==
//                                                           widget.agent.referralCode &&
//                                                       (sh.createdAt.isAfter(
//                                                             monthStart(),
//                                                           ) ||
//                                                           sh.createdAt.isAtSameMomentAs(
//                                                             monthStart(),
//                                                           )),
//                                                 )
//                                                 .length
//                                                 .toStringAsFixed(
//                                                   0,
//                                                 ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Visibility(
//                                   visible:
//                                       widget.agent.role ==
//                                       'Employed',
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment
//                                                 .spaceBetween,
//                                         spacing: 10,
//                                         children: [
//                                           Expanded(
//                                             child: AgentProfileInfo(
//                                               title:
//                                                   'Week 1',
//                                               data:
//                                                   returnShopProvider(
//                                                         context:
//                                                             context,
//                                                         listen:
//                                                             false,
//                                                       )
//                                                       .getHeadQuaters()
//                                                       .where(
//                                                         (
//                                                           sh,
//                                                         ) =>
//                                                             sh.refCode ==
//                                                                 widget.agent.referralCode &&
//                                                             (sh.createdAt.isAfter(
//                                                                   monthStart(),
//                                                                 ) ||
//                                                                 sh.createdAt.isAtSameMomentAs(
//                                                                   monthStart(),
//                                                                 )) &&
//                                                             (sh.createdAt.isBefore(
//                                                                   secondWeek(),
//                                                                 ) ||
//                                                                 sh.createdAt.isAtSameMomentAs(
//                                                                   secondWeek(),
//                                                                 )),
//                                                       )
//                                                       .length
//                                                       .toStringAsFixed(
//                                                         0,
//                                                       ),
//                                             ),
//                                           ),
//                                           Container(
//                                             height: 25,
//                                             width: 1,
//                                             color: Colors
//                                                 .grey
//                                                 .shade100,
//                                           ),
//                                           Expanded(
//                                             child: AgentProfileInfo(
//                                               title:
//                                                   'Week 2',
//                                               data:
//                                                   returnShopProvider(
//                                                         context:
//                                                             context,
//                                                         listen:
//                                                             false,
//                                                       )
//                                                       .getHeadQuaters()
//                                                       .where(
//                                                         (
//                                                           sh,
//                                                         ) =>
//                                                             sh.refCode ==
//                                                                 widget.agent.referralCode &&
//                                                             (sh.createdAt.isAfter(
//                                                                   secondWeek(),
//                                                                 ) ||
//                                                                 sh.createdAt.isAtSameMomentAs(
//                                                                   secondWeek(),
//                                                                 )) &&
//                                                             (sh.createdAt.isBefore(
//                                                                   thirdWeek(),
//                                                                 ) ||
//                                                                 sh.createdAt.isAtSameMomentAs(
//                                                                   thirdWeek(),
//                                                                 )),
//                                                       )
//                                                       .length
//                                                       .toStringAsFixed(
//                                                         0,
//                                                       ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment
//                                                 .spaceBetween,
//                                         spacing: 10,
//                                         children: [
//                                           Expanded(
//                                             child: AgentProfileInfo(
//                                               title:
//                                                   'Week 3',
//                                               data:
//                                                   returnShopProvider(
//                                                         context:
//                                                             context,
//                                                         listen:
//                                                             false,
//                                                       )
//                                                       .getHeadQuaters()
//                                                       .where(
//                                                         (
//                                                           sh,
//                                                         ) =>
//                                                             sh.refCode ==
//                                                                 widget.agent.referralCode &&
//                                                             (sh.createdAt.isAfter(
//                                                                   thirdWeek(),
//                                                                 ) ||
//                                                                 sh.createdAt.isAtSameMomentAs(
//                                                                   thirdWeek(),
//                                                                 )) &&
//                                                             (sh.createdAt.isBefore(
//                                                                   fourthWeek(),
//                                                                 ) ||
//                                                                 sh.createdAt.isAtSameMomentAs(
//                                                                   fourthWeek(),
//                                                                 )),
//                                                       )
//                                                       .length
//                                                       .toStringAsFixed(
//                                                         0,
//                                                       ),
//                                             ),
//                                           ),
//                                           Container(
//                                             height: 25,
//                                             width: 1,
//                                             color: Colors
//                                                 .grey
//                                                 .shade100,
//                                           ),
//                                           Expanded(
//                                             child: AgentProfileInfo(
//                                               title:
//                                                   'Week 4',
//                                               data:
//                                                   returnShopProvider(
//                                                         context:
//                                                             context,
//                                                         listen:
//                                                             false,
//                                                       )
//                                                       .getHeadQuaters()
//                                                       .where(
//                                                         (
//                                                           sh,
//                                                         ) =>
//                                                             sh.refCode ==
//                                                                 widget.agent.referralCode &&
//                                                             (sh.createdAt.isAfter(
//                                                                   fourthWeek(),
//                                                                 ) ||
//                                                                 sh.createdAt.isAtSameMomentAs(
//                                                                   fourthWeek(),
//                                                                 )) &&
//                                                             (sh.createdAt.isBefore(
//                                                                   monthEnd(),
//                                                                 ) ||
//                                                                 sh.createdAt.isAtSameMomentAs(
//                                                                   monthEnd(),
//                                                                 )),
//                                                       )
//                                                       .length
//                                                       .toStringAsFixed(
//                                                         0,
//                                                       ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment
//                                           .spaceBetween,
//                                   spacing: 10,
//                                   children: [
//                                     Expanded(
//                                       child: AgentProfileInfo(
//                                         title:
//                                             'Total Eligible',
//                                         data:
//                                             returnShopProvider(
//                                                   context:
//                                                       context,
//                                                   listen:
//                                                       false,
//                                                 )
//                                                 .getHeadQuaters()
//                                                 .where(
//                                                   (sh) =>
//                                                       sh.refCode ==
//                                                           widget.agent.referralCode &&
//                                                       dateDifference(
//                                                             sh.createdAt,
//                                                             DateTime.now(),
//                                                           ) <
//                                                           storeEligibilty,
//                                                 )
//                                                 .length
//                                                 .toStringAsFixed(
//                                                   0,
//                                                 ),
//                                       ),
//                                     ),
//                                     Container(
//                                       height: 25,
//                                       width: 1,
//                                       color: Colors
//                                           .grey
//                                           .shade100,
//                                     ),
//                                     Expanded(
//                                       child: AgentProfileInfo(
//                                         title:
//                                             'Total Ineligible',
//                                         data:
//                                             returnShopProvider(
//                                                   context:
//                                                       context,
//                                                   listen:
//                                                       false,
//                                                 )
//                                                 .getHeadQuaters()
//                                                 .where(
//                                                   (sh) =>
//                                                       sh.refCode ==
//                                                           widget.agent.referralCode &&
//                                                       dateDifference(
//                                                             sh.createdAt,
//                                                             DateTime.now(),
//                                                           ) >=
//                                                           storeEligibilty,
//                                                 )
//                                                 .length
//                                                 .toStringAsFixed(
//                                                   0,
//                                                 ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 AgentProfileInfo(
//                                   title:
//                                       'Unpaid Commission',
//                                   isPaid:
//                                       returnUserProvider(
//                                         context: context,
//                                         listen: false,
//                                       ).isAgentPaid(
//                                         widget.agent,
//                                         context,
//                                       ),
//                                   data: formatMoney(
//                                     returnSubPaymentsProvider(
//                                       context: context,
//                                     ).getAgentsCutForMonthsPayment(
//                                       widget
//                                               .agent
//                                               .referralCode ??
//                                           '',
//                                       widget.agent.role!,
//                                       context,
//                                     ),
//                                   ),
//                                 ),
//                                 Visibility(
//                                   visible:
//                                       widget.agent.role ==
//                                       'Employed',
//                                   child: AgentProfileInfo(
//                                     title:
//                                         'Month\'s Salary',
//                                     isPaid:
//                                         returnUserProvider(
//                                           context: context,
//                                           listen: false,
//                                         ).isAgentPaid(
//                                           widget.agent,
//                                           context,
//                                         ),
//                                     data: formatMoney(
//                                       getAgentsSalary(
//                                         returnShopProvider(
//                                               context:
//                                                   context,
//                                               listen: false,
//                                             )
//                                             .getHeadQuaters()
//                                             .where(
//                                               (sh) =>
//                                                   sh.refCode ==
//                                                       widget
//                                                           .agent
//                                                           .referralCode &&
//                                                   (sh.createdAt.isAfter(
//                                                         monthStart(),
//                                                       ) ||
//                                                       sh.createdAt.isAtSameMomentAs(
//                                                         monthStart(),
//                                                       )),
//                                             )
//                                             .length,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 AgentProfileInfo(
//                                   title:
//                                       'Month\'s Total ${widget.agent.role == 'Freelance' ? 'Subscription' : 'Payment'}',
//                                   data: formatMoney(
//                                     widget.agent.role ==
//                                             'Freelance'
//                                         ? returnSubPaymentsProvider(
//                                             context:
//                                                 context,
//                                           ).getAgentsTotalForMonth(
//                                             widget
//                                                     .agent
//                                                     .referralCode ??
//                                                 '',
//                                             context,
//                                           )
//                                         : (returnSubPaymentsProvider(
//                                                 context:
//                                                     context,
//                                               ).getAgentsCutForMonthsPayment(
//                                                 widget
//                                                         .agent
//                                                         .referralCode ??
//                                                     '',
//                                                 widget
//                                                     .agent
//                                                     .role!,
//                                                 context,
//                                               ) +
//                                               getAgentsSalary(
//                                                 returnShopProvider(
//                                                       context:
//                                                           context,
//                                                       listen:
//                                                           false,
//                                                     )
//                                                     .getHeadQuaters()
//                                                     .where(
//                                                       (
//                                                         sh,
//                                                       ) =>
//                                                           sh.refCode ==
//                                                               widget.agent.referralCode &&
//                                                           (sh.createdAt.isAfter(
//                                                                 monthStart(),
//                                                               ) ||
//                                                               sh.createdAt.isAtSameMomentAs(
//                                                                 monthStart(),
//                                                               )),
//                                                     )
//                                                     .length,
//                                               )),
//                                   ),
//                                 ),
//                                 AgentProfileInfo(
//                                   title: 'Bank Name',
//                                   data:
//                                       returnBankProvider(
//                                             context:
//                                                 context,
//                                             listen: false,
//                                           )
//                                           .getSingleBank(
//                                             widget
//                                                 .agent
//                                                 .userId!,
//                                           )
//                                           ?.bankName ??
//                                       'Not Set',
//                                 ),
//                                 AgentProfileInfo(
//                                   copyAction:
//                                       returnBankProvider(
//                                             context:
//                                                 context,
//                                             listen: false,
//                                           ).banks
//                                           .where(
//                                             (ban) =>
//                                                 ban.userId ==
//                                                 widget
//                                                     .agent
//                                                     .userId,
//                                           )
//                                           .isNotEmpty
//                                       ? () {
//                                           print(
//                                             'Copying shit',
//                                           );
//                                           Clipboard.setData(
//                                             ClipboardData(
//                                               text:
//                                                   returnBankProvider(
//                                                         context:
//                                                             context,
//                                                         listen:
//                                                             false,
//                                                       )
//                                                       .getSingleBank(
//                                                         widget.agent.userId!,
//                                                       )
//                                                       ?.accountNumber ??
//                                                   '',
//                                             ),
//                                           );
//                                           showSnackbar(
//                                             message:
//                                                 'Account Number has been copied to clipboard.',
//                                             title:
//                                                 'Copied to Clipboard!',
//                                             context:
//                                                 context,
//                                             actionResult:
//                                                 ActionResult()
//                                                     .success,
//                                           );
//                                         }
//                                       : null,
//                                   title: 'Account Number',
//                                   data:
//                                       returnBankProvider(
//                                             context:
//                                                 context,
//                                             listen: false,
//                                           )
//                                           .getSingleBank(
//                                             widget
//                                                 .agent
//                                                 .userId!,
//                                           )
//                                           ?.accountNumber ??
//                                       'Not Set',
//                                 ),
//                                 AgentProfileInfo(
//                                   title: 'Account Name',
//                                   data:
//                                       returnBankProvider(
//                                             context:
//                                                 context,
//                                             listen: false,
//                                           )
//                                           .getSingleBank(
//                                             widget
//                                                 .agent
//                                                 .userId!,
//                                           )
//                                           ?.accountName ??
//                                       'Not Set',
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ).then((_) {
//                 setState(() {});
//               });
//             },
//             child: Container(
//               padding: EdgeInsets.symmetric(
//                 vertical: 20,
//                 horizontal: 20,
//               ),
//               child: Row(
//                 spacing: 10,
//                 mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Row(
//                       spacing: 8,
//                       children: [
//                         Icon(
//                           size: 18,
//                           color: Colors.grey,
//                           Icons.person,
//                         ),
//                         Expanded(
//                           child: Text(
//                             style: TextStyle(
//                               fontSize: theme
//                                   .mobileTexts
//                                   .b2
//                                   .fontSize,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             widget.agent.name,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     spacing: 8,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 3,
//                           horizontal: 6,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade200,
//                         ),
//                         child: Text(
//                           style: TextStyle(
//                             fontSize: 8,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           widget.agent.role
//                                   ?.toUpperCase() ??
//                               'Role Not Set',
//                         ),
//                       ),
//                       Visibility(
//                         visible: !widget.isAll,
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                             vertical: 1,
//                             horizontal: 5,
//                           ),
//                           decoration: BoxDecoration(
//                             color:
//                                 returnUserProvider(
//                                   context: context,
//                                 ).isAgentPaid(
//                                   widget.agent,
//                                   context,
//                                 )
//                                 ? const Color.fromARGB(
//                                     14,
//                                     76,
//                                     175,
//                                     79,
//                                   )
//                                 : const Color.fromARGB(
//                                     10,
//                                     244,
//                                     67,
//                                     54,
//                                   ),
//                             borderRadius:
//                                 BorderRadius.circular(2),
//                             border: Border.all(
//                               color:
//                                   returnUserProvider(
//                                     context: context,
//                                   ).isAgentPaid(
//                                     widget.agent,
//                                     context,
//                                   )
//                                   ? Colors.green
//                                   : Colors.red,
//                             ),
//                           ),
//                           child: Center(
//                             child: Text(
//                               style: TextStyle(
//                                 fontSize: theme
//                                     .mobileTexts
//                                     .b4
//                                     .fontSize,
//                               ),
//                               returnUserProvider(
//                                     context: context,
//                                   ).isAgentPaid(
//                                     widget.agent,
//                                     context,
//                                   )
//                                   ? 'Paid'
//                                   : 'Unpaid',
//                             ),
//                           ),
//                         ),
//                       ),
//                       Icon(
//                         size: 14,
//                         color: Colors.grey,
//                         Icons.arrow_forward_ios_rounded,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class AgentProfileInfo extends StatelessWidget {
  final String title;
  final String data;
  final Function()? copyAction;
  final bool? isPaid;
  const AgentProfileInfo({
    super.key,
    required this.title,
    required this.data,
    this.copyAction,
    this.isPaid,
  });

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 10,
        children: [
          Text(
            style: TextStyle(
              fontSize: theme.mobileTexts.b4.fontSize,
              // color: Colors.grey,
              fontWeight: FontWeight.normal,
            ),
            '$title:',
          ),
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              mouseCursor: SystemMouseCursors.click,
              onTap: copyAction,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      visible: copyAction != null,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(size: 16, Icons.copy),
                          SizedBox(width: 7),
                        ],
                      ),
                    ),
                    Text(
                      style: TextStyle(
                        color:
                            isPaid != null && isPaid == true
                            ? Colors.grey.shade400
                            : null,
                        fontSize:
                            theme.mobileTexts.b2.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                      data,
                    ),
                    // Visibility(
                    //   visible: isPaid != null,
                    //   child: Icon(
                    //     size: 18,
                    //     color: Colors.grey.shade400,
                    //     Icons.check,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopStoreFilterButton extends StatelessWidget {
  final int myIndex;
  final int mainIndex;
  final String title;
  final Function()? action;

  const TopStoreFilterButton({
    super.key,
    required this.myIndex,
    required this.mainIndex,
    required this.title,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return Expanded(
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            color: mainIndex == myIndex
                ? theme.lightModeColor.prColor300
                : null,
            borderRadius: BorderRadius.circular(5),
          ),
          child: InkWell(
            mouseCursor: SystemMouseCursors.click,
            onTap: action,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 7,
                horizontal: 5,
              ),

              child: Center(
                child: Text(
                  style: TextStyle(
                    fontSize: theme.mobileTexts.b4.fontSize,
                    fontWeight: mainIndex == myIndex
                        ? FontWeight.bold
                        : null,
                    color: mainIndex == myIndex
                        ? Colors.white
                        : theme.lightModeColor.prColor300,
                  ),
                  title,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
