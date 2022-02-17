import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:inventory/student/models/models.dart';
import 'package:inventory_repository/inventory_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({required this.student}) : super(const SignupState()) {
    on<SignupCollegeMailChanged>(_onCollegeMailChanged);
    on<SignupRollNumberChanged>(_onRollNumberChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupFormSubmitted>(_onSubmitted);
  }

  Student student;

  void _onCollegeMailChanged(
    SignupCollegeMailChanged event,
    Emitter<SignupState> emit,
  ) {
    final collegeMail = CollegeMail.dirty(event.collegeMail);
    emit(
      state.copyWith(
        collegeMail: collegeMail,
        status: Formz.validate(
          <FormzInput>[
            collegeMail,
            state.rollNumber,
            state.password,
          ],
        ),
      ),
    );
  }

  void _onRollNumberChanged(
    SignupRollNumberChanged event,
    Emitter<SignupState> emit,
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
    SignupPasswordChanged event,
    Emitter<SignupState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate(
          <FormzInput>[
            password,
            state.rollNumber,
            state.collegeMail,
          ],
        ),
      ),
    );
  }

  void _onSubmitted(
    SignupFormSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        student = student.copyWith(
          collegeMail: state.collegeMail.value,
          password: state.password.value,
          rollNumber: state.rollNumber.value,
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
    } else {
      const collegeMail = CollegeMail.dirty('');
      const password = Password.dirty('');
      const rollNumber = RollNumber.dirty('');
      emit(state.copyWith(
          collegeMail: collegeMail,
          password: password,
          rollNumber: rollNumber,
          status: Formz.validate(
            <FormzInput>[
              state.password,
              state.collegeMail,
              state.rollNumber,
            ],
          )));
    }
  }
}
