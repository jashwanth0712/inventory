import 'package:formz/formz.dart';
import 'package:inventory/utils/validators.dart';

enum RollNumberValidationError { invalid }

class RollNumber extends FormzInput<String, RollNumberValidationError> {
  const RollNumber.pure() : super.pure('');
  const RollNumber.dirty([String value = '']) : super.dirty(value);

  @override
  RollNumberValidationError? validator(String? value) {
    return Validators.isValidRollNumber(value ?? '')
        ? null
        : RollNumberValidationError.invalid;
  }
}
