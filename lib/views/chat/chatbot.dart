import 'dart:async';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/data/chat_message.dart';
import 'package:walletwatch_mobile/common/data/chat_session.dart';
import 'package:walletwatch_mobile/common/enum/home_state.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'package:walletwatch_mobile/common/http/chat.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/widgets/home_navigator.dart';
import 'package:walletwatch_mobile/common/widgets/input_alert.dart';
import 'package:walletwatch_mobile/common/widgets/top_bar.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: "USER");
  final _bot = const types.User(id: "BOT");
  final _advancedDrawerController = AdvancedDrawerController();
  final List<ChatSession> _chatSessions = [];
  final List<ChatMessage> _chatMessages = [];
  ChatSession? _currentChatSession;
  bool isSettingVisible = false;
  WebSocketChannel? _channel;
  Timer? _timer;
  bool _isInputTitleVisible = false;
  final _titleController = TextEditingController();
  PusherChannelsClient? _client;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, statusBarColor: lightColor));

    loadPage();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _channel?.sink.close(status.normalClosure);
    _titleController.dispose();
    _client?.dispose();
    super.dispose();
  }

  void loadPage() async {
    EasyLoading.show(status: 'Loading...');
    final chatSessions = await fetchChats();
    setState(() {
      _chatSessions.addAll(chatSessions);

      if (_chatSessions.isNotEmpty) {
        _currentChatSession = _chatSessions.last;
      }
    });

    EasyLoading.dismiss();

    loadChat();
  }

  Future<void> connectWebSocket() async {
    final prefs = await getPrefs();
    final accessToken = prefs.accessToken;
    if (accessToken == null) {
      print('No access token found.');
      return;
    }

    const hostOptions = PusherChannelsOptions.fromHost(
      scheme: 'wss',
      host: 'ws.walletwatch.id',
      key: 'hsdoMSurOsKZrEpZOUS8L7xpG7XciFPf',
      shouldSupplyMetadataQueries: true,
      metadata: PusherChannelsOptionsMetadata.byDefault(),
      port: 443,
    );

    setState(() {
      _client = PusherChannelsClient.websocket(
        options: hostOptions,
        connectionErrorHandler: (exception, trace, refresh) {
          refresh();
        },
        minimumReconnectDelayDuration: const Duration(
          seconds: 1,
        ),
        defaultActivityDuration: const Duration(
          seconds: 120,
        ),
        activityDurationOverride: const Duration(
          seconds: 120,
        ),
        waitForPongDuration: const Duration(
          seconds: 30,
        ),
      );
    });

    final channel = _client!.privateChannel(
      'chat-sessions.${_currentChatSession!.id}',
      authorizationDelegate:
          EndpointAuthorizableChannelTokenAuthorizationDelegate
              .forPrivateChannel(
        authorizationEndpoint:
            Uri.parse('https://www.walletwatch.id/broadcasting/auth'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    final allChannels = <Channel>[
      channel,
    ];

    final StreamSubscription connectionSubs =
        _client!.onConnectionEstablished.listen((_) {
      for (final channel in allChannels) {
        channel.subscribeIfNotUnsubscribed();
      }
    });
    _client!.connect();

    _client!.onConnectionEstablished.listen((event) {
      print('Connection established');
      print('chat-sessions.${_currentChatSession!.id}');
    });

    final onCreated = channel.bind('chat-message.created').listen((event) {
      print('Event from the private channel fired!');
    });

    // await Future.delayed(const Duration(seconds: 60));
    // connectionSubs.cancel();
    // onCreated.cancel();
    // client.dispose();
  }

  // Future<void> connectWebSocket() async {
  //   final prefs = await getPrefs();
  //   final accessToken = prefs.accessToken;
  //   if (accessToken == null) {
  //     print('No access token found.');
  //     return;
  //   }

  //   _channel = WebSocketChannel.connect(
  //     Uri.parse('wss://ws.walletwatch.id/app/hsdoMSurOsKZrEpZOUS8L7xpG7XciFPf'),
  //     protocols: ['Bearer $accessToken'],
  //   );

  //   _channel!.stream.listen((message) {
  //     print(message);
  //     // final decodedMessage = jsonDecode(message);
  //     // final chatMessage = ChatMessage(
  //     //   id: decodedMessage['id'],
  //     //   sender: decodedMessage['sender'],
  //     //   message: decodedMessage['message'],
  //     //   hash: decodedMessage['hash'],
  //     //   status: decodedMessage['status'],
  //     // );
  //     // setState(() {
  //     //   _chatMessages.add(chatMessage);
  //     // });
  //     // final textMessage = types.TextMessage(
  //     //   author: types.User(id: chatMessage.sender),
  //     //   id: chatMessage.id,
  //     //   text: chatMessage.message,
  //     // );
  //     // _addMessage(textMessage);
  //   });
  // }

  void startFetchingMessages() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentChatSession != null) {
        fetchChatMessages(_currentChatSession!).then((newMessages) {
          if (newMessages.isNotEmpty) {
            List<ChatMessage> newChatMessages = _getNewMessages(newMessages);
            if (newChatMessages.isNotEmpty) {
              for (var chatMessage in newChatMessages) {
                final textMessage = types.TextMessage(
                  author: types.User(id: chatMessage.sender),
                  id: chatMessage.id,
                  text: chatMessage.message,
                );
                _addMessage(textMessage);
              }
              setState(() {
                _chatMessages.addAll(newChatMessages);
              });
            }
          }
        });
      }
    });
  }

  List<ChatMessage> _getNewMessages(List<ChatMessage> newMessages) {
    final existingMessageIds =
        _chatMessages.map((message) => message.id).toSet();
    return newMessages
        .where((message) => !existingMessageIds.contains(message.id))
        .toList();
  }

  void loadChat() async {
    if (_currentChatSession != null) {
      EasyLoading.show(status: 'Loading...');
      _client?.dispose();
      if (_chatSessions.isNotEmpty) {
        await connectWebSocket();
      }

      final chatMessages = await fetchChatMessages(_currentChatSession!);
      setState(() {
        _chatMessages.clear();
        _messages.clear();
        _chatMessages.addAll(chatMessages);
      });

      final textMessage = types.TextMessage(
          author: _bot,
          // createdAt: DateTime.now().millisecondsSinceEpoch,
          id: randomString(),
          text:
              "Hi, ${user.name}!\n\nIni Chatbot dan senang bisa ngobrol dengan kamu! Kalau ada pertanyaan, kamu bisa tulis di bawah yaa. I would love to answer :)");

      _messages.insert(0, textMessage);

      for (var chatMessage in _chatMessages) {
        final textMessage = types.TextMessage(
          author: types.User(id: chatMessage.sender),
          id: chatMessage.id,
          text: chatMessage.message,
          createdAt: chatMessage.createdAt,
        );

        _addMessage(textMessage);
      }
    }
    EasyLoading.dismiss();

    startFetchingMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    if (_currentChatSession != null) {
      EasyLoading.show(status: 'Loading...');

      await storeChatMessages(
          message: message.text, session: _currentChatSession!);
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomeNavigator(
        controller: _advancedDrawerController,
        state: HomeState.monitor,
        child: Scaffold(
          backgroundColor: lightColor,
          body: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: TopBar(
                    title: "ChatBot",
                    textColor: darkColor,
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
                child: Padding(
                   padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Container(
                        height: 45.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.r),
                          ),
                          border: Border.all(
                            color: borderColor,
                            width: 1.5.w,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: MaterialButton(
  onPressed: () {
    setState(() {
      _isInputTitleVisible = true;
    });
  },
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.arrow_back, color: lightColor),
      Expanded(
        child: Text(
          "Obrolan Dimulai",
          style: AppFontStyle.homeSubTitleText.copyWith(color: lightColor),
          textAlign: TextAlign.center,
        ),
      ),
      const Icon(Icons.arrow_back, color: Colors.transparent),
    ],
  ),
),

                        ),
                      ),
                                     SizedBox(
                        height: 12.h,
                      ),
                      Container(
                        height: 60.h,
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: darkColor,
                                    width: 2.w,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: SizedBox(
                                      width: 56.h,
                                      height: 56.h,
                                      child: user.image),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 16.w, top: 6.h),
                                height: 60.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ChatBot",
                                      style: AppFontStyle.accountNameText,
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Text(
                                      "Personal Assistant Kamu",
                                      style: AppFontStyle.homeListHeaderText
                                          .copyWith(
                                              color: subColor, fontSize: 13.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_chatSessions.isNotEmpty) ...[
                         SizedBox(
                        height: 12.h,
                      ),
                        CustomDropdown<ChatSession>.search(
                          overlayHeight: 300.h,
                          hintText: 'Pilih Chat...',
                          closedHeaderPadding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 12.h),
                          decoration: CustomDropdownDecoration(
                            closedFillColor: backColor,
                            expandedFillColor: backColor,
                            expandedBorder:
                                Border.all(color: borderColor, width: 2.w),
                            closedBorder:
                                Border.all(color: borderColor, width: 2.w),
                            searchFieldDecoration: SearchFieldDecoration(
                              fillColor: backColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: borderColor,
                                  width: 2.w,
                                ),
                              ),
                            ),
                            listItemDecoration: const ListItemDecoration(
                              selectedColor: Color(0xFFF4F1EC),
                            ),
                            headerStyle: AppFontStyle.classLabelText
                                .copyWith(color: darkColor),
                            listItemStyle: AppFontStyle.classLabelText
                                .copyWith(color: darkColor),
                          ),
                          items: _chatSessions,
                          headerBuilder: (context, selectedItem, status) => Text(
                            selectedItem.title,
                            style: AppFontStyle.classLabelText
                                .copyWith(color: const Color(0xFF3A2723)),
                          ),
                          listItemBuilder:
                              (context, item, isSelected, onItemSelect) => Text(
                            item.title,
                            style: AppFontStyle.classLabelText
                                .copyWith(color: const Color(0xFF3A2723)),
                          ),
                          initialItem: _chatSessions.last,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _currentChatSession = value;
                              });
                              loadChat();
                            }
                          },
                        ),

                      ],
                      SizedBox(
                        height: 12.h,
                      ),

                      SizedBox(
                        height: 12.h,
                      ),
                      Expanded(
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
                              inputPadding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 0),
                              inputBackgroundColor: lightColor,
                              inputTextColor: darkColor,
                              inputTextStyle: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Nunito',
                                color: darkColor,
                              ),
                              // statusIconPadding: EdgeInsets.zero,
                              sendButtonMargin: EdgeInsets.zero,
                              sendButtonIcon: Image.asset(
                                'assets/icons/send_chat.png',
                                width: 40.w,
                                height: 40.h,
                                fit: BoxFit.fill,
                              ),
                              // inputTextDecoration: InputDecoration(
                              //   focusColor: primaryColor,
                              //   fillColor: primaryColor,
                              //   hoverColor: primaryColor
                              // ),
                              inputContainerDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.r),
                                border: Border.all(
                                    color: darkBorderColor, width: 2.w),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h,),
                    ],
                  ),
                ),
              ),
              if (_isInputTitleVisible)
              InputAlert(
                title: "Buat Chat Baru",
                label: " Nama Chat",
                hint: "Masukkan Nama Chat..",
                submitText: "Buat",
                colors: [secondaryColor, primaryColor, primaryColor],
                visible: _isInputTitleVisible,
                onSubmit: () async {
                  EasyLoading.show(status: 'loading...');

                  await storeChatSession(title: _titleController.text);

                  Future.delayed(const Duration(seconds: 2));

                  loadPage();

                  setState(() {
                    _isInputTitleVisible = false;
                    _titleController.clear();
                  });

                  EasyLoading.dismiss();
                },
                onDismiss: () {
                  setState(() {
                    _isInputTitleVisible = false;
                  });
                },
                controller: _titleController,
              ),
            ],
          ),
        ));
  }
}
