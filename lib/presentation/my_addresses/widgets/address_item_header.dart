import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/address_model.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/helper/functions.dart';

class AddressItemHeader extends StatelessWidget {
  const AddressItemHeader(
      {super.key, required this.address, required this.isDefault});
  final AddressModel address;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListTile(
          tileColor: MyColors.backgroundPrimary,
          contentPadding:
              const EdgeInsets.only(left: 12, right: 12, top: 18, bottom: 8),
          horizontalTitleGap: 12,
          isThreeLine: true,
          title: Text(
            address.name,
            style: TextStyle(
                fontWeight: MyFontWeights.semiBold,
                fontSize: 15,
                color: MyColors.text),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${address.street}, ${address.city}, ${address.country(context)}",
                style: TextStyle(
                    fontWeight: MyFontWeights.medium,
                    fontSize: 12,
                    color: MyColors.textSecondry),
              ),
              Text(
                address.zip,
                style: TextStyle(
                    fontWeight: MyFontWeights.medium,
                    fontSize: 12,
                    color: MyColors.textSecondry),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                address.phone.getPhoneText(context: context),
                style: TextStyle(
                    fontSize: 10,
                    color: MyColors.text,
                    fontWeight: MyFontWeights.semiBold),
              )
            ],
          ),
          leading: SvgPicture.asset("assets/images/address/address.svg"),
        ),
        if (isDefault) defaultBadge(context)
      ],
    );
  }

  Positioned defaultBadge(BuildContext context) {
    return Positioned(
      left: isArabic() ? null : 0,
      right: isArabic() ? 0 : null,
      top: 0,
      child: Container(
        color: MyColors.primaryLight,
        padding: const EdgeInsets.all(4),
        child: Text(
          S.of(context).defaultt,
          style: TextStyle(
            fontWeight: MyFontWeights.medium,
            fontSize: 10,
            color: MyColors.primaryDark,
          ),
        ),
      ),
    );
  }
}
