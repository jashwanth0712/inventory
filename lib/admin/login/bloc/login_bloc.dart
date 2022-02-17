import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:inventory/admin/models/models.dart';
import 'package:inventory_repository/inventory_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.admin}) : super(const LoginState()) {
    on<LoginAdminNameChanged>(_onAdminNameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginFormSubmitted>(_onSubmitted);
  }

  Admin admin;
  void _onAdminNameChanged(
    LoginAdminNameChanged event,
    Emitter<LoginState> emit,
  ) {
    final adminName = AdminName.dirty(event.adminName);
    emit(
      state.copyWith(
        adminName: adminName,
        status: Formz.validate(
          <FormzInput>[
            adminName,
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
            state.adminName,
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
      try {
        admin = admin.copyWith(
          adminName: state.adminName.value,
          adminPassword: state.password.value,
        );
        await admin.login();
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
      const adminName = AdminName.dirty('');
      const password = Password.dirty('');

      emit(state.copyWith(
          adminName: adminName,
          password: password,
          status: Formz.validate(
            <FormzInput>[
              state.password,
              state.adminName,
            ],
          )));
    }
  }
}
