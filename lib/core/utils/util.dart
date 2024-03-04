import 'package:dio/dio.dart';
import 'collection_util.dart';
import 'package:flutter/material.dart';

import '../../data/data_source/remote/api_reponse/exceptions/api_exception.dart';
import '../../data/model/brand_model.dart';
import '../../data/model/category_model.dart';

String trimStringCharactersByAmount(String input, {int amount = 120}) {
  if (input.length > amount) {
    return '${input.substring(
      0,
      amount,
    )} ...';
  }
  return input;
}

void setValueValidator(
  List<String> validator,
  ValueNotifier valueNotifier,
) {
  if (validator.isNullOrEmpty) {
    return;
  }
  String message = "";
  for (String element in validator) {
    message += "$element\n";
  }
  valueNotifier.value = message;
}

ValidatorModel? getValidatorFromDioException(DioException object) {
  final apiException = ApiException.fromMap(
      object.response?.data, object.response?.statusCode ?? -1);
  if (apiException.validator == null) {
    return null;
  }
  final validator = apiException.validator!;
  return validator;
}

void setValueNotifier<T>(ValueNotifier<T> notifier, T value) {
  notifier.value = value;
}

Map<String, dynamic> toMapFilters({
  required double minPrice,
  required double maxPrice,
  required List<Color> colors,
  required List<int> sizes,
  CategoryModel? category,
  required List<MBrand> brands,
}) {
  return {
    'minPrice': minPrice,
    'maxPrice': maxPrice,
    'colors': colors,
    'sizes': sizes,
    'category': category,
    'brands': brands,
  };
}

Color toColorFromString(String value) {
  return Color(int.parse(value));
}

void unFocus() {
  primaryFocus?.unfocus();
}
