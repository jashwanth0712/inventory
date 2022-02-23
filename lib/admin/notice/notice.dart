import 'package:flutter/material.dart';
import 'package:inventory/admin/notice/views/notice_screen.dart';

class Notice extends StatelessWidget {
  static const route = '/notice';
  const Notice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NoticeScreen();
  }
}
