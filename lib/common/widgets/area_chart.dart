import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:walletwatch_mobile/common/data/chart_data.dart';
import 'package:walletwatch_mobile/common/helper.dart';
import 'package:walletwatch_mobile/common/theme/app_color_style.dart';
import 'package:walletwatch_mobile/common/theme/app_font_style.dart';

class AreaChart extends StatefulWidget {
  final String title;
  final Color color;
  final List<ChartData> data;
  final String? yName;
  const AreaChart(
      {super.key,
      required this.title,
      required this.color,
      required this.data,
      this.yName});

  @override
  AreaChartState createState() => AreaChartState();
}

class AreaChartState extends State<AreaChart> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      backgroundColor: Colors.transparent,
      plotAreaBorderColor: darkColor,
      primaryXAxis: CategoryAxis(
        minimum: 0,
        labelStyle: AppFontStyle.chartLabelText.copyWith(color: darkColor),
        majorGridLines: const MajorGridLines(color: Colors.transparent),
        majorTickLines: MajorTickLines(color: darkColor),
        axisLine: const AxisLine(color: Colors.transparent),
      ),
      primaryYAxis: NumericAxis(
        minimum: 0,
        labelStyle: AppFontStyle.chartLabelText.copyWith(color: darkColor),
        majorGridLines: const MajorGridLines(color: Colors.transparent),
        minorGridLines: MinorGridLines(color: darkColor),
        majorTickLines: MajorTickLines(color: darkColor),
        axisLine: const AxisLine(color: Colors.transparent),
      ),
      tooltipBehavior: TooltipBehavior(
          enable: true,
          color: widget.color,
          format: 'point.x : point.y ${widget.yName ?? 'Juta'}',
          textStyle: AppFontStyle.chartLabelText.copyWith(color: lightColor)),
      legend: Legend(
        isVisible: true,
        textStyle: AppFontStyle.chartLabelText.copyWith(color: darkColor),
      ),
      series: <CartesianSeries<ChartData, String>>[
        AreaSeries<ChartData, String>(
          dataSource: widget.data,
          gradient: LinearGradient(colors: [
            widget.color,
            widget.color.withOpacity(.6),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          markerSettings: const MarkerSettings(
              isVisible: true, shape: DataMarkerType.circle),
          xValueMapper: (ChartData data, _) => data.x.toString(),
          yValueMapper: (ChartData data, _) => data.y,
          borderDrawMode: BorderDrawMode.excludeBottom,
          name: widget.title,
          legendIconType: LegendIconType.circle,
        )
      ],
    );
  }
}
