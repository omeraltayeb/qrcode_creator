import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/auth/register/register_cubit.dart';
import '../../../cubits/auth/register/register_state.dart';
import '../../widgets/auth/footer_links.dart';
import '../../widgets/auth/profile_image.dart';
import '../../widgets/auth/register_form.dart';
import '../../../core/function/handling_page.dart';
import '../../widgets/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        child: Center(
          child: BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              return HandlingPage(
                isLoading: state is RegisterLoading,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ProfileImage(
                      onTap: () => registerCubit.changeProfile(context),
                      image: registerCubit.image == null
                          ? const AssetImage('assets/images/profile.png')
                          : FileImage(registerCubit.image!),
                    ),
                    RegisterForm(
                      registeKey: registerCubit.registerForm,
                      nameController: registerCubit.nameController,
                      emailController: registerCubit.emailController,
                      passwordController: registerCubit.passwordController,
                      confirmController:
                          registerCubit.confirmPasswordController,
                      obscureText: registerCubit.obscureText,
                      togglevisibility: () => registerCubit.toggleVisibility(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CustomButton(
                        onPressed: () => registerCubit.register(context),
                        text: 'Register',
                      ),
                    ),
                    FooterLinks(
                      onPressed: () => registerCubit.loginNav(context),
                      text: "Do you have an account?",
                      btnText: "Login",
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
