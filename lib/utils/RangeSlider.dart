import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class RangePicker extends StatefulWidget {
  final dynamic maxSalary ;
  const RangePicker({super.key, required this.maxSalary});
  static  double startValue = 1000;
  static double endValue = 5000;
  @override
  RangePickerState createState() => RangePickerState();
}

class RangePickerState extends State<RangePicker> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ Flexible(
          child: RangeSlider(
              activeColor: AppColors.blueThemeColor,
              values: RangeValues(RangePicker.startValue, RangePicker.endValue),
              onChanged: (RangeValues values) {
                setState(() {
                  RangePicker.startValue = values.start;
                  RangePicker.endValue = values.end;
                });
              },
              min: 0.0,
              max: widget.maxSalary,
              divisions: 100,
              labels: RangeLabels('${RangePicker.startValue}', '${ RangePicker.endValue}'),
            ),
        ),
          Text('Selected Range: ${RangePicker.startValue.toInt()} - ${RangePicker.endValue.toInt()}'),
        ],
      ),
    );
  }
}
