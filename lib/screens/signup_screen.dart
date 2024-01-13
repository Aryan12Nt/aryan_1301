
import 'package:aryan_01/bloc/user_bloc/user_bloc.dart';
import 'package:aryan_01/custom_widget/custom_button.dart';
import 'package:aryan_01/custom_widget/custom_text_field.dart';
import 'package:aryan_01/custom_widget/gap.dart';
import 'package:aryan_01/repository/app_repo.dart';
import 'package:aryan_01/screens/home_screen.dart';
import 'package:aryan_01/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../bloc/sign_up_bloc/sign_up_bloc.dart';
import '../models/user_model.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signUpEmailBloc = BlocProvider.of<SignUpBloc>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "SignUp",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignInSuccessState) {
              context.read<UserBloc>().add(UploadUserDataEvent(
                      user: UserModel(
                    email: emailController.text,
                    uid: AppRepo().uid,
                    userName: userNameController.text,
                  )));
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            // selectedIndex: 0,
                          )));
            }
            if (state is SignInFailState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            return BlocBuilder<SignUpBloc, SignUpState>(
              bloc: signUpEmailBloc,
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
                          "SignUp",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w600),
                        ),
                        CustomTextFieldTitle(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return "Field can't be empty";
                              }
                              return null;
                            },
                            controller: userNameController,
                            fieldTitle: "UserName"),
                        const Gap2(),
                        CustomTextFieldTitle(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email address';
                              }
                              final emailRegExp =
                                  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                              if (!emailRegExp.hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }

                              return null;
                            },
                            controller: emailController,
                            fieldTitle: "Email"),
                        const Gap2(),
                        CustomTextFieldTitle(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return "Field can't be empty";
                              } else if (p0.length < 6) {
                                return "Password must be more then 6 digit";
                              }
                              return null;
                            },
                            controller: passwordController,
                            fieldTitle: "Password"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (_) => LoginScreen()),
                                    (route) => false,
                                  );
                                },
                                child: Text("Login"))
                          ],
                        ),
                        const Gap3(),
                        CustomButton(
                          isLoading: state is LoadingState,
                          textColor: Colors.white,
                          height: 6.h,
                          width: 20.w,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              signUpEmailBloc.add(
                                SignUpWithEmailPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                            }
                          },
                          buttonText: "SignUp",
                          buttonColor: Colors.deepPurple,
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
