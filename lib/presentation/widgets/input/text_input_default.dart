import 'package:fiver/core/res/theme/text_theme.dart';
import 'package:fiver/core/res/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextInputDefault extends StatefulWidget {
  const TextInputDefault({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.hintStyle,
    this.inputFormatters,
    this.validator,
    this.textInputAction,
    this.keyboardType,
  });
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final TextStyle? hintStyle;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final ValueNotifier<String>? validator;
  @override
  State<TextInputDefault> createState() => _TextInputDefaultState();
}

class _TextInputDefaultState extends State<TextInputDefault> {
  String _errorText = "";
  bool firstInit = false;
  final FocusNode _focusNode = FocusNode();
  bool focused = false;
  void _onChanged(String value) {
    if (!firstInit) {
      firstInit = true;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.validator != null) {
      widget.validator!.addListener(() {
        setState(() {
          _errorText = widget.validator!.value;
        });
      });
    }
    _focusNode.addListener(() {
      setState(() {
        focused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 64.w,
          width: 1.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: getColor().themeColorWhiteBlack,
            border: Border.all(
              width: 1,
              color: _errorText.isEmpty || !firstInit
                  ? Colors.transparent
                  : getColor().themeColorRed,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 14.w,
          ),
          child: TextField(
            focusNode: _focusNode,
            textAlignVertical: TextAlignVertical.center,
            controller: widget.controller,
            inputFormatters: widget.inputFormatters,
            onChanged: _onChanged,
            style: text14.medium.copyWith(
              color: getColor().textColorBlackWhiteInput,
            ),
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  text14.copyWith(
                    color: getColor().textColorGray,
                  ),
              label: Text(
                widget.label ?? "",
                style: text11.copyWith(
                  color: getColor().textColorGray,
                ),
              ),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              filled: true,
              errorStyle: text11.copyWith(
                color: getColor().themeColorRed,
              ),
              fillColor: getColor().themeColorWhiteBlack,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              suffix: firstInit
                  ? _errorText.isEmpty
                      ? Icon(
                          Icons.check,
                          color: focused
                              ? getColor().themeColorGreen
                              : Colors.transparent,
                        )
                      : Icon(
                          Icons.close,
                          color: getColor().themeColorRed,
                        )
                  : Icon(
                      Icons.close,
                      color: Colors.transparent,
                    ),
            ),
          ),
        ),
        if (_errorText.isNotEmpty && firstInit)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.w),
            child: Text(
              _errorText,
              style: text11.medium.copyWith(
                color: getColor().themeColorRed,
              ),
            ),
          ),
      ],
    );
  }
}
