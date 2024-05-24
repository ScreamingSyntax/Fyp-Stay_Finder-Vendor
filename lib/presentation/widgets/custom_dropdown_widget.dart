import 'package:flutter/cupertino.dart';
import 'package:stayfinder_vendor/logic/cubits/drop_down_value/drop_down_value_cubit.dart';

import 'widgets_exports.dart';

class CustomDropDownButton extends StatelessWidget {
  final DropDownValueState state;
  final void Function(String?)? onChanged;
  final List<DropdownMenuItem<String>>? items;
  const CustomDropDownButton({
    super.key,
    required this.state,
    this.onChanged,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      // isDense: trie,
      // alignment: Alignment.,

      dropdownColor: Color(0xffe5e5e5),
      focusColor: Color(0xffe5e5e5),
      onChanged: onChanged,
      items: items,
      value: state.value,
      style: TextStyle(
          color: Color(0xff546E7A), fontSize: 16, fontWeight: FontWeight.w600),
      // icon: Icon(CupertinoIcons.chevron_down_circle_fill),
    );
  }
}
