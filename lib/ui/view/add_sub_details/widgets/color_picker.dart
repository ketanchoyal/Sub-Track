import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class ColorPickerKeyboard extends StatelessWidget
    with KeyboardCustomPanelMixin<Color?>
    implements PreferredSizeWidget {
  final ValueNotifier<Color?> notifier;
  static const double _kKeyboardHeight = 300;

  ColorPickerKeyboard({Key? key, required this.notifier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double rows = 5;
    final double screenWidth = MediaQuery.of(context).size.width;
    final int colorsCount = Colors.primaries.length + Colors.accents.length;
    final int colorsPerRow = (colorsCount / rows).ceil();
    final double itemWidth = screenWidth / colorsPerRow;
    final double itemHeight = _kKeyboardHeight / rows;

    return Container(
      height: _kKeyboardHeight,
      child: Wrap(
        children: <Widget>[
          for (final color in [...Colors.primaries, ...Colors.accents])
            GestureDetector(
              onTap: () {
                updateValue(color);
              },
              child: Container(
                color: color,
                width: itemWidth,
                height: itemHeight,
              ),
            )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_kKeyboardHeight);
}
