import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/data/chart_data.dart';
import 'package:wallet_watch/common/enum/home_state.dart';
import 'package:wallet_watch/common/enum/paylater_state.dart';
import 'package:wallet_watch/common/helper.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';
import 'package:wallet_watch/common/widgets/area_chart.dart';
import 'package:wallet_watch/common/widgets/home_navigator.dart';
import 'package:wallet_watch/common/widgets/monitor_card.dart';
import 'package:wallet_watch/common/widgets/top_bar.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class HomeHotline extends StatefulWidget {
  final ScrollController controller;
  const HomeHotline({super.key, required this.controller});

  @override
  State<HomeHotline> createState() => _HomeHotlineState();
}

class _HomeHotlineState extends State<HomeHotline> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  final _advancedDrawerController = AdvancedDrawerController();
  bool isSettingVisible = false;

  @override
  void initState() {
    super.initState();

    final textMessage = types.TextMessage(
        author: const types.User(id: '92091008-a484-4a89-ae75-a22bf8d6f3ac'),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text:
            "Hi, ${user.name}!\n\nIni Chatbot dan senang bisa ngobrol dengan kamu! Kalau ada pertanyaan, kamu bisa tulis di bawah yaa. I would love to answer :)");

    _messages.insert(0, textMessage);
  }

  void refresh() {
    setState(() {});
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);

    final textMessage1 = types.TextMessage(
      author: const types.User(id: '92091008-a484-4a89-ae75-a22bf8d6f3ac'),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage1);
  }

  @override
  Widget build(BuildContext context) {
    return HomeNavigator(
        controller: _advancedDrawerController,
        state: HomeState.monitor,
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: TopBar(
                    controller: _advancedDrawerController,
                    title: "Hotline",
                    settingAction: () {
                      // setState(() {
                      //   isSettingAlertVisible = true;
                      // });
                    }),
              ),
              Positioned(
                top: 55.h,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: darkColor,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: Text('Informasi Hotline Terkait Paylater!',
                              style: AppFontStyle.homeSubTitleText
                                  .copyWith(color: lightColor)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 83.h),
                decoration: BoxDecoration(
                  color: backColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
                child: Container(
                    margin: EdgeInsets.all(16.h),
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 46.h,
                          right: 0,
                          bottom: 70.h,
                          left: 0,
                          child: SizedBox(
                            height: double.infinity,
                            
                            child: Chat(
                              messages: _messages,
                              onSendPressed: _handleSendPressed,
                              user: _user,
                              // customBottomWidget: SizedBox(
                              //   height: 0,
                              // ),
                              theme: DefaultChatTheme(
                                backgroundColor: lightColor,
                                primaryColor: primaryColor,
                                secondaryColor: secondaryColor,
                                sentMessageBodyTextStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Nunito',
                                  color: lightColor,
                                ),
                                receivedMessageBodyTextStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Nunito',
                                  color: lightColor,
                                ),
                                inputBorderRadius: BorderRadius.circular(30.r),
                                inputPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0),
                                inputBackgroundColor: lightColor,
                                inputTextColor: darkColor,
                                inputTextStyle: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Nunito',
                                  color: darkColor,
                                ),
                                // statusIconPadding: EdgeInsets.zero,
                                sendButtonMargin: EdgeInsets.zero,
                                sendButtonIcon: Image.asset('assets/icons/send_chat.png', width: 40.w, height: 40.h, fit: BoxFit.fill,),
                                // inputTextDecoration: InputDecoration(
                                //   focusColor: primaryColor,
                                //   fillColor: primaryColor,
                                //   hoverColor: primaryColor
                                // ),
                                inputContainerDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r),
                                  border: Border.all(color: darkBorderColor, width: 2.w),
                                  
                                )
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
