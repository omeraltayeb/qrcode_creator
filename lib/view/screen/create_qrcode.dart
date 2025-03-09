import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/function/handling_page.dart';
import '../../cubits/create_qrcode/create_qrcode_cubit.dart';
import '../../cubits/create_qrcode/create_qrcode_states.dart';
import '../widgets/createQrCode/create_form.dart';
import '../widgets/createQrCode/custom_color_picker.dart';
import '../widgets/createQrCode/header_widget.dart';
import '../widgets/createQrCode/select_logo.dart';
import '../widgets/custom_button.dart';
import 'package:path/path.dart';

class CreateQrCodeScreen extends StatelessWidget {
  const CreateQrCodeScreen({super.key, this.isLink = true});
  final bool isLink;
  @override
  Widget build(BuildContext context) {
    final createCubit = context.read<CreateQrCodeCubit>();

    return Scaffold(
      body: BlocBuilder<CreateQrCodeCubit, CreateQrCodeStates>(
        builder: (context, state) {
          return HandlingPage(
            isLoading: state is CreateQrCodeLoading,
            child: ListView(
              children: [
                HeaderWidget(
                  icon: Icon(
                    Icons.info,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  text:
                      "You can change the color of the QR code or use the default color and upload your logo to center it on the QR code. ",
                ),
                CreateForm(
                  formKey: createCubit.createForm,
                  linkController: createCubit.link,
                  nameController: createCubit.name,
                  hintLink: "Put your link here",
                  hintName: "Name of your QR Code",
                  linkValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a link or select a file.';
                    }
                    return null;
                  },
                  nameValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a label name.';
                    }
                    return null;
                  },
                  isLink: isLink,
                  imageName: createCubit.file != null
                      ? basename(createCubit.file!.path)
                      : "",
                  uploadFile: () => createCubit.pickFileAndGenerateQR(context),
                ),
                CustomColorPicker(
                  qrColor: createCubit.qrColor,
                  onColorChanged: (color) => createCubit.updateQrColor(color),
                ),
                SelectLogo(
                  createCubit: createCubit,
                ),
                CustomButton(
                  text: "Continue",
                  onPressed: createCubit.isDone
                      ? () => createCubit.generateQRCode(context)
                      : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
