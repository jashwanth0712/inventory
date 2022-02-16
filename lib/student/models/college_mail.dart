import 'package:formz/formz.dart';
import 'package:inventory/utils/validators.dart';

enum CollegeMailValidationError { invalid }

class CollegeMail extends FormzInput<String, CollegeMailValidationError> {
  const CollegeMail.pure() : super.pure('');
  const CollegeMail.dirty([String value = '']) : super.dirty(value);

  @override
  CollegeMailValidationError? validator(String? value) {
    return Validators.isValidCollegeMail(value ?? '')
        ? null
        : CollegeMailValidationError.invalid;
  }
}
