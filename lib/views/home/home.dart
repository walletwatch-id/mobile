import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/views/home/home_add.dart';
import 'package:wallet_watch/views/home/home_chat.dart';
import 'package:wallet_watch/views/home/home_hotline.dart';
import 'package:wallet_watch/views/home/home_monitor.dart';
import 'package:wallet_watch/views/home/home_profile.dart';

class Home extends StatefulWidget {
  final double height;
  final double width;
  const Home({super.key, this.height = 55, this.width = 35});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late int _currentPage;
  late TabController _tabController;

  @override
  void initState() {
    _currentPage = 0;
    _tabController = TabController(length: 5, vsync: this);
    _tabController.animation?.addListener(
      () {
        final value = _tabController.animation!.value.round();
        if (value != _currentPage && mounted) {
          changePage(value);
        }
      },
    );

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: darkColor
    ));
    super.initState();
  }

  void changePage(int newPage) {
    FocusScope.of(context).unfocus();
    setState(() {
      _currentPage = newPage;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color unselectedColor = lightColor;

    final height = widget.height.h;
    final width = widget.width.w;

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: darkColor,
          body: BottomBar(
            clip: Clip.none,
            fit: StackFit.passthrough,
            icon: (width, height) => Center(
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: null,
                icon: Icon(
                  Icons.arrow_upward_rounded,
                  color: unselectedColor,
                  size: width,
                ),
              ),
            ),
            borderRadius: BorderRadius.circular(500),
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
            showIcon: true,
            width: MediaQuery.of(context).size.width * 0.9,
            barColor: bottomBarColor,
            start: 0,
            end: 0,
            offset: 16.h,
            barAlignment: Alignment.bottomCenter,
            iconHeight: 35.h,
            iconWidth: 35.h,
            reverse: false,
            hideOnScroll: true,
            scrollOpposite: false,
            onBottomBarHidden: () {},
            onBottomBarShown: () {},
            body: (context, controller) => TabBarView(
                controller: _tabController,
                dragStartBehavior: DragStartBehavior.down,
                physics: const BouncingScrollPhysics(),
                children: [
                  HomeMonitor(controller: controller),
                  HomeChat(controller: controller),
                  HomeAdd(controller: controller),
                  HomeHotline(controller: controller),
                  HomeProfile(controller: controller),
                ]),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                TabBar(
                  indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                  controller: _tabController,
                  dividerColor: Colors.transparent,
                  tabAlignment: TabAlignment.center,
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                    // color: _currentPage <= 4 ? primaryColor : unselectedColor,
                    color: Colors.transparent,
                    width: 4.w,
                  )),
                  tabs: [
                    SizedBox(
                      height: height,
                      width: width,
                      child: Center(
                          child: Icon(
                        Icons.home,
                        color: _currentPage == 0 ? primaryColor : unselectedColor,
                      )),
                    ),
                    Container(
                      padding: EdgeInsets.only(),
                      child: SizedBox(
                        height: height,
                        width: width,
                        child: Center(
                          child: Icon(
                            Icons.chat,
                            color: _currentPage == 1
                                ? primaryColor
                                : unselectedColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height,
                      width: width,
                      child: Center(
                        child: Icon(
                          Icons.contacts,
                          color:
                              _currentPage == 2 ? primaryColor : unselectedColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height,
                      width: width,
                      child: Center(
                        child: Icon(
                          Icons.contacts,
                          color:
                              _currentPage == 3 ? primaryColor : unselectedColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height,
                      width: width,
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color:
                              _currentPage == 4 ? primaryColor : unselectedColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: -height / (1.5 * 5.5),
                  child: SizedBox(
                    height: height * 1.3,
                    width: height * 1.3,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: _currentPage == 2
                                    ? primaryColor
                                    : bottomBarColor,
                                width: 2.2.w),
                          ),
                          child: ClipOval(
                            child: FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  _tabController.index = 2;
                                });
                              },
                              backgroundColor:
                                  _currentPage == 2 ? darkColor : primaryColor,
                              child: Icon(
                                Icons.add,
                                color: lightColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
