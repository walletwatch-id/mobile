import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_watch/common/data/self_discovery.dart';

class SelfDiscoveryItem extends StatefulWidget {
  final int number;
  final SelfDiscovery selfDiscovery;
  const SelfDiscoveryItem(
      {super.key, required this.number, required this.selfDiscovery});

  @override
  State<SelfDiscoveryItem> createState() => _SelfDiscoveryItemState();
}

class _SelfDiscoveryItemState extends State<SelfDiscoveryItem> {
  int _selectedValue = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 12,
                child: Text(
                  '${widget.number}',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.selfDiscovery.content,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tidak\nSetuju',
                style: TextStyle(color: Colors.red, fontSize: 12.sp),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Row(
                    children: [
                      Radio<int>(
                        value: index,
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                    ],
                  );
                }),
              ),
              Text(
                'Sangat\nSetuju',
                style: TextStyle(color: Colors.green, fontSize: 12.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
