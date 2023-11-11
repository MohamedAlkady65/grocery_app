import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImageAlertDialog extends StatelessWidget {
  const ChooseImageAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AlertDialog(
        backgroundColor: MyColors.backgroundPrimary,
        insetPadding: const EdgeInsets.all(0),
        contentPadding:  EdgeInsets.zero,
        content: Material(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: MyColors.backgroundPrimary,
            width: width - 30 * 2,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Text(
                      S.of(context).pleaseChooseImage,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: MyFontWeights.semiBold,
                          color: MyColors.text),
                    ),
                  ),
                  OptionChooseImageBottomSheet(
                    text: S.of(context).fromGallery,
                    icon: Icons.image_outlined,
                    onTap: () {
                      Navigator.pop(context, ImageSource.gallery);
                    },
                  ),
                  OptionChooseImageBottomSheet(
                    text: S.of(context).fromCamera,
                    icon: Icons.photo_camera_outlined,
                    onTap: () {
                      Navigator.pop(context, ImageSource.camera);
                    },
                  ),
                ]),
          ),
        ));
  }
}

class OptionChooseImageBottomSheet extends StatelessWidget {
  const OptionChooseImageBottomSheet({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });
  final String text;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      minLeadingWidth: 20,
      title: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: MyFontWeights.medium,
          color: MyColors.text,
        ),
      ),
      leading: Icon(
        icon,
        size: 30,
        color: MyColors.primaryDark,
      ),
    );
  }
}
