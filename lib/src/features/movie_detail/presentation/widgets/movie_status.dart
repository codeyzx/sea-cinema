import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../common_config/palette.dart';

class MovieStatus extends StatelessWidget {
  final IconData? icon;
  final String? text;

  const MovieStatus({Key? key, required this.icon, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon ?? FontAwesomeIcons.calendarWeek,
          color: Palette.color[200],
          size: 16.0.sp,
        ),
        SizedBox(height: 5.0.sp),
        Text(
          text ?? '-',
          style: TextStyle(
            color: Palette.color[200],
            fontSize: 10.0.sp,
          ),
        ),
      ],
    );
  }
}
