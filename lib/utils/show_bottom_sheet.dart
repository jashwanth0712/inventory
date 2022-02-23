import 'package:flutter/material.dart';

void buildBottomSheet({required Widget child, required BuildContext context}) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    context: context,
    builder: (context) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context);
      },
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    ),
  );
}
