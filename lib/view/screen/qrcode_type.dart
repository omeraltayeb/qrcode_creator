import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode_creator/core/function/handling_page.dart';
import '../../cubits/qrCodeType/qr_code_type_cubit.dart';
import '../../cubits/qrCodeType/qr_code_type_state.dart';
import '../../data/datasource/static/qr_code_data.dart';
import '../widgets/custom_card.dart';

class QrcodeType extends StatelessWidget {
  const QrcodeType({super.key});

  @override
  Widget build(BuildContext context) {
    final typeCubit = context.read<QrCodeTypeCubit>();
    return Scaffold(
      body: BlocBuilder<QrCodeTypeCubit, QrCodeTypeState>(
        builder: (context, state) {
          return HandlingPage(
            isLoading: state is QrCodeTypeLoading,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Please Select Taype of QR Code',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: qrTypes
                        .map((qr) => CustomCard(
                              onTap: () => typeCubit.navigateToQrCreation(
                                  context,
                                  isLink: qr.isLink),
                              icon: qr.icon,
                              text: qr.text,
                            ))
                        .toList(),
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
