import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:inventory/models/models.dart';
import 'package:inventory_repository/inventory_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.student}) : super(const LoginState()) {
    on<LoginCollegeMailChanged>(_onCollegeMailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginFormSubmitted>(_onSubmitted);
  }
  Student student;

  void _onCollegeMailChanged(
    LoginCollegeMailChanged event,
    Emitter<LoginState> emit,
  ) {
    final collegeMail = CollegeMail.dirty(event.collegeMail);
    emit(
      state.copyWith(
        collegeMail: collegeMail,
        status: Formz.validate(
          <FormzInput>[
            collegeMail,
            state.password,
          ],
        ),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate(
          <FormzInput>[
            password,
            state.collegeMail,
          ],
        ),
      ),
    );
  }

  void _onSubmitted(
    LoginFormSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
    }
    try {
      student = student.copyWith(
        collegeMail: state.collegeMail.toString(),
        password: state.password.toString(),
      );
      await student.login();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on APIRequestError catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          errorMessage: 'Unknown error occured',
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }
}
