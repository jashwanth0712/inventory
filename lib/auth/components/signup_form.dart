import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:inventory/auth/signup_bloc/signup_bloc.dart';
import 'package:inventory/constants.dart';
import 'package:inventory/home/home.dart';
import 'package:inventory_repository/inventory_repository.dart';

class SignupForm extends StatelessWidget {
  SignupForm({Key? key}) : super(key: key);
  final Student _student = Student();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(student: _student),
      child: BlocListener<SignupBloc, SignupState>(
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
                      Text('Creating account...'),
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
                      const Text('Successfully Created'),
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
                      "Welcome!",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  CollegeMailInput(),
                  SizedBox(
                    height: 25,
                  ),
                  RollNumberInput(),
                  SizedBox(
                    height: 25,
                  ),
                  PasswordInput()
                ],
              ),
              const SignupButton(),
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
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (prevState, curState) => prevState != curState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (val) {
              context.read<SignupBloc>().add(
                    SignupCollegeMailChanged(val),
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

class RollNumberInput extends StatelessWidget {
  const RollNumberInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (prevState, curState) => prevState != curState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (val) {
              context.read<SignupBloc>().add(
                    SignupRollNumberChanged(val),
                  );
            },
            decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
              labelText: 'Roll Number',
              errorText:
                  state.rollNumber.invalid ? '💥 Roll Number is invalid' : null,
              hintText: 'Enter your roll number',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: state.rollNumber.valid
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
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (prevState, curState) => prevState != curState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (val) {
              context.read<SignupBloc>().add(
                    SignupPasswordChanged(val),
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

class SignupButton extends StatelessWidget {
  const SignupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (prevState, curState) => prevState != curState,
      builder: (context, state) {
        return Positioned(
            bottom: 50,
            right: 30,
            child: InkWell(
              onTap: (() => {
                    context.read<SignupBloc>().add(
                          SignupFormSubmitted(
                            state.collegeMail.toString(),
                            state.rollNumber.toString(),
                            state.password.toString(),
                          ),
                        )
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
                    "Signup",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
