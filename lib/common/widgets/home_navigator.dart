import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/enum/home_state.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';

class HomeNavigator extends StatefulWidget {
  final HomeState state;
  final Widget child;
  final Function()? load;
  const HomeNavigator(
      {super.key, required this.state, required this.child, this.load});

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
    return SafeArea(
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
