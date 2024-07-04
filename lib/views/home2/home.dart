import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/views/home2/home_add.dart';
import 'package:wallet_watch/views/home2/home_chat.dart';
import 'package:wallet_watch/views/home2/home_hotline.dart';
import 'package:wallet_watch/views/home2/home_monitor.dart';
import 'package:wallet_watch/views/home2/home_profile.dart';

class Home extends StatefulWidget {
  final double height;
  final double width;
  const Home({super.key, this.height = 55, this.width = 35});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  @override
  void initState() {
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
          body: PersistentTabView(
            popAllScreensOnTapAnyTabs: true,
            tabs: [
              PersistentTabConfig(
                screen: const HomeMonitor(),
                item: ItemConfig(
                  activeForegroundColor: primaryColor,
                  icon: const ImageIcon(AssetImage('assets/icons/home.png')),
                  title: "Beranda",
                ),
              ),
              PersistentTabConfig(
                screen: const HomeChat(),
                item: ItemConfig(
                  activeForegroundColor: primaryColor,
                  icon: const ImageIcon(AssetImage('assets/icons/chatbot.png')),
                  title: "ChatBot",
                ),
              ),
              PersistentTabConfig(
                screen: const HomeHotline(),
                item: ItemConfig(
                  activeForegroundColor: primaryColor,
                  icon: const ImageIcon(AssetImage('assets/icons/hotline.png')),
                  title: "Hotline",
                ),
              ),
              PersistentTabConfig(
                screen: const HomeProfile(),
                item: ItemConfig(
                  activeForegroundColor: primaryColor,
                  icon: const ImageIcon(AssetImage('assets/icons/profile.png')),
                  title: "Profile",
                ),
              ),
            ],
            navBarBuilder: (navBarConfig) => Style1BottomNavBar(
              navBarConfig: navBarConfig,
              navBarDecoration: NavBarDecoration(boxShadow: [BoxShadow(color: borderColor, spreadRadius: 1, blurRadius: 8, offset: const Offset(0, 2))]),
            ),
          ),
        ),
      ),
    );
  }
}
