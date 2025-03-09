import 'package:flutter/material.dart';

import '../../../cubits/create_qrcode/create_qrcode_cubit.dart';
import '../../../data/datasource/static/logo_data.dart';

class SelectLogo extends StatelessWidget {
  const SelectLogo({super.key, required this.createCubit});

  final CreateQrCodeCubit createCubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Row(
        children: [
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: logo.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return InkWell(
                    onTap: () => createCubit.pickLogo(),
                    child: createCubit.logoFile != null
                        ? Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.primary),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: FileImage(createCubit.logoFile!)),
                            ),
                          )
                        : Container(
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
                return InkWell(
                  onTap: () {
                    final imageProvider = AssetImage(logo[index - 1]['image']);
                    createCubit.setLogo(
                        imageProvider, logo[index - 1]['image'], index - 1);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: createCubit.selectedLogos[index - 1]
                          ? Theme.of(context).colorScheme.primary
                          : Colors
                              .transparent, // الخلفية تتغير فقط للشعار المختار
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
    );
  }
}
