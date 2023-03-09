import 'package:flutter/material.dart';

import '../model/alignment_info.dart';

class AlignmentWidget extends StatelessWidget {
  final AlignmentInfo alignmentInfo;
  final BorderRadius borderRadius;

  const AlignmentWidget({
    Key? key,
    required this.alignmentInfo, required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Container(
        decoration: BoxDecoration(
          color: alignmentInfo.color,
          borderRadius: borderRadius,
        ),
        padding: EdgeInsets.symmetric(vertical: 6.0),
        height: 24,
        width: 70,
        alignment: Alignment.center,
        child: Center(
          child: Text(
            alignmentInfo.name.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}