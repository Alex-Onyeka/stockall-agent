import 'package:flutter/material.dart';
import 'package:stockallagent/classes/shop_info.dart';
import 'package:stockallagent/components/dialog_template.dart';
import 'package:stockallagent/components/textfields/my_text_field.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/theme/theme_provider.dart';

class CommentsListWidget extends StatefulWidget {
  const CommentsListWidget({super.key, required this.shop});

  final ShopInfo shop;

  @override
  State<CommentsListWidget> createState() =>
      _CommentsListWidgetState();
}

class _CommentsListWidgetState
    extends State<CommentsListWidget> {
  final commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var theme = returnTheme();
    return Column(
      spacing: 10,
      children:
          widget.shop.agentComments == null ||
              widget.shop.agentComments?.isEmpty == true
          ? [
              Material(
                type: MaterialType.transparency,
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(
                          28,
                          0,
                          0,
                          0,
                        ),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: InkWell(
                    mouseCursor: SystemMouseCursors.click,
                    onTap: () {
                      addCommentAction(
                        commentController:
                            commentController,
                        context: context,
                        shop: widget.shop,
                      );
                    },
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),

                      child: Center(
                        child: Builder(
                          builder: (context) {
                            if (returnShopProvider(
                              context: context,
                            ).isLoading) {
                              return Center(
                                child: SizedBox(
                                  height: 23,
                                  width: 23,
                                  child:
                                      CircularProgressIndicator(
                                        color: Colors.amber,
                                        strokeWidth: 2,
                                      ),
                                ),
                              );
                            } else {
                              return Column(
                                mainAxisSize:
                                    MainAxisSize.min,
                                spacing: 5,
                                children: [
                                  Icon(
                                    size: 18,
                                    color: theme
                                        .lightModeColor
                                        .secColor200,
                                    Icons
                                        .insert_comment_rounded,
                                  ),
                                  Text(
                                    style: TextStyle(
                                      fontSize: theme
                                          .mobileTexts
                                          .b3
                                          .fontSize,
                                    ),
                                    'Add Comment',
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]
          : [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 3,
                children: [
                  Builder(
                    builder: (context) {
                      if (returnShopProvider(
                        context: context,
                      ).isLoading) {
                        return Padding(
                          padding: EdgeInsetsGeometry.only(
                            right: 15,
                          ),
                          child: SizedBox(
                            height: 18,
                            width: 18,
                            child:
                                CircularProgressIndicator(
                                  color: Colors.amber,
                                  strokeWidth: 2,
                                ),
                          ),
                        );
                      } else {
                        return Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            onTap: () {
                              addCommentAction(
                                commentController:
                                    commentController,
                                context: context,
                                shop: widget.shop,
                              );
                            },
                            mouseCursor:
                                SystemMouseCursors.click,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(
                                    10.0,
                                    5,
                                    10,
                                    5,
                                  ),
                              child: Row(
                                spacing: 5,
                                children: [
                                  Text(
                                    style: TextStyle(
                                      fontSize: theme
                                          .mobileTexts
                                          .b4
                                          .fontSize,
                                      color: theme
                                          .lightModeColor
                                          .tertColor200,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                    'Add Comment',
                                  ),
                                  Icon(
                                    size: 15,
                                    color: theme
                                        .lightModeColor
                                        .tertColor200,
                                    Icons.add,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              ...widget.shop.getComments().map(
                (item) => CommentTileWidget(
                  shop: widget.shop,
                  theme: theme,
                  comment: item,
                ),
              ),
            ],
    );
  }
}

void addCommentAction({
  required BuildContext context,
  required ShopInfo shop,
  required TextEditingController commentController,
}) {
  if (!returnShopProvider().isLoading &&
      (shop.agentUuid != currentUser().userId
          ? topAdmin()
          : true)) {
    showDialog(
      context: context,
      builder: (firstContext) {
        return DialogTemplate(
          action: () {
            saveComment(
              context: firstContext,
              shop: shop,
              commentController: commentController,
            );
          },
          title: 'Add Comment',
          subTitle: 'Enter Comment Below',
          mainWidget: MyTextFieldMain(
            lines: 5,
            controller: commentController,
            isEmail: false,
            showTitle: false,
            isNumber: false,
            isOptional: false,
            hintText: 'Enter Comment',
            isPassword: false,
            onSubmit: (value) {
              saveComment(
                context: firstContext,
                shop: shop,
                commentController: commentController,
              );
            },
            validatorText: 'Comment Cannot be Empty',
          ),
        );
      },
    ).then((_) {
      commentController.clear();
    });
  }
}

void saveComment({
  required BuildContext context,
  required ShopInfo shop,
  required TextEditingController commentController,
}) {
  if (commentController.text.isNotEmpty) {
    showDialog(
      context: context,
      builder: (firstContext) {
        return DialogTemplate(
          title: 'Create Comment',
          message:
              'You are about to add a comment. Are you sure you want to Proceed?',
          action: () async {
            Navigator.of(firstContext).pop();
            Navigator.of(context).pop();
            await returnShopProvider().updateAgentShopComment(
              agentAndShopUuid: shop.agentAndShopUuid ?? '',
              newComment: commentController.text.trim(),
              commentUuid: null,
              agentUuid:
                  returnUserProvider()
                      .currentUser
                      ?.userId ??
                  '',
              agentName:
                  "${returnUserProvider().currentUser?.name ?? ''} ${returnUserProvider().currentUser?.lastName ?? ''}",
              shopId: shop.shopId.toInt(),
            );
          },
        );
      },
    );
  }
}

class CommentTileWidget extends StatefulWidget {
  final Comment comment;
  final ShopInfo shop;
  const CommentTileWidget({
    super.key,
    required this.theme,
    required this.comment,
    required this.shop,
  });

  final ThemeProvider theme;

  @override
  State<CommentTileWidget> createState() =>
      _CommentTileWidgetState();
}

class _CommentTileWidgetState
    extends State<CommentTileWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                style: TextStyle(
                  fontSize:
                      widget.theme.mobileTexts.b4.fontSize,
                ),
                widget.comment.agentName,
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.grey.shade200,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  style: TextStyle(
                    fontSize: widget
                        .theme
                        .mobileTexts
                        .b2
                        .fontSize,
                  ),
                  widget.comment.comment,
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.grey.shade200,
          ),
          Row(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: () {
                    if ((widget.shop.agentUuid !=
                            currentUser().userId
                        ? topAdmin()
                        : true)) {
                      showDialog(
                        context: context,
                        builder: (firstContext) {
                          return DialogTemplate(
                            title: 'Delete Comment',
                            message:
                                'You are about to Delete This Comment. Are you sure you want to Proceed?',
                            action: () async {
                              if (!isLoading) {
                                Navigator.of(
                                  firstContext,
                                ).pop();
                                setState(() {
                                  isLoading = true;
                                });
                                await returnShopProvider()
                                    .updateAgentShopComment(
                                      agentAndShopUuid:
                                          widget
                                              .shop
                                              .agentAndShopUuid ??
                                          '',
                                      newComment: null,
                                      commentUuid: widget
                                          .comment
                                          .uuid,
                                      agentUuid:
                                          returnUserProvider()
                                              .currentUser
                                              ?.userId ??
                                          '',
                                      agentName:
                                          "${returnUserProvider().currentUser?.name ?? ''} ${returnUserProvider().currentUser?.lastName ?? ''}",
                                      shopId: widget
                                          .shop
                                          .shopId
                                          .toInt(),
                                    );
                              }
                            },
                          );
                        },
                      );
                    }
                  },
                  mouseCursor: SystemMouseCursors.click,
                  child: Builder(
                    builder: (context) {
                      if (isLoading) {
                        return Padding(
                          padding: EdgeInsetsGeometry.only(
                            right: 10,
                          ),
                          child: SizedBox(
                            height: 18,
                            width: 18,
                            child:
                                CircularProgressIndicator(
                                  color: Colors.amber,
                                  strokeWidth: 2,
                                ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding:
                              const EdgeInsets.symmetric(
                                vertical: 3.0,
                                horizontal: 15,
                              ),
                          child: Icon(
                            size: 20,
                            color: Colors.red,
                            Icons.delete_outlined,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Text(
                style: TextStyle(
                  fontSize:
                      widget.theme.mobileTexts.b4.fontSize,
                  color: widget
                      .theme
                      .lightModeColor
                      .secColor200,
                ),
                "${formatDate(widget.comment.createdAt)} | ${formatTime(widget.comment.createdAt)}",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
