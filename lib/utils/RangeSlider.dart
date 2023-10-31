import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class RangePicker extends StatefulWidget {
  const RangePicker({super.key});

  @override
  RangePickerState createState() => RangePickerState();
}

class RangePickerState extends State<RangePicker> {
  double _startValue = 25.0;
  double _endValue = 75.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ Flexible(
          child: RangeSlider(
              activeColor: AppColors.blueThemeColor,
              values: RangeValues(_startValue, _endValue),
              onChanged: (RangeValues values) {
                setState(() {
                  _startValue = values.start;
                  _endValue = values.end;
                });
              },
              min: 0.0,
              max: 100.0,
              divisions: 100,
              labels: RangeLabels('$_startValue', '$_endValue'),
            ),
        ),
          Text('Selected Range: ${_startValue.toInt()} - ${_endValue.toInt()}'),
        ],
      ),
    );
  }
}
