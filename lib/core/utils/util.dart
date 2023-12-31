import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';

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

Future<File?> compressImage(
  AssetEntity originalImageFile,
) async {
  try {
    final originalFile = (await originalImageFile.file)!;
    final originalSizeInBytes = await originalFile.readAsBytes();
    final List<int> finalCompressedImageData =
        await FlutterImageCompress.compressWithList(originalSizeInBytes,
            quality: _getQuality(originalSizeInBytes.length));
    final pdfName = "${originalFile.path}.${originalFile.path.split(".").last}";
    File newFile = File(pdfName);
    newFile.writeAsBytesSync(List<int>.from(finalCompressedImageData));
    return newFile;
  } catch (error) {
    if (kDebugMode) {
      print("Image compression error: $error");
    }
    return null;
  }
}

Future<List<File>> compressImages(
  List<AssetEntity> originalImageFiles,
) async {
  try {
    List<File> newImageFiles = [];
    for (var element in originalImageFiles) {
      newImageFiles.add((await compressImage(element))!);
    }
    return newImageFiles;
  } catch (error) {
    if (kDebugMode) {
      print("Image compression error: $error");
    }
    return [];
  }
}

Future<List<String>> toBase64Strings(List<File> originalImageFiles) async {
  try {
    List<String> base64Strings = [];
    for (var element in originalImageFiles) {
      base64Strings.add(base64Encode(await element.readAsBytes()));
    }
    return base64Strings;
  } catch (error) {
    if (kDebugMode) {
      print("Image compression error: $error");
    }
    return [];
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

bool equalList<T>(List<T> list1, List<T> list2,
    {bool Function(T item1, T item2)? equal}) {
  // if both list are empty
  // then no need no compare
  // return true directly
  if (list1.isEmpty && list2.isEmpty) {
    return true;
  } else if (list1.length == list2.length) {
    // if both list have equal length
    // take first list every element and compare with second list every element
    // if all element are same it will return true
    final bool isSame = list1.every(
      (e1) {
        return list2.any(
          (e2) {
            if (equal != null) {
              return equal(e1, e2);
            }
            return e1 == e2;
          },
        );
      },
    );

    return isSame;
  } else {
    // when both list are not equal length
    return false;
  }
}

Future<void> clearDirectoryApp(String name) async {
  try {
    String baseDir = Directory.current.path;

    final dir = Directory("$baseDir$name");
    dir.deleteSync(recursive: true);
  } catch (e) {
    if (kDebugMode) {
      print("clear directory cause error: $e");
    }
  }
}

Future<File> urlImageToFile({required String url}) async {
  /// Get Image from server
  final Response res = await Dio().get<List<int>>(
    url,
    options: Options(
      responseType: ResponseType.bytes,
    ),
  );

  /// Get App local storage

  final Directory directory = await getTemporaryDirectory();

  final File file = await File('${directory.path}/image.png').writeAsBytes(
    res.data,
  );

  file.writeAsBytesSync(res.data as List<int>);

  return file;
}
