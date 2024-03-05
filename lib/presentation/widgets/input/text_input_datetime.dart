import '../../../core/helper/show_date_picker_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/res/theme/text_theme.dart';
import '../../../core/res/theme/theme_manager.dart';
import '../../../core/utils/input_formatter_utils.dart';

class TextInputDateTime extends StatefulWidget {
  const TextInputDateTime({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.hintStyle,
    this.validator,
    this.textInputAction,
    this.onChangedDatePicker,
  });
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextInputAction? textInputAction;
  final ValueNotifier<String>? validator;
  final void Function(DateTime? value)? onChangedDatePicker;
  @override
  State<TextInputDateTime> createState() => _TextInputDateTimeState();
}

class _TextInputDateTimeState extends State<TextInputDateTime> {
  String _errorText = "";
  final FocusNode _focusNode = FocusNode();
  bool focused = false;

  void _init() {
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
  void initState() {
    super.initState();
    _init();
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
            focusNode: _focusNode,
            textAlignVertical: TextAlignVertical.center,
            controller: widget.controller,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              DateTextFormatter(),
            ],
            style: text14.medium.copyWith(
              color: getColor().textColorBlackWhiteInput,
            ),
            textInputAction: widget.textInputAction,
            keyboardType: TextInputType.number,
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
              suffix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _errorText.isEmpty
                      ? Icon(
                          Icons.check,
                          color: focused
                              ? getColor().themeColorGreen
                              : Colors.transparent,
                        )
                      : Icon(
                          Icons.close,
                          color: getColor().themeColorRed,
                        ),
                  SizedBox(width: 4.w),
                  InkWell(
                    onTap: () => commonShowDatePicker(context: context).then(
                      (value) {
                        if (widget.onChangedDatePicker != null) {
                          widget.onChangedDatePicker!(value);
                        }
                      },
                    ),
                    child: const Icon(
                      Icons.date_range_outlined,
                      color: Colors.red,
                    ),
                  )
                ],
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
