import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../cubits/auth/login/login_cubit.dart';
import '../../../cubits/auth/login/login_state.dart';
import '../../../core/function/handling_page.dart';
import '../../widgets/auth/auth_header.dart';
import '../../widgets/auth/footer_links.dart';
import '../../widgets/auth/forget_password.dart';
import '../../widgets/auth/login_form.dart';
import '../../widgets/auth/social_login_buttons.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        child: Center(
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return HandlingPage(
                isLoading: state is LoginLoading,
                serverErrorMessage: loginCubit.serverErrorMessage,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // Header Animation
                    AuthHeader(
                      name: 'assets/lottie/login.json',
                      height: MediaQuery.of(context).size.height / 3,
                    ),

                    // Login Form
                    LoginForm(
                      keyForm: loginCubit.loginForm,
                      emailController: loginCubit.emailController,
                      passwordController: loginCubit.passwordController,
                      obscureText: loginCubit.obscureText,
                      togglevisibility: () => loginCubit.toggleVisibility(),
                    ),

                    // Login Button
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: CustomButton(
                        onPressed: () => loginCubit.login(context),
                        text: 'Login',
                      ),
                    ),

                    // Forgot Password
                    ForgetPassword(
                      onPressed: () => loginCubit.forgetPassNav(context),
                      text: 'Forget your password ?',
                    ),

                    // Social Login Button
                    SocialLoginButtons(
                      onTap: () => loginCubit.loginWithGoogle(context),
                      icon: SvgPicture.asset('assets/icons/google.svg'),
                      text: 'Continue with Google',
                    ),

                    // Footer Links
                    FooterLinks(
                      onPressed: () => loginCubit.registerNav(context),
                      text: 'Don\'t have an account?',
                      btnText: 'Register',
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
