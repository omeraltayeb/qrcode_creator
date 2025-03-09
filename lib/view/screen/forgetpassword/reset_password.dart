import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/function/handling_page.dart';
import '../../../cubits/forgetpassword/resetPassword/reset_password_cubit.dart';
import '../../../cubits/forgetpassword/resetPassword/reset_password_state.dart';
import '../../widgets/auth/auth_header.dart';
import '../../widgets/auth/reset_password_form.dart';
import '../../widgets/custom_button.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, this.email});
  final String? email;
  @override
  Widget build(BuildContext context) {
    final resetCubit = context.read<ResetPasswordCubit>();
    return Scaffold(
      body: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
        builder: (context, state) {
          return HandlingPage(
            isLoading: state is ResetPasswordLoading,
            serverErrorMessage: resetCubit.serverErrorMessage,
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                AuthHeader(
                  name: 'assets/lottie/forget_password.json',
                  height: MediaQuery.of(context).size.height / 2.5,
                ),
                ResetPasswordForm(
                  resetKey: resetCubit.resetForm,
                  passController: resetCubit.passwordController,
                  confirmController: resetCubit.confirmPasswordController,
                  obscurePassword: resetCubit.obscureText,
                  obscureConfirmPassword: resetCubit.obscureConfirmPassword,
                  onTogglePasswordVisibility: () =>
                      resetCubit.toggleVisibility(),
                  onToggleConfirmPasswordVisibility: () =>
                      resetCubit.toggleConfirmPasswordVisibility(),
                ),
                CustomButton(
                  text: 'Reset Password',
                  onPressed: () => resetCubit.resetPassword(context, email!),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
