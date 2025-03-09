import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/profile/profile_state.dart';
import '../../core/function/handling_page.dart';
import '../../cubits/profile/profile_cubit.dart';
import '../../data/datasource/static/settings_data.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();

    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return HandlingPage(
            isLoading: state is ProfileLoading,
            child: profileCubit.isLoggedIn == "true"
                ? ListView(
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          const Text(
                            "Welcome Back,",
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            profileCubit.name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Here you can customize your account and settings",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Card(
                        child: Column(
                          children: [
                            Column(
                              children: settingsData(context)
                                  .map(
                                    (e) => Column(
                                      children: [
                                        ListTile(
                                          onTap: e.onTap,
                                          leading: Icon(
                                            e.leading,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          title: Text(e.title),
                                          trailing: e.trailing,
                                        ),
                                        const Divider(),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                            ListTile(
                              onTap: () {},
                              leading:
                                  Icon(Icons.delete_sweep, color: Colors.red),
                              title: Text(
                                "Delete account",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Divider(),
                            ListTile(
                              onTap: () => profileCubit.logOut(context),
                              leading: Icon(Icons.logout,
                                  color: Theme.of(context).colorScheme.primary),
                              title: Text(
                                "Logout",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: Text("You must log in to view this page"),
                  ),
          );
        },
      ),
    );
  }
}
