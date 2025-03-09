import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode_creator/cubits/google_ads/google_ads_cubit.dart';
import '../../cubits/home/home_cubit.dart';
import '../../cubits/home/home_state.dart';
import '../../core/function/handling_page.dart';
import '../../data/datasource/static/home_section.dart';
import '../widgets/home/section_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    final adCubit = context.read<GoogleAdsCubit>();

    return Scaffold(
      /*  bottomNavigationBar: BlocBuilder<GoogleAdsCubit, GoogleAdsStates>(
        builder: (context, state) {
          if (adCubit.bannerAd == null) return const SizedBox.shrink();
          return Container(
            alignment: Alignment.center,
            width: adCubit.bannerAd!.size.width.toDouble(),
            height: adCubit.bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: adCubit.bannerAd!),
          );
        },
      ),*/
      body: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          return HandlingPage(
            isLoading: state is HomeLoading,
            child: ListView(
              children: [
                Text(
                  'Welcome, You can generate free QR Code and no limit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    final section = sections[index];
                    return SectionTile(
                      onTap: () {
                        homeCubit.onTapSection(
                          section.title,
                          section.initialIndex,
                          context,
                        );
                        adCubit.showRewardedAd();
                      },
                      text: section.title,
                      icon: section.icon,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
