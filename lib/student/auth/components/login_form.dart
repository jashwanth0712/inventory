import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:inventory/student/auth/login_bloc/login_bloc.dart';
import 'package:inventory/constants.dart';
import 'package:inventory/home/home.dart';
import 'package:inventory_repository/inventory_repository.dart';

class SLoginForm extends StatelessWidget {
  SLoginForm({Key? key}) : super(key: key);
  final Student _student = Student();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(student: _student),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            final String errorMessage = state.errorMessage;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(errorMessage),
                      Icon(
                        Icons.error,
                        color: Colors.red.shade700,
                      ),
                    ],
                  ),
                ),
              );
          }
          if (state.status.isSubmissionInProgress) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text('Logging In...'),
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    ],
                  ),
                ),
              );
          }
          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Successfully Logged In'),
                      Icon(
                        Icons.task_alt,
                        color: Colors.green.shade400,
                      ),
                    ],
                  ),
                ),
              );
            Navigator.pushNamed(
              context,
              Home.route,
            );
          }
        },
        child: Form(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      "Welcome back!",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  CollegeMailInput(),
                  SizedBox(
                    height: 20,
                  ),
                  PasswordInput(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text("Forgot Password?"),
                  )
                ],
              ),
              const LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class CollegeMailInput extends StatelessWidget {
  const CollegeMailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prevState, curState) => prevState != curState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (val) {
              context.read<LoginBloc>().add(
                    LoginCollegeMailChanged(val),
                  );
            },
            decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
              labelText: 'Mail ID',
              errorText:
                  state.collegeMail.invalid ? '💥 Invalid mail ID' : null,
              hintText: 'Enter your college mail ID',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: state.collegeMail.valid
                      ? Colors.green.shade400
                      : AppColors.primaryColor,
                  width: 3.0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PasswordInput extends StatefulWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prevState, curState) => prevState != curState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (val) {
              context.read<LoginBloc>().add(
                    LoginPasswordChanged(val),
                  );
            },
            obscureText: !show,
            decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
              labelText: 'Password',
              errorText: state.password.invalid
                  ? '💥 Password must contain minimum 8 chars'
                  : null,
              hintText: 'Enter your password',
              suffixIcon: IconButton(
                icon: Icon(
                  !show
                      ? Icons.remove_red_eye_rounded
                      : Icons.remove_red_eye_outlined,
                  color: AppColors.primaryColor,
                ),
                onPressed: (() {
                  setState(() {
                    show = !show;
                  });
                }),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: state.password.valid
                      ? Colors.green.shade400
                      : AppColors.primaryColor,
                  width: 3.0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prevState, curState) => prevState != curState,
      builder: (context, state) {
        return Positioned(
          bottom: 50,
          right: 30,
          child: InkWell(
            onTap: (() {
              context.read<LoginBloc>().add(
                    LoginFormSubmitted(
                      state.collegeMail.value,
                      state.password.value,
                    ),
                  );
            }),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 25.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    offset: Offset(
                      5.0, // Move to right 10  horizontally
                      5.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
