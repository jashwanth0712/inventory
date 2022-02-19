import 'package:flutter/material.dart';
import 'package:inventory_repository/inventory_repository.dart';

class NoticeProvider with ChangeNotifier {
  String _title = '';
  String _description = '';
  bool isTitleDirty = false;
  bool isDescDirty = false;
  bool _valid = true;
  bool _isSubmitting = false;
  bool _isSubmitted = false;
  bool _isSuccess = false;

  String get title => _title;
  String get description => _description;
  bool get isSubmitting => _isSubmitting;
  bool get isSubmitted => _isSubmitted;
  bool get isSuccess => _isSuccess;

  void changeTitle({required String title}) {
    _title = title;
    isTitleDirty = true;
    notifyListeners();
  }

  void changeDescription({required String description}) {
    _description = description;
    isDescDirty = true;
    notifyListeners();
  }

  bool _validated() {
    if (title.isNotEmpty && description.isNotEmpty) {
      _valid = true;
    } else {
      _valid = false;
    }
    return _valid;
  }

  void submitting() {
    _isSubmitting = true;
    notifyListeners();
  }

  void submitted({required Admin admin}) async {
    if (_validated()) {
      try {
        _isSubmitted = true;
        await admin.notice.create(title: title, description: description);
        _isSubmitting = false;
        _isSuccess = true;
        notifyListeners();
      } on APIRequestError catch (_) {
        _isSuccess = false;
      }
    } else {
      _isSubmitting = false;
      changeTitle(title: title);
      changeDescription(description: description);
    }
  }

  void resetSubmission() {
    _isSubmitted = false;
    notifyListeners();
  }

  void resetAll() {
    _isSuccess = false;
    _title = '';
    _description = '';
    isTitleDirty = false;
    isDescDirty = false;
    _valid = true;
  }
}
