import 'package:flutter/material.dart';
import 'package:stockallagent/classes/user_class.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/agent_page/components/agent_details_section_page.dart';

class AgentPage extends StatelessWidget {
  final String agentUuid;
  const AgentPage({super.key, required this.agentUuid});

  @override
  Widget build(BuildContext context) {
    UserClass agent = returnUserProvider(
      context: context,
    ).agents.firstWhere((item) => item.userId == agentUuid);
    var theme = returnTheme();

    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        255,
        255,
        255,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: theme.lightModeColor.prColor300,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      mouseCursor: SystemMouseCursors.click,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        color: Colors.grey.shade200,
                        size: 20,
                        Icons.arrow_back_ios_new_rounded,
                      ),
                    ),
                    Text(
                      style: TextStyle(
                        fontSize:
                            theme.mobileTexts.b2.fontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      'Agent Details',
                    ),
                    Opacity(
                      opacity: 0,
                      child: IconButton(
                        mouseCursor:
                            SystemMouseCursors.click,
                        onPressed: () {},
                        icon: Icon(
                          color: Colors.white,
                          size: 20,
                          Icons.arrow_back_ios_new_rounded,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: const Color.fromARGB(
                    80,
                    158,
                    158,
                    158,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    10,
                    10,
                    10,
                    10,
                  ),
                  child: Column(
                    spacing: 5,
                    children: [
                      Icon(
                        size: 25,
                        color: Colors.amber,
                        Icons.manage_accounts_outlined,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:
                              theme.mobileTexts.h4.fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        "${agent.name.toUpperCase()} ${agent.lastName?.toUpperCase()}",
                      ),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        spacing: 5,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: theme
                                  .mobileTexts
                                  .b5
                                  .fontSize,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade400,
                            ),
                            "Shops:".toUpperCase(),
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: theme
                                  .mobileTexts
                                  .b5
                                  .fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400,
                            ),
                            returnShopProvider(
                                  context: context,
                                ).shopInfos
                                .where(
                                  (item) =>
                                      item.agentUuid ==
                                      agent.userId,
                                )
                                .length
                                .toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                15.0,
                15,
                15,
                50,
              ),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    AgentDetailsSectionPage(agent: agent),
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
