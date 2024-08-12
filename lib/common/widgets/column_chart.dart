import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:walletwatch_mobile/common/data/chart_data.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';

class ColumnChart extends StatefulWidget {
  final String title;
  final Color color;
  final List<ChartData> data;
  const ColumnChart(
      {super.key,
      required this.title,
      required this.color,
      required this.data});

  @override
  ColumnChartState createState() => ColumnChartState();
}

class ColumnChartState extends State<ColumnChart> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      backgroundColor: Colors.transparent,
      plotAreaBorderColor: Colors.white,
      primaryXAxis: CategoryAxis(
        labelStyle: AppFontStyle.chartLabelText.copyWith(color: Colors.white),
        majorGridLines: const MajorGridLines(color: Colors.white),
        majorTickLines: const MajorTickLines(color: Colors.white),
        axisLine: const AxisLine(color: Colors.transparent),
      ),
      primaryYAxis: NumericAxis(
        minimum: 0,
        labelStyle: AppFontStyle.chartLabelText.copyWith(color: Colors.white),
        majorGridLines: const MajorGridLines(color: Colors.white),
        minorGridLines: const MinorGridLines(color: Colors.white),
        majorTickLines: const MajorTickLines(color: Colors.white),
        axisLine: const AxisLine(color: Colors.transparent),
      ),
      tooltipBehavior: TooltipBehavior(
          enable: true,
          color: const Color(0xFFCFA476),
          format: 'point.x : point.y Pelajar',
          textStyle: AppFontStyle.chartLabelText.copyWith(color: Colors.white)),
      legend: Legend(
        isVisible: true,
        textStyle: AppFontStyle.chartLabelText.copyWith(color: Colors.white),

      ),
      series: <CartesianSeries<ChartData, String>>[
        ColumnSeries<ChartData, String>(
          dataSource: widget.data,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4), topRight: Radius.circular(4)),
          xValueMapper: (ChartData data, _) => data.x.toString(),
          yValueMapper: (ChartData data, _) => data.y,
          pointColorMapper: (ChartData data, _) => data.color?.withOpacity(.8),
          // gradient: LinearGradient(colors: [
          //   widget.color,
          //   widget.color.withOpacity(.6),
          // ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          name: widget.title,
          legendIconType: LegendIconType.circle,

        ),
      ],
    );
  }
}
