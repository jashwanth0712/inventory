part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
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

  AuthState copyWith({
    FormzStatus? status,
    CollegeMail? collegeMail,
    RollNumber? rollNumber,
    Password? password,
    String? errorMessage,
  }) {
    return AuthState(
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
