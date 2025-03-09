import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:qrcode_creator/core/function/handling_page.dart';
import 'package:qrcode_creator/cubits/scan_history/scan_history_cubit.dart';
import 'package:qrcode_creator/cubits/scan_history/scan_history_states.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanHistory extends StatelessWidget {
  const ScanHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final scanHistoryCubit = context.read<ScanHistoryCubit>();
    return Scaffold(
      body: BlocBuilder<ScanHistoryCubit, ScanHistoryStates>(
        builder: (context, state) {
          if (state is ScanHistoryLoaded) {
            scanHistoryCubit.selectedIndex = state.selectedIndex;
          }
          return SafeArea(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      MaterialButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 26),
                        color: scanHistoryCubit.selectedIndex == 0
                            ? Theme.of(context).colorScheme.primary
                            : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          scanHistoryCubit.updateSelectedIndex(0);
                          scanHistoryCubit.pageController.jumpToPage(0);
                        },
                        child: Text(
                          'Scan History',
                          style: TextStyle(
                            color: scanHistoryCubit.selectedIndex == 0
                                ? Colors.white
                                : Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 43),
                        color: scanHistoryCubit.selectedIndex == 1
                            ? Theme.of(context).colorScheme.primary
                            : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          scanHistoryCubit.updateSelectedIndex(1);
                          scanHistoryCubit.pageController.jumpToPage(1);
                        },
                        child: Text(
                          'Favorites',
                          style: TextStyle(
                            color: scanHistoryCubit.selectedIndex == 1
                                ? Colors.white
                                : Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: PageView(
                    controller: scanHistoryCubit.pageController,
                    onPageChanged: (value) {},
                    children: [
                      // history
                      state is ScanHistoryLoading
                          ? Center(child: CircularProgressIndicator())
                          : scanHistoryCubit.scanData.isEmpty
                              ? Container(
                                  margin: const EdgeInsets.only(bottom: 230),
                                  child:
                                      Lottie.asset('assets/lottie/nodata.json'))
                              : SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView.builder(
                                      padding: const EdgeInsets.all(10),
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          scanHistoryCubit.scanData.length,
                                      itemBuilder: (context, index) {
                                        final item =
                                            scanHistoryCubit.scanData[index];
                                        String result =
                                            item['scannedData_value'];
                                        final formattedDate =
                                            DateFormat('MMM dd, yyyy hh:mm a')
                                                .format(DateTime.parse(
                                                    item['created_at']));
                                        return Container(
                                          padding: const EdgeInsets.all(10),
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            spacing: 10,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(formattedDate),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          if (result
                                                              .isNotEmpty) {
                                                            FlutterClipboard
                                                                .copy(result);
                                                          }
                                                        },
                                                        icon: Icon(Icons.copy),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          scanHistoryCubit
                                                              .deleteHistory(
                                                                  item["scannedData_id"]
                                                                      .toString(),
                                                                  context);
                                                        },
                                                        icon:
                                                            Icon(Icons.delete),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  if (result.startsWith(
                                                          'http://') ||
                                                      result.startsWith(
                                                          'https://')) {
                                                    final Uri url = Uri.parse(
                                                        Uri.encodeFull(result));
                                                    if (await canLaunchUrl(
                                                        url)) {
                                                      await launchUrl(url,
                                                          mode: LaunchMode
                                                              .externalApplication);
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                            content: Text(
                                                                'Could not launch $result')),
                                                      );
                                                    }
                                                  }
                                                },
                                                child: Text(
                                                  item['scannedData_value'],
                                                  style: TextStyle(
                                                    color: result.startsWith(
                                                                'http://') ||
                                                            result.startsWith(
                                                                'https://')
                                                        ? Colors.blue
                                                        : Colors.black,
                                                    decoration: result
                                                                .startsWith(
                                                                    'http://') ||
                                                            result.startsWith(
                                                                'https://')
                                                        ? TextDecoration
                                                            .underline
                                                        : TextDecoration.none,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                      // favorite

                      HandlingPage(
                        isLoading: state is ScanHistoryLoading,
                        child: ListView(
                          children: [],
                        ),
                      ),
                    ],
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
