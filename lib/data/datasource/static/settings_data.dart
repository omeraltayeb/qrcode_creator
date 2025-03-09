import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/Theme/theme_cubit.dart';
import '../../../cubits/Theme/theme_state.dart';
import '../../../view/screen/auth/account_screen.dart';
import '../../model/settings_model.dart';

List<SettingsModel> settingsData(BuildContext context) {
  return [
    SettingsModel(
      leading: Icons.person,
      title: "Account",
      trailing: const SizedBox(),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountScreen()),
        );
      },
    ),
    SettingsModel(
      leading: Icons.help,
      title: "Help",
      trailing: const SizedBox(),
      onTap: () {
        // تنفيذ الوظيفة عند النقر على "Help"
        print("Help tapped");
      },
    ),
    SettingsModel(
      leading: Icons.feedback,
      title: "Write us a feedback",
      trailing: const SizedBox(),
      onTap: () {
        // تنفيذ الوظيفة عند النقر على "Write us a feedback"
        print("Feedback tapped");
      },
    ),
    SettingsModel(
      leading: Icons.language,
      title: "Language",
      trailing: TextButton(
        onPressed: () {},
        child: const Text("English"),
      ),
      onTap: () {
        // تنفيذ الوظيفة عند النقر على "Language"
        print("Language tapped");
      },
    ),
    SettingsModel(
      leading: context.read<ThemeCubit>().state.themeMode == ThemeMode.dark
          ? Icons.dark_mode
          : Icons.light_mode,
      title: context.read<ThemeCubit>().state.themeMode == ThemeMode.dark
          ? "Dark Mode"
          : "Light Mode",
      trailing: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return Switch(
            value: state.themeMode == ThemeMode.dark,
            onChanged: (val) {
              context.read<ThemeCubit>().toggleTheme();
            },
          );
        },
      ),
      onTap: () {
        // تنفيذ الوظيفة عند النقر على "Dark Mode" أو "Light Mode"
        print("Theme tapped");
      },
    ),
  ];
}
