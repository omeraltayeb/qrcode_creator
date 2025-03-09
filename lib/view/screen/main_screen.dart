import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:qrcode_creator/core/services/services.dart';
import 'package:qrcode_creator/cubits/main/main_screen_cubit.dart';
import 'package:qrcode_creator/cubits/main/main_states.dart';
import 'package:qrcode_creator/view/screen/auth/login_screen.dart';

class MainScreen extends StatelessWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainScreenCubit(initialIndex: initialIndex),
      child: Scaffold(
        body: BlocBuilder<MainScreenCubit, MainStates>(
          builder: (context, state) {
            if (state is MainInitial) {
              return context.read<MainScreenCubit>().buildPage(state.index);
            }
            return Container();
          },
        ),
        bottomNavigationBar: BlocBuilder<MainScreenCubit, MainStates>(
          builder: (context, state) {
            if (state is MainInitial) {
              return Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: GNav(
                    gap: 8,
                    activeColor: Colors.white,
                    color: Colors.grey[800],
                    tabBackgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.all(12),
                    tabs: const [
                      GButton(
                        icon: Icons.add,
                        text: 'Create QR',
                      ),
                      GButton(
                        icon: Icons.history,
                        text: 'History',
                      ),
                      GButton(
                        icon: Icons.qr_code_scanner,
                        text: 'Scan',
                      ),
                      GButton(
                        icon: Icons.qr_code_2,
                        text: 'My QR',
                      ),
                      GButton(
                        icon: Icons.settings,
                        text: 'Settings',
                      ),
                    ],
                    selectedIndex: state.index,
                    onTabChange: (index) async {
                      final isLoggedIn =
                          await MyServices().getValue("isLogin") == "true";

                      if (index == 0 || index == 3) {
                        if (!isLoggedIn) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        } else {
                          context.read<MainScreenCubit>().updateIndex(index);
                        }
                      } else {
                        context.read<MainScreenCubit>().updateIndex(index);
                      }
                    },
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
