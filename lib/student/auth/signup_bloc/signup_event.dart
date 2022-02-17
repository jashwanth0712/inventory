part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupCollegeMailChanged extends SignupEvent {
  const SignupCollegeMailChanged(this.collegeMail);
  final String collegeMail;
  @override
  List<Object> get props => [
        collegeMail,
      ];
}

class SignupRollNumberChanged extends SignupEvent {
  const SignupRollNumberChanged(this.rollNumber);
  final String rollNumber;
  @override
  List<Object> get props => [
        rollNumber,
      ];
}

class SignupPasswordChanged extends SignupEvent {
  const SignupPasswordChanged(this.password);
  final String password;
  @override
  List<Object> get props => [
        password,
      ];
}

class SignupFormSubmitted extends SignupEvent {
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
