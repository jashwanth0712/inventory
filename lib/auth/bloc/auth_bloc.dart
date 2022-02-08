import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:inventory/models/models.dart';
import 'package:inventory_repository/inventory_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.student}) : super(const AuthState()) {
    on<AuthCollegeMailChanged>(_onCollegeMailChanged);
    on<AuthPasswordChanged>(_onPasswordChanged);
    on<AuthRollNumberChanged>(_onRollNumberChanged);
    on<SignupFormSubmitted>(_onSignupSubmitted);
    on<LoginFormSubmitted>(_onLoginSubmitted);
  }

  Student student;

  void _onCollegeMailChanged(
    AuthCollegeMailChanged event,
    Emitter<AuthState> emit,
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

  void _onRollNumberChanged(
    AuthRollNumberChanged event,
    Emitter<AuthState> emit,
  ) {
    final rollNumber = RollNumber.dirty(event.rollNumber);
    emit(
      state.copyWith(
        rollNumber: rollNumber,
        status: Formz.validate(
          <FormzInput>[
            rollNumber,
            state.password,
            state.collegeMail,
          ],
        ),
      ),
    );
  }

  void _onPasswordChanged(
    AuthPasswordChanged event,
    Emitter<AuthState> emit,
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

  void _onSignupSubmitted(
    SignupFormSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: Formz.validate(
          <FormzInput>[
            state.password,
            state.collegeMail,
            state.rollNumber,
          ],
        ),
      ),
    );
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
    }
    try {
      student = student.copyWith(
        collegeMail: state.collegeMail.toString(),
        password: state.password.toString(),
        rollNumber: state.rollNumber.toString(),
      );
      await student.signup();
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

  void _onLoginSubmitted(
    LoginFormSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: Formz.validate(
          <FormzInput>[
            state.password,
            state.collegeMail,
          ],
        ),
      ),
    );
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
