import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';

import '../../data/data_source/remote/api_reponse/exceptions/api_exception.dart';
import '../../data/model/brand_model.dart';
import '../../data/model/category_model.dart';

String formatCurrency(
    {required dynamic currency, String? locale, bool isSymbol = true}) {
  return NumberFormat.currency(
          locale: locale ?? 'zh',
          decimalDigits: 0,
          symbol: isSymbol ? '\$' : '')
      .format(currency);
}

String formatDotNumber(
    {required dynamic number, String? locale, bool isSymbol = true}) {
  if (number is num || number is double) {
    return "${number.toStringAsFixed(2)}".replaceAll(".", ",");
  }
  return "$number";
}

String formatMoney(num number, {String? locale}) {
  final isNotInt = (number - number.truncate()) != 0;
  final formatNumber = isNotInt
      ? number.toStringAsFixed(2).replaceAll(".", ",")
      : number.toInt().toString();
  return formatNumber;
}

String trimStringCharactersByAmount(String input, {int amount = 120}) {
  if (input.length > amount) {
    return '${input.substring(0, amount)} ...';
  }
  return input;
}

extension IsNullOrEmpty<T> on T {
  bool get isNullOrEmpty {
    if (this == null) {
      return true;
    }

    if (this is String) {
      return (this as String).isEmpty;
    }

    if (this is Iterable) {
      return (this as Iterable).isEmpty;
    }

    if (this is List?) {
      return (this as List?) == null || (this as List?)!.isEmpty;
    }

    if (this is List) {
      return (this as List).isEmpty;
    }

    if (this is Map) {
      return (this as Map).isEmpty;
    }

    if (this is bool) {
      return false;
    }

    if (this is num) {
      return false;
    }

    return false;
  }
}

Future<XFile?> compressImage(
  XFile originalImageFile,
) async {
  try {
    var originalSizeInBytes = await originalImageFile.readAsBytes();
    final List<int> finalCompressedImageData =
        await FlutterImageCompress.compressWithList(originalSizeInBytes,
            quality: _getQuality(originalSizeInBytes.length));
    final pdfName = '${originalImageFile.path}/image.jpg';
    File newFile = File(pdfName);
    newFile.writeAsBytesSync(List<int>.from(finalCompressedImageData));
    // newFile =
    //     await newFile.writeAsBytes(List<int>.from(finalCompressedImageData));
    return XFile(newFile.path);
  } catch (error) {
    if (kDebugMode) {
      print("Image compression error: $error");
    }
    return null;
  }
}

int _getQuality(dynamic fileLength) {
  int quality = 0;
  if (fileLength < 500000) {
    quality = 100;
  } else if (fileLength < 2000000) {
    quality = 90;
  } else if (fileLength < 4000000) {
    quality = 80;
  } else if (fileLength < 6000000) {
    quality = 70;
  } else {
    quality = 100 ~/ (fileLength / 500000);
    if (quality < 50) quality = 50;
  }
  return quality;
}

void setValueValidator(List<String> validator, ValueNotifier valueNotifier) {
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

String priceWithUnit(num price) {
  return "${price.toString()}\$";
}

void setValueNotifier(ValueNotifier notifier, dynamic value) {
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


void unFocus(){
  primaryFocus?.unfocus();
}