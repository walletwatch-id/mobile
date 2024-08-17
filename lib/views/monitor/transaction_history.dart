import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:walletwatch_mobile/common/data/transaction.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'package:walletwatch_mobile/common/http/transaction.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';
import 'package:walletwatch_mobile/common/widgets/top_bar.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  bool isSettingVisible = false;
  final List<Transaction> _transactions = [];

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, statusBarColor: lightColor));
    EasyLoading.init();
    loadPage();
    super.initState();
  }

  void loadPage() async {
    EasyLoading.show(status: 'Loading...');
    final transactions = await fetchTransactions();
    setState(() {
      _transactions.clear();
      _transactions.addAll(transactions);
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightColor,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: TopBar(
                title: "Histori Transaksi",
                textColor: darkColor,
                canClose: true,
                settingAction: () {},
              ),
            ),
            Positioned(
              top: 55.h,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Container(
                    height: 60.h,
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                                  width: 56.h, height: 56.h, child: user.image),
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
                                  user.name,
                                  style: AppFontStyle.accountNameText,
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  "Selamat datang di Aplikasi WalletWatch!",
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
                  Container(
                    height: 40.h,
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CupertinoColors.lightBackgroundGray,
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
                        onPressed: () {},
                        child: Text("Berikut adalah histori transaksi Anda",
                            style: AppFontStyle.homeSubTitleText.copyWith(
                                color: darkColor,
                                fontSize: 14.sp,
                                height: 1.4)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 180.h,
              right: 0,
              left: 0,
              bottom: 0,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final transaction = _transactions[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1.w, color: borderColor)),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 14.h,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Text(
                                  'ID: ${transaction.id}',
                                  style: AppFontStyle.homeSubTitleText.copyWith(
                                      fontSize: 14.sp, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Installment: ${formatCurrency((transaction.monthlyInstallment).toDouble())}',
                            style: TextStyle(fontSize: 13.sp, color: subColor),
                          ),
                          Text(
                            'Period: ${transaction.period} months',
                            style: TextStyle(fontSize: 13.sp, color: subColor),
                          ),
                          Text(
                            'Transaction Date: ${DateFormat('MMMM d, y, h:mm a').format(transaction.transactionDatetime)}',
                            style: TextStyle(fontSize: 13.sp, color: subColor),
                          ),
                          SizedBox(height: 16.h),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'Total: ${formatCurrency((transaction.monthlyInstallment * transaction.period).toDouble())}',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
