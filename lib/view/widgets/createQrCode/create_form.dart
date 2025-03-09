import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CreateForm extends StatelessWidget {
  const CreateForm({
    super.key,
    required this.formKey,
    required this.linkController,
    required this.nameController,
    required this.hintLink,
    required this.hintName,
    required this.linkValidator,
    required this.nameValidator,
    required this.isLink,
    required this.uploadFile,
    required this.imageName,
  });
  final Key formKey;
  final TextEditingController linkController;
  final TextEditingController nameController;
  final String hintLink;
  final String hintName;
  final String? Function(String?)? linkValidator;
  final String? Function(String?)? nameValidator;
  final bool isLink;
  final void Function()? uploadFile;
  final String imageName;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: 10,
        children: [
          isLink
              ? TextFormField(
                  controller: linkController,
                  decoration: InputDecoration(
                    hintText: hintLink,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: linkValidator,
                )
              : Row(
                  spacing: 20,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 14),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: InkWell(
                        onTap: uploadFile,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 20,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/upload-solid.svg',
                              height: 30,
                              color: Colors.white,
                            ),
                            Text(
                              'Upload File',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(imageName),
                  ],
                ),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: hintName,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: nameValidator,
          ),
        ],
      ),
    );
  }
}

/* @override
  Widget build(BuildContext context) {
    return Form(
      key: createCubit.createForm,
      child: Column(
        children: [
          TextFormField(
            controller: createCubit.link,
            decoration: InputDecoration(
              hintText: 'Put your link here',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a link or select a file.';
              }
              return null;
            },
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 14),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(7),
            ),
            child: GestureDetector(
              onTap: () => createCubit.pickFileAndGenerateQR(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  SvgPicture.asset(
                    'assets/icons/upload-solid.svg',
                    height: 30,
                    color: Colors.white,
                  ),
                  Text(
                    'Upload File',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: createCubit.name,
            decoration: InputDecoration(
              hintText: 'Name of your QR Code',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a label name.';
              }
              return null;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: MaterialButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  color: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Pick a color'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: createCubit.qrColor,
                              onColorChanged: (color) {
                                createCubit.updateQrColor(color);
                              },
                              showLabel: true,
                              pickerAreaHeightPercent: 0.8,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.color_lens, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Select QR Code Color',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  spacing: 10,
                  children: [
                    Text(
                      'Selected Color',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: createCubit.qrColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              spacing: 10,
              children: [
                SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemCount: logo.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return GestureDetector(
                          onTap: () => createCubit.pickLogo(),
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          final imageProvider =
                              AssetImage(logo[index - 1]['image']);
                          createCubit.setLogo(
                              imageProvider, logo[index - 1]['image']);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: logo[index - 1]['icon'],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          CustomButton(
            text: "Continue",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ResultCreateQrCodeScreen()));
            },
          ),
        ],
      ),
    );
  }
} */
