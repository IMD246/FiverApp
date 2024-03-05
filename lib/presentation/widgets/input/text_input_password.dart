import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/res/theme/text_theme.dart';
import '../../../core/res/theme/theme_manager.dart';

class TextInputPassword extends StatefulWidget {
  const TextInputPassword({
    super.key,
    required this.controller,
    this.label,
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
  State<TextInputPassword> createState() => _TextInputPasswordState();
}

class _TextInputPasswordState extends State<TextInputPassword> {
  String _errorText = "";
  bool _obsecureText = true;

  void _init() {
    if (widget.validator != null) {
      widget.validator!.addListener(() {
        setState(() {
          _errorText = widget.validator!.value;
        });
      });
    }
  }

  void _updateObsecureText() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
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
              color: _errorText.isEmpty
                  ? Colors.transparent
                  : getColor().themeColorRed,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 14.w,
          ),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            controller: widget.controller,
            inputFormatters: widget.inputFormatters,
            style: text14.medium.copyWith(
              color: getColor().textColorBlackWhiteInput,
            ),
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType ?? TextInputType.visiblePassword,
            obscureText: _obsecureText,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  text14.copyWith(
                    color: getColor().textColorGray,
                  ),
              label: widget.label != null
                  ? Text(
                      widget.label ?? "",
                      style: text14.copyWith(
                        color: getColor().textColorGray,
                      ),
                    )
                  : null,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              filled: true,
              errorStyle: text11.copyWith(
                color: getColor().themeColorRed,
              ),
              fillColor: getColor().themeColorWhiteBlack,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              suffix: widget.controller.text.isEmpty
                  ? null
                  : InkWell(
                      onTap: _updateObsecureText,
                      child: Icon(
                        _obsecureText ? Icons.visibility : Icons.visibility_off,
                        color: getColor().themeColorBlackWhite,
                      ),
                    ),
            ),
          ),
        ),
        if (_errorText.isNotEmpty)
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
