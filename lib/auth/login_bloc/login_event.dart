part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginCollegeMailChanged extends LoginEvent {
  const LoginCollegeMailChanged(this.collegeMail);
  final String collegeMail;
  @override
  List<Object> get props => [
        collegeMail,
      ];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);
  final String password;
  @override
  List<Object> get props => [
        password,
      ];
}

class LoginFormSubmitted extends LoginEvent {
  const LoginFormSubmitted(this.collegeMail, this.password);
  final String collegeMail;
  final String password;
  @override
  List<Object> get props => [
        collegeMail,
        password,
      ];
}
