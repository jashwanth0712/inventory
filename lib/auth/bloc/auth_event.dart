part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCollegeMailChanged extends AuthEvent {
  const AuthCollegeMailChanged(this.collegeMail);
  final String collegeMail;
  @override
  List<Object> get props => [
        collegeMail,
      ];
}

class AuthRollNumberChanged extends AuthEvent {
  const AuthRollNumberChanged(this.rollNumber);
  final String rollNumber;
  @override
  List<Object> get props => [
        rollNumber,
      ];
}

class AuthPasswordChanged extends AuthEvent {
  const AuthPasswordChanged(this.password);
  final String password;
  @override
  List<Object> get props => [
        password,
      ];
}

class SignupFormSubmitted extends AuthEvent {
  const SignupFormSubmitted(this.collegeMail, this.rollNumber, this.password);
  final String collegeMail;
  final String rollNumber;
  final String password;
  @override
  List<Object> get props => [
        collegeMail,
        rollNumber,
        password,
      ];
}

class LoginFormSubmitted extends AuthEvent {
  const LoginFormSubmitted(this.collegeMail, this.password);
  final String collegeMail;
  final String password;
  @override
  List<Object> get props => [
        collegeMail,
        password,
      ];
}
