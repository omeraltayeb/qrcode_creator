import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/function/handling_page.dart';
import '../../../cubits/forgetpassword/verifyReset/verify_reset_cubit.dart';
import '../../../cubits/forgetpassword/verifyReset/verify_reset_state.dart';
import '../../widgets/auth/auth_header.dart';
import '../../widgets/auth/custom_otp_text.dart';
import '../../widgets/auth/custom_verify_text.dart';
import '../../widgets/auth/resend_button.dart';

class VerifyReset extends StatelessWidget {
  const VerifyReset({super.key, this.email});
  final String? email;
  @override
  Widget build(BuildContext context) {
    final verifyResetCubit = context.read<VerifyResetCubit>();

    return Scaffold(
      body: BlocBuilder<VerifyResetCubit, VerifyResetState>(
        builder: (context, state) {
          return HandlingPage(
            isLoading: state is VerifyResetLoading,
            serverErrorMessage: verifyResetCubit.serverErrorMessage,
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
                  onSubmit: (String verificationCode) => verifyResetCubit
                      .verifyReset(context, verificationCode, email!),
                ),

                // Resend Code Button with Timer
                ResendCodeTimer(
                  onPressed: verifyResetCubit.seconds == 0
                      ? () => verifyResetCubit.onResend(email!, context)
                      : null,
                  child: Text(
                    verifyResetCubit.seconds > 0
                        ? 'Resend Code in ${verifyResetCubit.seconds} sec'
                        : 'Resend Verification Code',
                    style: TextStyle(
                      color: verifyResetCubit.seconds > 0
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
