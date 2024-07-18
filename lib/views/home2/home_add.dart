import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:walletwatch_mobile/common/enum/home_state.dart';
import 'package:walletwatch_mobile/common/enum/transaction_field_state.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/widgets/home_navigator.dart';
import 'package:walletwatch_mobile/common/widgets/top_bar.dart';
import 'package:walletwatch_mobile/common/widgets/transaction_text_field.dart';

class HomeAdd extends StatefulWidget {
  const HomeAdd({super.key});

  @override
  State<HomeAdd> createState() => _HomeAddState();
}

class _HomeAddState extends State<HomeAdd> {
  final _advancedDrawerController = AdvancedDrawerController();
  final _installmentController = TextEditingController();
  final _totalController = TextEditingController();
  final _periodController = TextEditingController();
  final _providerController = TextEditingController();

  bool isSettingVisible = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, statusBarColor: lightColor));

    super.initState();
  }

  @override
  void dispose() {
    _installmentController.dispose();
    _totalController.dispose();
    _periodController.dispose();
    _providerController.dispose();
    super.dispose();
  }

  void refresh() {
    setState(() {});
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
                    controller: _advancedDrawerController,
                    title: "Tambah Transaksi",
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
                    color: lightColor,
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
                          child: Text('Mengatur Preferensi Anda!',
                              style: AppFontStyle.homeSubTitleText
                                  .copyWith(color: lightColor)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40.h),
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 40.w),
                  alignment: Alignment.bottomCenter,
                  child: ListView(
                    children: [
                      Container(
                        height: 80.h,
                        padding: EdgeInsets.all(6.h),
                        decoration: BoxDecoration(
                            color: darkColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(60.r))),
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
                                    color: Colors.white,
                                    width: 2.w,
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
                                padding: EdgeInsets.only(left: 16.w, top: 6.h),
                                height: 80.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Transaksi Paylater:',
                                      style: AppFontStyle.homeListHeaderText
                                          .copyWith(
                                              color: lightColor,
                                              fontSize: 14.sp),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Text(
                                      user.name,
                                      style: AppFontStyle.accountNameText
                                          .copyWith(
                                              color: lightColor,
                                              fontSize: 24.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TransactionTextField(
                        label: "Cicilan Paylater:",
                        hint: "Masukkan Cicilan..",
                        controller: _installmentController,
                        state: TransactionFieldState.installment,
                      ),
                      SizedBox(height: 4.h),
                      TransactionTextField(
                        label: "Jumlah Paylater:",
                        hint: "Masukkan Jumlah..",
                        controller: _totalController,
                        state: TransactionFieldState.total,
                      ),
                      SizedBox(height: 4.h),
                      TransactionTextField(
                        label: "Periode Cicilan:",
                        hint: "Pilih Periode",
                        controller: _periodController,
                        state: TransactionFieldState.period,
                      ),
                      SizedBox(height: 4.h),
                      TransactionTextField(
                        label: "Lembaga Paylater:",
                        hint: "Pilih Lembaga",
                        controller: _providerController,
                        state: TransactionFieldState.provider,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        height: 40.h,
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
                              setState(() {});
                            },
                            child: Text("Cek tingkat kebutuhanmu di sini",
                                style: AppFontStyle.homeSubTitleText
                                    .copyWith(color: lightColor)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100.h,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
