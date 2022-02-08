import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory/auth/signup_bloc/signup_bloc.dart';
import 'package:inventory/constants.dart';
import 'package:inventory_repository/inventory_repository.dart';

class SignupForm extends StatelessWidget {
  SignupForm({Key? key}) : super(key: key);
  final Student _student = Student();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(student: _student),
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
              errorText: state.collegeMail.invalid
                  ? '💥 Username must contain minimum 5 chars'
                  : null,
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

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

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
            decoration: AppTextFields.minimalTextFieldDecoration.copyWith(
              labelText: 'Password',
              errorText: state.password.invalid
                  ? '💥 Password must contain minimum 8 chars'
                  : null,
              hintText: 'Enter your password',
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
