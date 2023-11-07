import 'package:fiven/core/res/theme/text_theme.dart';
import 'package:fiven/core/res/theme/theme_manager.dart';
import 'package:fiven/core/utils/deboucer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextInputPassword extends StatefulWidget {
  const TextInputPassword({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.hintStyle,
    this.inputFormatters,
    this.validator,
    this.textInputAction,
    this.keyboardType,
    this.errorText,
  });
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final TextStyle? hintStyle;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? errorText;
  final String Function(String value)? validator;
  @override
  State<TextInputPassword> createState() => _TextInputPasswordState();
}

class _TextInputPasswordState extends State<TextInputPassword> {
  String errorText = "";
  final FocusNode _focusNode = FocusNode();
  final _deboucer = Debouncer();
  bool _obsecureText = false;
  void _updateObsecureText() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  void _onChanged(String value) {
    _deboucer.run(
      milliseconds: 100,
      action: () {
        if (widget.validator != null) {
          setState(() {
            errorText = widget.validator!(value);
          });
        }
      },
    );
  }

  void _onListenFocusNode() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _onChanged(widget.controller.text);
      } else {
        setState(() {
          errorText = "";
        });
      }
    });
  }

  @override
  void initState() {
    _onListenFocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _deboucer.timer?.cancel();
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
              color: errorText.isEmpty
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
            obscureText: _obsecureText,
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
              suffix: widget.controller.text.isEmpty
                  ? null
                  : InkWell(
                      onTap: () {
                        _updateObsecureText();
                      },
                      child: Icon(
                        _obsecureText ? Icons.visibility : Icons.visibility_off,
                        color: getColor().themeColorBlackWhite,
                      ),
                    ),
            ),
          ),
        ),
        if (errorText.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.w),
            child: Text(
              errorText,
              style: text11.medium.copyWith(
                color: getColor().themeColorRed,
              ),
            ),
          ),
      ],
    );
  }
}
