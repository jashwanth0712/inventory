part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginAdminNameChanged extends LoginEvent {
  const LoginAdminNameChanged(this.adminName);
  final String adminName;
  @override
  List<Object> get props => [
        adminName,
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
  const LoginFormSubmitted(this.adminName, this.password);
  final String adminName;
  final String password;
  @override
  List<Object> get props => [
        adminName,
        password,
      ];
}
