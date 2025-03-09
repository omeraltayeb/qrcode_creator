import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/auth/auth_header.dart';
import '../../widgets/custom_button.dart';
import '../../../core/function/handling_page.dart';
import '../../../cubits/forgetpassword/checkEmail/check_email_cubit.dart';
import '../../../cubits/forgetpassword/checkEmail/check_email_state.dart';
import '../../widgets/auth/icon_button.dart';
import '../../widgets/auth/check_email_form.dart';
import '../../widgets/auth/slide_transition_widget.dart';

class CheckEmail extends StatelessWidget {
  const CheckEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final checkCubit = context.read<CheckEmailCubit>();
    return Scaffold(
      body: BlocBuilder<CheckEmailCubit, CheckEmailState>(
        builder: (context, state) {
          return HandlingPage(
            isLoading: state is CheckEmailLoading,
            serverErrorMessage: checkCubit.serverErrorMessage,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: ListView(
                key: ValueKey(state),
                padding: const EdgeInsets.all(10),
                children: [
                  Hero(
                    tag: 'forget_password_animation',
                    child: AuthHeader(
                      name: 'assets/lottie/forget_password.json',
                      height: MediaQuery.of(context).size.height / 2.5,
                    ),
                  ),
                  SlideTransitionWidget(
                    child: CheckEmailForm(
                      checkKey: checkCubit.checkForm,
                      text:
                          'If your email is found, we will send you a verification code',
                      controller: checkCubit.emailController,
                    ),
                  ),
                  CustomButton(
                    text: 'Check Email',
                    onPressed: state is CheckEmailLoading
                        ? null
                        : () => checkCubit.checkEmail(context),
                  ),
                  CustomIconButton(
                    onPressed: () => checkCubit.loginNav(context),
                    text: "Back",
                    icon: const Icon(Icons.arrow_back, size: 24),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
