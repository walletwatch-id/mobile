import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateSelector extends StatefulWidget {
  final bool visible;
  final Function(String) onDismiss;
  const DateSelector({super.key, required this.visible, required this.onDismiss});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  String selectedDate = "";

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        selectedDate = DateFormat('yyyy-MM-dd').format(args.value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (MediaQuery.of(context).viewInsets.bottom == 0.0) {
              widget.onDismiss(selectedDate);
            }
          },
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              content: GestureDetector(
                onTap: () {},
                child: Container(
                    height: 400,
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * .1),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: SfDateRangePicker(
                      view: DateRangePickerView.decade,
                      onSelectionChanged: _onSelectionChanged,
                      selectionMode: DateRangePickerSelectionMode.single,
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
