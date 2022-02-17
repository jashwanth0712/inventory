part of 'signup_bloc.dart';

class SignupState extends Equatable {
  const SignupState({
    this.status = FormzStatus.pure,
    this.collegeMail = const CollegeMail.pure(),
    this.rollNumber = const RollNumber.pure(),
    this.password = const Password.pure(),
    this.errorMessage = '',
  });

  final FormzStatus status;
  final CollegeMail collegeMail;
  final RollNumber rollNumber;
  final Password password;
  final String errorMessage;

  SignupState copyWith({
    FormzStatus? status,
    CollegeMail? collegeMail,
    RollNumber? rollNumber,
    Password? password,
    String? errorMessage,
  }) {
    return SignupState(
      status: status ?? this.status,
      collegeMail: collegeMail ?? this.collegeMail,
      rollNumber: rollNumber ?? this.rollNumber,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        collegeMail,
        rollNumber,
        password,
        errorMessage,
      ];
}
