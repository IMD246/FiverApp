import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/res/colors.dart';
import '../../../core/res/theme/text_theme.dart';
import '../../../core/res/theme/theme_manager.dart';

class SearchTextInput extends StatefulWidget {
  const SearchTextInput({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.hintStyle,
    this.textInputAction,
    this.keyboardType,
  });
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  @override
  State<SearchTextInput> createState() => _SearchTextInputState();
}

class _SearchTextInputState extends State<SearchTextInput> {
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
      alignment: Alignment.center,
      height: 64.w,
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        color: getColor().themeColorWhiteBlack,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 14.w,
      ),
      child: TextField(
        focusNode: _focusNode,
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller,
        style: text16.medium.copyWith(
          color: getColor().textColorBlackWhiteInput,
        ),
        scrollPadding: EdgeInsets.zero,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ??
              text16.copyWith(
                color: getColor().textColorGray,
              ),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          filled: true,
          fillColor: getColor().themeColorWhiteBlack,
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
            bottom: 4.w,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: getColor().themeColorBlackWhite,
            size: 24.w,
          ),
          suffixIcon: InkWell(
            onTap: () {
              if (widget.controller.text.isNotEmpty) {
                widget.controller.clear();
              }
            },
            child: Icon(
              Icons.close,
              size: 24.w,
              color: widget.controller.text.isNotEmpty
                  ? colorEF3651
                  : getColor().themeColorWhiteBlack,
            ),
          ),
        ),
      ),
    );
  }
}
