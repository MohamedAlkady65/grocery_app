import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:grocery_app/logic/profile_cubit/profile_cubit.dart';
import 'package:grocery_app/presentation/account/widgets/choose_image_alert_dialog.dart';
import 'package:grocery_app/presentation/components/custom_shimmer.dart';
import 'package:grocery_app/presentation/components/shimmer_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            InkWell(
              onTap: () async {
                final choice = await showDialog<ImageSource>(
                  context: context,
                  builder: (context) => const ChooseImageAlertDialog(),
                );
                if (choice != null) {
                  if (context.mounted) {
                    BlocProvider.of<ProfileCubit>(context).uploadUserImage(
                      source: choice,
                    );
                  }
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9999999),
                child: Container(
                    color: MyColors.backgroundSecondry,
                    width: 110,
                    height: 110,
                    child: BlocConsumer<ProfileCubit, ProfileState>(
                      listenWhen: (previous, current) =>
                          current is UploadUserImage,
                      listener: (context, state) {
                        if (state is UploadUserImageFailure) {
                          showErrorSnackBar(context);
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is UploadUserImage,
                      builder: (context, state) {
                        if (state is UploadUserImageLoading) {
                          return const CustomShimmer(
                              period: Duration(milliseconds: 700),
                              child: ShimmerItem());
                        } else {
                          return getUserImage(context);
                        }
                      },
                    )),
              ),
            ),
            Positioned(
                bottom: -5,
                right: Intl.getCurrentLocale() == "ar" ? null : -5,
                left: Intl.getCurrentLocale() == "ar" ? -5 : null ,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(9999999),
                    child: Container(
                        color: MyColors.green,
                        width: 38,
                        height: 38,
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: MyColors.backgroundPrimary,
                        ))))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<InfoCubit, InfoState>(
          builder: (context, state) {
            return BlocBuilder<ProfileCubit, ProfileState>(
              buildWhen: (previous, current) =>
                  current is ProfileUpdateInfoSuccess,
              builder: (context, state) {
                return Column(
                  children: [
                    Text(
                        BlocProvider.of<InfoCubit>(context)
                                .currentUser
                                ?.username ??
                            "",
                        style: TextStyle(
                            fontWeight: MyFontWeights.semiBold,
                            fontSize: 15,
                            color: MyColors.text)),
                    Text(
                        BlocProvider.of<InfoCubit>(context)
                                .currentUser
                                ?.email ??
                            "",
                        style:  TextStyle(
                            fontWeight: MyFontWeights.regular,
                            fontSize: 12,
                            color: MyColors.textSecondry))
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget getUserImage(BuildContext context) {
    if (BlocProvider.of<InfoCubit>(context).currentUser == null ||
        BlocProvider.of<InfoCubit>(context).currentUser!.imgUrl == null) {
      return SvgPicture.asset(
        "assets/images/default_user_image.svg",
        width: 100,
        fit: BoxFit.fill,
      );
    } else {
      return Image.network(
        BlocProvider.of<InfoCubit>(context).currentUser!.imgUrl!,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return const CustomShimmer(
                period: Duration(milliseconds: 700), child: ShimmerItem());
          }
        },
        width: 100,
        fit: BoxFit.fill,
      );
    }
  }
}
