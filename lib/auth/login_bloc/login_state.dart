part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.collegeMail = const CollegeMail.pure(),
    this.password = const Password.pure(),
    this.errorMessage = '',
  });

  final FormzStatus status;
  final CollegeMail collegeMail;
  final Password password;
  final String errorMessage;

  LoginState copyWith({
    FormzStatus? status,
    CollegeMail? collegeMail,
    Password? password,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      collegeMail: collegeMail ?? this.collegeMail,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        collegeMail,
        password,
        errorMessage,
      ];
}

class LoginInitial extends LoginState {}
