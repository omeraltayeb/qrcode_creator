import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/function/handling_page.dart';
import '../../../cubits/auth/verifyRegister/verify_register_cubit.dart';
import '../../../cubits/auth/verifyRegister/verify_register_state.dart';
import '../../widgets/auth/auth_header.dart';
import '../../widgets/auth/custom_otp_text.dart';
import '../../widgets/auth/custom_verify_text.dart';
import '../../widgets/auth/resend_button.dart';

class VerifyRegisterScreen extends StatelessWidget {
  const VerifyRegisterScreen({super.key, this.email});
  final String? email;

  @override
  Widget build(BuildContext context) {
    final verifyCubit = context.read<VerifyRegisterCubit>();

    return Scaffold(
      body: BlocBuilder<VerifyRegisterCubit, VerifyRegisterState>(
        builder: (context, state) {
          return HandlingPage(
            isLoading: state is VerifyRegisterLoading,
            serverErrorMessage: verifyCubit.serverErrorMessage,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                // Header Animation
                AuthHeader(
                  name: 'assets/lottie/verifycode.json',
                  height: MediaQuery.of(context).size.height / 2,
                ),

                // Verification Instructions
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(seconds: 1),
                  child: CustomVerifyText(
                    title: "Please Enter The Digit Code Sent To",
                    email: email ?? "your email",
                  ),
                ),

                // OTP Text Field
                CustomOtpTextField(
                  onSubmit: (String verificationCode) => verifyCubit
                      .verifyRegister(context, verificationCode, email!),
                ),

                // Resend Code Button with Timer
                ResendCodeTimer(
                  onPressed: verifyCubit.seconds == 0
                      ? () => verifyCubit.onResend(email!, context)
                      : null,
                  child: Text(
                    verifyCubit.seconds > 0
                        ? 'Resend Code in ${verifyCubit.seconds} sec'
                        : 'Resend Verification Code',
                    style: TextStyle(
                      color: verifyCubit.seconds > 0
                          ? Colors.grey
                          : Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
