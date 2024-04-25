import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/enum/home_state.dart';
import 'package:wallet_watch/common/helper.dart';
import 'package:wallet_watch/common/theme/app_color_style.dart';
import 'package:wallet_watch/common/theme/app_font_style.dart';

class HomeNavigator extends StatefulWidget {
  final AdvancedDrawerController controller;
  final HomeState state;
  final Widget child;
  final Function()? load;
  const HomeNavigator(
      {super.key,
      required this.controller,
      required this.state,
      required this.child,
      this.load});

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  @override
  void initState() {
    super.initState();
    EasyLoading.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            secondaryColor,
            primaryColor,
          ], stops: const [
            0.2,
            1.0
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        ),
      ),
      controller: widget.controller,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 4.0,
        //   ),
        // ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          selectedColor: const Color(0xFF3A2723),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, left: 12, right: 12),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            user.image,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16),
                        height: 80.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: AppFontStyle.accountNameText.copyWith(
                                color: lightColor,
                              ),
                            ),
                            Text(
                              '@${user.username}',
                              style: AppFontStyle.accountUsernameText.copyWith(
                                color: lightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12.1,
                  color: Color(0xFF3A2723),
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text('WalletWatch <Home> | Ver 1.0', style: TextStyle(color: lightColor),),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Stack(children: [
        widget.child,
        // if (userMode == UserMode.normal)
        //   SettingAlert(
        //     visible: isSettingAlertVisible,
        //     isHome: true,
        //     onDismiss: () {
        //       if (widget.load != null) {
        //         widget.load!();
        //       }
        //       setState(() {
        //         isSettingAlertVisible = false;
        //       });
        //     },
        //   ),
      ]),
    );
  }
}
