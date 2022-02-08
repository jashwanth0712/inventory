import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory/auth/login_bloc/login_bloc.dart';
import 'package:inventory/constants.dart';
import 'package:inventory_repository/inventory_repository.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);
  final Student _student = Student();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(student: _student),
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
              errorText: state.collegeMail.invalid ? '💥 Invalid Mailns' : null,
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

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

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
              onTap: (() => {
                    context.read<LoginBloc>().add(
                          LoginFormSubmitted(
                            state.collegeMail.toString(),
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
                    "Login",
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
