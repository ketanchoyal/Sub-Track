import 'package:flutter/cupertino.dart';

class STCupertinoNavigationBar extends StatefulWidget
    implements ObstructingPreferredSizeWidget {
  STCupertinoNavigationBar(
      {Key? key, required this.navigationBar, this.height = 54})
      : super(key: key);

  final CupertinoNavigationBar navigationBar;
  final double height;

  @override
  _STCupertinoNavigationBarState createState() =>
      _STCupertinoNavigationBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    final Color backgroundColor = CupertinoDynamicColor.maybeResolve(
            navigationBar.backgroundColor, context) ??
        CupertinoTheme.of(context).barBackgroundColor;
    return backgroundColor.alpha == 0xFF;
  }
}

class _STCupertinoNavigationBarState extends State<STCupertinoNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Column(
        children: [
          widget.navigationBar,
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            // This color is as per the native iOS
            // NOTE DO NOT CHANGE
            color: Color(0x4D000000),
            width: 0.0, // One physical pixel.
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
