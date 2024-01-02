import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/res/theme/text_theme.dart';
import '../../../core/res/theme/theme_manager.dart';

class CustomizableTextInput extends StatefulWidget {
  const CustomizableTextInput({
    super.key,
    required this.controller,
    this.label,
    this.hintText,
    this.hintStyle,
    this.textInputAction,
    this.keyboardType,
    this.height,
    this.radius,
    this.padding,
  });
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final double? height;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  @override
  State<CustomizableTextInput> createState() => _SearchTextInputState();
}

class _SearchTextInputState extends State<CustomizableTextInput> {
  late final FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(canRequestFocus: true);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: widget.height ?? 64.w,
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius ?? 32.r),
        color: getColor().themeColorWhiteBlack,
      ),
      padding: widget.padding ??
          EdgeInsets.symmetric(
            horizontal: 14.w,
          ),
      child: TextField(
        focusNode: _focusNode,
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller,
        style: text14.copyWith(
          color: getColor().themeColor222222White,
        ),
        scrollPadding: EdgeInsets.zero,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ??
              text14.copyWith(
                color: getColor().themeColorGrey,
              ),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          filled: true,
          fillColor: getColor().themeColorWhiteBlack,
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
