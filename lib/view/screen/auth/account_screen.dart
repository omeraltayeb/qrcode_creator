import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/profile/profile_cubit.dart';
import '../../../cubits/profile/profile_state.dart';
import '../../../core/constant/links.dart';
import '../../../core/function/handling_page.dart';
import '../../widgets/auth/profile_image.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        child: Center(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return HandlingPage(
                isLoading: state is ProfileLoading,
                serverErrorMessage: profileCubit.serverErrorMessage,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Row(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileImage(
                          onTap: () => profileCubit.changeProfile(context),
                          image: profileCubit.image == null
                              ? NetworkImage(
                                  "${Links.profileImage}/${profileCubit.imagePath}")
                              : FileImage(
                                  profileCubit.image!,
                                ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              profileCubit.name,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              profileCubit.email,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("data"),
                          ],
                        )
                      ],
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
