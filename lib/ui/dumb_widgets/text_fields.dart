import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';

class STTextField extends StatefulWidget {
  const STTextField({
    Key? key,
    required this.type,
    this.placeholder,
    this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.textInputAction,
    this.obscureText = false,
    this.suffixIcon,
    this.onSubmitted,
    this.padding,
    this.prefix,
    this.onChanged,
  }) : super(key: key);

  final TextFieldType type;
  final String? placeholder;
  final TextEditingController? controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final IconData? suffixIcon;
  final Function(String)? onSubmitted;
  final EdgeInsetsGeometry? padding;
  final Widget? prefix;
  final Function(String)? onChanged;

  @override
  _STTextFieldState createState() => _STTextFieldState();
}

class _STTextFieldState extends State<STTextField> {
  late TextFieldType _textFieldType;
  late Color _color;
  IconData? _icon;
  @override
  void initState() {
    super.initState();
    // _textFieldType = widget.type;
    setUp();
    widget.focusNode.addListener(() {
      setUp();
    });
  }

  setUp() {
    // FocusScopeNode currentFocus = FocusScope.of(context);
    // if (!currentFocus.hasPrimaryFocus) {
    //   currentFocus.focusedChild?.unfocus();
    // }
    bool _hasFocus = widget.focusNode.hasPrimaryFocus;

    _textFieldType = _hasFocus ? TextFieldType.ACTIVE : widget.type;

    _color = _textFieldType == TextFieldType.DEFAULT ||
            _textFieldType == TextFieldType.DISABLED
        ? Colors.transparent
        : _textFieldType == TextFieldType.ACTIVE
            ? AppColor.STAccent
            : _textFieldType == TextFieldType.VALID
                ? AppColor.STSuccess
                : AppColor.STFailure;

    _icon = _textFieldType == TextFieldType.DEFAULT
        ? widget.suffixIcon
        : _textFieldType == TextFieldType.ACTIVE
            ? null
            : _textFieldType == TextFieldType.VALID
                ? Icons.check
                : _textFieldType == TextFieldType.DISABLED
                    ? Icons.block_flipped
                    : _textFieldType == TextFieldType.ERROR
                        ? Icons.error_outline
                        : null;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: TextInputType.text,
      placeholder: widget.placeholder,
      enabled: _textFieldType == TextFieldType.DISABLED ? false : true,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _textFieldType == TextFieldType.DEFAULT ||
                _textFieldType == TextFieldType.DISABLED
            ? AppColor.STLight
            : AppColor.STPureWhite,
        boxShadow: [
          BoxShadow(
            color: _color,
            blurRadius: 4.5,
          ),
        ],
      ),
      padding: widget.padding ?? EdgeInsets.all(15),
      placeholderStyle: kBodyBoldStyle.copyWith(
        color: AppColor.STDarkLight,
      ),
      style: kBodyBoldStyle.copyWith(
        color: AppColor.STDark,
      ),
      autofocus: false,
      textInputAction: widget.textInputAction != null
          ? widget.textInputAction
          : widget.nextFocusNode != null
              ? TextInputAction.next
              : TextInputAction.done,
      onSubmitted: (value) {
        if (widget.onSubmitted != null) widget.onSubmitted!(value);
        widget.focusNode.unfocus();
        _textFieldType = widget.type;
        FocusScope.of(context).requestFocus(widget.nextFocusNode);
        setState(() {});
      },
      onTap: () {
        _textFieldType = TextFieldType.ACTIVE;
        setState(() {});
      },
      onEditingComplete: () {
        widget.focusNode.unfocus();
        _textFieldType = widget.type;
        FocusScope.of(context).requestFocus(widget.nextFocusNode);
        setState(() {});
      },
      onChanged: (value) {
        if (widget.onChanged != null) widget.onChanged!(value);
        _textFieldType = TextFieldType.ACTIVE;
        setState(() {});
      },
      clearButtonMode: OverlayVisibilityMode.editing,
      obscureText: widget.obscureText,
      suffixMode: _textFieldType == TextFieldType.DEFAULT ||
              _textFieldType == TextFieldType.ACTIVE
          ? OverlayVisibilityMode.never
          : OverlayVisibilityMode.always,
      prefix: widget.prefix,
      suffix: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          _icon,
          color: _textFieldType == TextFieldType.DISABLED
              ? AppColor.STDarkLight
              : _color,
        ),
      ),
    );
  }
}
