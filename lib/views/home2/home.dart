import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:walletwatch_mobile/common/icons/bottom_nav_icons.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/views/home2/home_chat.dart';
import 'package:walletwatch_mobile/views/home2/home_hotline.dart';
import 'package:walletwatch_mobile/views/home2/home_monitor.dart';
import 'package:walletwatch_mobile/views/home2/home_profile.dart';

class Home extends StatefulWidget {
  final double height;
  final double width;
  const Home({super.key, this.height = 55, this.width = 35});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, statusBarColor: lightColor));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: SafeArea(
        child: Scaffold(
          body: PageView(
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: const [
              HomeMonitor(),
              HomeChat(),
              HomeHotline(),
              HomeProfile(),
            ],
          ),
          bottomNavigationBar: BottomBarDefault(
            items: const [
              TabItem(icon: BottomNavIcons.home, title: 'Home'),
              TabItem(icon: BottomNavIcons.chatbot, title: 'ChatBot'),
              TabItem(icon: BottomNavIcons.hotline, title: 'Hotline'),
              TabItem(icon: BottomNavIcons.profile, title: 'Profile'),
            ],
            backgroundColor: lightColor,
            color: darkColor,
            colorSelected: primaryColor,
            indexSelected: _currentIndex,
            boxShadow: [
              BoxShadow(
                color: borderColor,
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );

                if (_currentIndex == 2) {
                  SystemChrome.setSystemUIOverlayStyle(
                      const SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: Color(0xFFe8f6ee),
                  ));
                } else {
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: lightColor,
                  ));
                }
              });
            },
            // styleDivider: StyleDivider.bottom,
          ),
        ),
      ),
    );
  }
}
