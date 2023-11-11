import 'package:flutter/material.dart';
import 'package:grocery_app/presentation/components/stars.dart';

class InteractiveStarts extends StatefulWidget {
  const InteractiveStarts(
      {super.key, this.onChanged, required this.intialValue});
  final Function(double)? onChanged;
  final double intialValue;
  @override
  State<InteractiveStarts> createState() => _InteractiveStartsState();
}

class _InteractiveStartsState extends State<InteractiveStarts> {
  late double count;
  late List<Widget> starsList;

  void fillStartsList() {
    starsList = List.generate(5, (index) {
      if (index + 1 <= count) {
        return starIcon(type: StarType.filled, index: index);
      } else {
        return starIcon(type: StarType.empty, index: index);
      }
    });

    if (count > count.floor()) {
      starsList[count.floor()] =
          starIcon(type: StarType.half, index: count.floor());
    }
  }

  @override
  void initState() {
    count = widget.intialValue;
    fillStartsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: starsList,
    );
  }

  Widget starIcon({required StarType type, required int index}) {
    IconData icon;
    if (type == StarType.filled) {
      icon = Icons.star;
    } else if (type == StarType.empty) {
      icon = Icons.star_border;
    } else if (type == StarType.half) {
      icon = Icons.star_half;
    } else {
      throw Exception("Stars Exception Invalid Type");
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(99999),
      child: Material(
        type: MaterialType.circle,
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (type == StarType.empty) {
              count = index == 0 ? 1 : index + 0.5;
            } else if (type == StarType.half) {
              count = index + 1;
            } else if (type == StarType.filled) {
              if (index + 1 == count) {
                count = index == 0 ? 1 : index.toDouble();
              } else {
                count = index + 1;
              }
            }
            starsList.clear();
            fillStartsList();
            if (widget.onChanged != null) {
              widget.onChanged!(count);
            }
            setState(() {});
          },
          child: Icon(
            icon,
            size: 50,
            color: const Color(0xffFFC107),
          ),
        ),
      ),
    );
  }
}
