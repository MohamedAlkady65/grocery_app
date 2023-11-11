import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:jiffy/jiffy.dart';

class DateHelper {
 static String getDate({required BuildContext context, required DateTime date}) {
    date = date.add(
        BlocProvider.of<InfoCubit>(context).ipInfo?.offset ?? Duration.zero);

    return Jiffy.parseFromDateTime(date).yMMMMdjm;
  }

 static String getFromDate({required BuildContext context, required DateTime date}) {
    final seconds = getDifferenceInSecond(context: context, date: date);

    if (seconds < 60) {
      final value = seconds;
      return "$value second${value > 1 ? "s" : ""} ago";
    } else if (seconds < 60 * 60) {
      final value = (seconds / 60).ceil();
      return "$value minute${value > 1 ? "s" : ""}  ago";
    } else if (seconds < 60 * 60 * 24) {
      final value = (seconds / (60 * 60)).ceil();
      return "$value hour${value > 1 ? "s" : ""}  ago";
    } else {
      return getDate(context: context, date: date);
    }
  }

 static int getDifferenceInSecond(
      {required BuildContext context, required DateTime date}) {
    date = date.add(
        BlocProvider.of<InfoCubit>(context).ipInfo?.offset ?? Duration.zero);

    var now = DateTime.now();
    now = DateTime.utc(
        now.year, now.month, now.day, now.hour, now.minute, now.second);
    return ((now.millisecondsSinceEpoch - date.millisecondsSinceEpoch) / 1000)
        .ceil();
  }
}
