import 'package:aryan_01/bloc/sigin_in_bloc/auth_bloc.dart';
import 'package:aryan_01/custom_widget/custom_button.dart';
import 'package:aryan_01/custom_widget/custom_text_field.dart';
import 'package:aryan_01/custom_widget/gap.dart';
import 'package:aryan_01/screens/home_screen.dart';
import 'package:aryan_01/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signInEmailBloc = BlocProvider.of<SignInEmailBloc>(context);

    return FutureBuilder<User?>(
      future: FirebaseAuth.instance.authStateChanges().first,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final bool isAuthenticated = snapshot.hasData;
          if (isAuthenticated) {
            return HomeScreen(
              // selectedIndex: 0,
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.deepPurple,
                title: const Text(
                  "Login Screen",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: BlocConsumer<SignInEmailBloc, SignInEmailState>(
                listener: (context, state) {
                  if (state is SignInSuccessState) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen()),
                    );
                  } else if (state is SignInFailState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return BlocBuilder<SignInEmailBloc, SignInEmailState>(
                    bloc: signInEmailBloc,
                    builder: (context, state) {
                      return Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Gap(
                                height: 10.h,
                              ),
                              Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              CustomTextFieldTitle(
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return "Field can't be empty";
                                  }
                                  return null;
                                },
                                controller: emailController,
                                fieldTitle: "Email",
                              ),
                              Gap2(),
                              CustomTextFieldTitle(
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return "Field can't be empty";
                                  }
                                  return null;
                                },
                                controller: passwordController,
                                fieldTitle: "Password",
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have an account?"),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUpScreen(),
                                        ),
                                      );
                                    },
                                    child: Text("Sign up"),
                                  ),
                                ],
                              ),
                              Gap3(),
                              CustomButton(
                                isLoading: state is LoadingState,
                                textColor: Colors.white,
                                height: 6.h,
                                width: 20.w,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    signInEmailBloc.add(
                                      SignInWithEmailPassword(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                                  }
                                },
                                buttonText: "Login",
                                buttonColor: Colors.deepPurple,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }
        }
      },
    );
  }
}
