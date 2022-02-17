import 'package:formz/formz.dart';
import 'package:inventory/utils/validators.dart';

enum AdminNameValidationError { invalid }

class AdminName extends FormzInput<String, AdminNameValidationError> {
  const AdminName.pure() : super.pure('');
  const AdminName.dirty([String value = '']) : super.dirty(value);

  @override
  AdminNameValidationError? validator(String? value) {
    return Validators.isValidAdminName(value ?? '')
        ? null
        : AdminNameValidationError.invalid;
  }
}
