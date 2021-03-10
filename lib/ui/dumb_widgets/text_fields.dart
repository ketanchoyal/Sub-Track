import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sub_track/ui/shared/shared.dart';
import 'package:sub_track/ui/theme/app_colors.dart';

enum TextFieldType {
  DEFAULT,
  ACTIVE,
  VALID,
  ERROR,
  DISABLED,
}

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
  }) : super(key: key);

  final TextFieldType type;
  final String? placeholder;
  final TextEditingController? controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final IconData? suffixIcon;

  @override
  _STTextFieldState createState() => _STTextFieldState();
}

class _STTextFieldState extends State<STTextField> {
  @override
  Widget build(BuildContext context) {
    bool _hasFocus = widget.focusNode.hasFocus;

    TextFieldType _textFieldType =
        _hasFocus ? TextFieldType.ACTIVE : widget.type;

    Color _color = _textFieldType == TextFieldType.DEFAULT ||
            _textFieldType == TextFieldType.DISABLED
        ? Colors.transparent
        : _textFieldType == TextFieldType.ACTIVE
            ? AppColor.STAccent
            : _textFieldType == TextFieldType.VALID
                ? AppColor.STSuccess
                : AppColor.STFailure;

    IconData? _icon = _textFieldType == TextFieldType.DEFAULT
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
    return Container(
      margin: EdgeInsets.all(12),
      child: CupertinoTextField(
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
        padding: EdgeInsets.all(18),
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
        onSubmitted: (_) {
          widget.focusNode.unfocus();
          _textFieldType = widget.type;
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
          setState(() {});
        },
        onChanged: (_) {
          _textFieldType = TextFieldType.ACTIVE;
          setState(() {});
        },
        clearButtonMode: OverlayVisibilityMode.editing,
        obscureText: widget.obscureText,
        suffixMode: _textFieldType == TextFieldType.DEFAULT ||
                _textFieldType == TextFieldType.ACTIVE
            ? OverlayVisibilityMode.never
            : OverlayVisibilityMode.always,
        suffix: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            _icon,
            color: _textFieldType == TextFieldType.DISABLED
                ? AppColor.STDarkLight
                : _color,
          ),
        ),
      ),
    );
  }
}
