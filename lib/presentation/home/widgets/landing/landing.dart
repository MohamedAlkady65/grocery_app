import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/data/models/landing_item_model.dart';
import 'package:grocery_app/helper/functions.dart';
import 'package:grocery_app/logic/landing_cubit/landing_cubit.dart';
import 'package:grocery_app/presentation/components/custom_shimmer.dart';
import 'package:grocery_app/presentation/components/shimmer_item.dart';
import 'package:grocery_app/presentation/home/widgets/landing/landing_indicator.dart';
import 'package:grocery_app/presentation/home/widgets/landing/landing_item.dart';
import 'package:grocery_app/constants/style.dart';

class Landing extends StatelessWidget {
  const Landing({
    super.key,
    required this.controller,
  });
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LandingCubit>(context).getLanding();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            MyColors.backgroundPrimary,
            MyColors.backgroundSecondry,
          ])),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: MyColors.backgroundThird,
          width: double.infinity,
          height: 270,
          child: BlocConsumer<LandingCubit, LandingState>(
            listener: (context, state) {
              if (state is LandingFailure) {
                showErrorSnackBar(context);
              }
            },
            builder: (context, state) {
              if (state is LandingLoading) {
                return loading();
              } else if (state is LandingSuccess) {
                List<LandingItemModel> landingList =
                    BlocProvider.of<LandingCubit>(context).landingList;
                return body(landingList);
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Stack body(List<LandingItemModel> landingList) {
    return Stack(
      children: [
        PageView.builder(
          controller: controller,
          itemCount: landingList.length,
          itemBuilder: (context, index) => Landingitem(
            landingItem: landingList[index],
          ),
        ),
        LandingIndicator(
          controller: controller,
        ),
      ],
    );
  }

  CustomShimmer loading() => const CustomShimmer(child: ShimmerItem());
}
