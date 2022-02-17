part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.adminName = const AdminName.pure(),
    this.password = const Password.pure(),
    this.errorMessage = '',
  });

  final FormzStatus status;
  final AdminName adminName;
  final Password password;
  final String errorMessage;

  LoginState copyWith({
    FormzStatus? status,
    AdminName? adminName,
    Password? password,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      adminName: adminName ?? this.adminName,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        adminName,
        password,
        errorMessage,
      ];
}

class LoginInitial extends LoginState {}
