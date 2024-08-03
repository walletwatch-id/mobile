import 'dart:ffi';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:walletwatch_mobile/common/data/hotline.dart';
import 'package:walletwatch_mobile/common/data/period.dart';
import 'package:walletwatch_mobile/common/enum/home_state.dart';
import 'package:walletwatch_mobile/common/enum/transaction_field_state.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'package:walletwatch_mobile/common/http/hotline.dart';
import 'package:walletwatch_mobile/common/http/transaction.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/widgets/custom_text_field.dart';
import 'package:walletwatch_mobile/common/widgets/date_selector.dart';
import 'package:walletwatch_mobile/common/widgets/home_navigator.dart';
import 'package:walletwatch_mobile/common/widgets/input_alert.dart';
import 'package:walletwatch_mobile/common/widgets/top_bar.dart';
import 'package:walletwatch_mobile/common/widgets/transaction_text_field.dart';

class HomeAdd extends StatefulWidget {
  final ScrollController controller;
  const HomeAdd({super.key, required this.controller});

  @override
  State<HomeAdd> createState() => _HomeAddState();
}

class _HomeAddState extends State<HomeAdd> {
  final _advancedDrawerController = AdvancedDrawerController();
  final _installmentController = TextEditingController();
  final _totalController = TextEditingController();
  final _periodController = TextEditingController();
  final _providerController = SingleSelectController<Hotline?>(null);
  final _firstInstallmentController = TextEditingController();
  final List<Hotline> _hotlines = [];
  bool _isDateSelectorVisible = false;
  bool isSettingVisible = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, statusBarColor: lightColor));

    loadPage();
    super.initState();
  }

  @override
  void dispose() {
    _installmentController.dispose();
    _totalController.dispose();
    _periodController.dispose();
    _providerController.dispose();
    _firstInstallmentController.dispose();
    super.dispose();
  }

  void loadPage() async {
    EasyLoading.show(status: 'Loading...');
    final hotlines = await fetchHotlines();
    setState(() {
      _providerController.value = hotlines[0];
      _hotlines.addAll(hotlines);
    });

    EasyLoading.dismiss();
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
                  textColor: darkColor,
                  isLight: true,
                  settingAction: () {
                    //
                  },
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
                                  child: SizedBox(
                                      height: 65.h,
                                      width: 65.h,
                                      child: user.image),
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
                      SizedBox(height: 4.h),
                      // TransactionTextField(
                      //   label: "Lembaga Paylater:",
                      //   hint: "Pilih Lembaga",
                      //   controller: _providerController,
                      //   state: TransactionFieldState.provider,
                      // ),
                      SizedBox(height: 24.h),
                      Text("Pilih Lembaga:",
                          style: AppFontStyle.authLabelText
                              .copyWith(color: primaryColor, fontSize: 22.sp)),
                      SizedBox(height: 8.h),
                      if (_hotlines.isNotEmpty)
                        CustomDropdown<Hotline>.search(
                          overlayHeight: 300.h,
                          hintText: 'Pilih Lembaga...',
                          controller: _providerController,
                          closedHeaderPadding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 16.h),
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
                          items: _hotlines,
                          headerBuilder: (context, selectedItem, status) =>
                              Text(
                            selectedItem.name,
                            style: AppFontStyle.homeCardTitleText,
                          ),
                          listItemBuilder:
                              (context, item, isSelected, onItemSelect) => Text(
                            item.name,
                            style: AppFontStyle.homeCardTitleText
                                .copyWith(fontSize: 16.sp),
                          ),
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                _providerController.value = value;
                              }
                            });
                          },
                        ),
                      TransactionTextField(
                        label: "Cicilan Paylater:",
                        hint: "Masukkan Cicilan..",
                        controller: _installmentController,
                        state: TransactionFieldState.installment,
                      ),
                      SizedBox(height: 4.h),
                      TransactionTextField(
                        label: "Jumah Paylater (per Bulan):",
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
                      SizedBox(
                        height: 4.h,
                      ),
                      TransactionTextField(
                        label: "Tanggal Mulai Cicilan:",
                        hint: "Pilih Tanggal Cicilan",
                        controller: _firstInstallmentController,
                        state: TransactionFieldState.firstInstallmentDateTime,
                        callback: () {
                          setState(() {
                            _isDateSelectorVisible = true;
                          });
                        },
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      // Container(
                      //   height: 40.h,
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     color: primaryColor,
                      //     borderRadius: BorderRadius.all(
                      //       Radius.circular(12.r),
                      //     ),
                      //     border: Border.all(
                      //       color: borderColor,
                      //       width: 1.5.w,
                      //     ),
                      //   ),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(12.r),
                      //     child: MaterialButton(
                      //       onPressed: () {
                      //         setState(() {});
                      //       },
                      //       child: Text("Cek tingkat kebutuhanmu di sini",
                      //           style: AppFontStyle.homeSubTitleText
                      //               .copyWith(color: lightColor)),
                      //     ),
                      //   ),
                      // ),
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
                            onPressed: () async {
                              if (!_providerController.hasValue ||
                                  _installmentController.text.isEmpty ||
                                  _totalController.text.isEmpty ||
                                  _periodController.text.isEmpty ||
                                  _firstInstallmentController.text.isEmpty) {
                                EasyLoading.showError(
                                    "Mohon isi semua field dengan benar");
                                return;
                              }

                              try {
                                EasyLoading.show(status: 'Loading...');
                                DateTime parsedDate = DateFormat('yyyy-MM-dd')
                                    .parse(_firstInstallmentController.text);
                                String selectedDate =
                                    DateFormat('yyyy-MM-ddTHH:mm:ss+00:00')
                                        .format(parsedDate.toUtc());
                                bool result = await storeTransaction(
                                    context: context,
                                    paylaterId: _providerController.value!.id,
                                    monthlyInstallment:
                                        double.parse(_totalController.text),
                                    period: periodList[
                                            int.parse(_periodController.text) -
                                                1]
                                        .value,
                                    firstInstallmentDateTime: selectedDate);

                                if (result) {
                                  setState(() {
                                    _providerController.value = _hotlines[0];
                                    _installmentController.text = "";
                                    _totalController.text = "";
                                    _periodController.text = "";
                                    _firstInstallmentController.text = "";
                                  });
                                }
                                EasyLoading.dismiss();
                              } catch (e) {
                                EasyLoading.showError(
                                    "Mohon isi semua field dengan benar");
                              }
                            },
                            child: Text("Tambahkan Transkasi",
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
              DateSelector(
                visible: _isDateSelectorVisible,
                onDismiss: (args) {
                  setState(() {
                    _isDateSelectorVisible = false;
                  _firstInstallmentController.text = args;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
