import 'package:flutter/cupertino.dart';
import 'package:grocery_app/constants/style.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({
    super.key,
    this.onChanged,
    this.scale = 1,
    this.initialValue = false,
  });
  final void Function(bool)? onChanged;
  final double scale;
  final bool initialValue;
  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  late bool currentValue;
  @override
  void initState() {
    currentValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      transformHitTests: false,
      scale: widget.scale,
      child: CupertinoSwitch(
          activeColor: MyColors.primaryDark,
          value: currentValue,
          onChanged: (value) {
            setState(() {
              currentValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          }),
    );
  }
}
