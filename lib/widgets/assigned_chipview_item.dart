import 'package:customers_payments/views/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../core/app_export.dart';

// ignore: must_be_immutable
class AssignedChipViewItem extends StatelessWidget {
  const AssignedChipViewItem({Key? key,required String name})
      : super(
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(
        horizontal: 7.h,
        vertical: 4.v,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        name!,
        style: TextStyle(
          color: appTheme.redA700,
          fontSize: 10.fSize,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
        ),
      ),
      selected: false,
      backgroundColor: appTheme.gray50,
      selectedColor: appTheme.gray50,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(
          10.h,
        ),
      ),
      onSelected: (value) {},
    );
  }
}
