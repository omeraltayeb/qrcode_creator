import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:qrcode_creator/core/function/handling_page.dart';
import 'package:qrcode_creator/cubits/myQr/my_qr_cubit.dart';
import 'package:qrcode_creator/cubits/myQr/my_qr_states.dart';
import 'package:qrcode_creator/core/constant/links.dart';
import 'package:qrcode_creator/view/screen/main_screen.dart';

class MyQrcode extends StatelessWidget {
  const MyQrcode({super.key, this.qrColor});
  final Color? qrColor;
  @override
  Widget build(BuildContext context) {
    final myQrCubit = context.read<MyQrCubit>();
    return Scaffold(
      body: BlocBuilder<MyQrCubit, MyQrStates>(builder: (context, state) {
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.primary),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MainScreen()));
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                ),
                label: Text(
                  "Create new QR Code",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search QR Code",
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
            ),
            HandlingPage(
              isLoading: state is MyQrLoading,
              data: myQrCubit.data,
              child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: myQrCubit.data.length,
                  itemBuilder: (context, index) {
                    final formattedDate = DateFormat('MMM dd, yyyy hh:mm a')
                        .format(DateTime.parse(
                            myQrCubit.data[index].myQrCodesCreatedAt));
                    return Container(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 20,
                              children: [
                                Expanded(
                                  child: Text(
                                    myQrCubit.data[index].myQrCodesLabelName,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(formattedDate),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      '${Links.qrcodeImage}/${myQrCubit.data[index].myQrCodesImagePath}',
                                ),
                                Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          final qrData = myQrCubit
                                              .data[index].myQrCodesImagePath;
                                          myQrCubit.downloadQRCode(
                                              context, qrData);
                                        },
                                        icon: SvgPicture.asset(
                                          'assets/icons/download-solid.svg',
                                          height: 30,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.favorite_border,
                                          size: 30,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          final id = myQrCubit
                                              .data[index].myQrCodesId
                                              .toString();
                                          myQrCubit.deleteQrCode(id, context);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ));
                  }),
            )
          ],
        );
      }),
    );
  }
}
