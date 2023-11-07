import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';

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
    // ignore: unnecessary_null_comparison
    if (this == null) {
      return true;
    }

    if (this is String) {
      return (this as String).isEmpty;
    }

    if (this is Iterable) {
      return (this as Iterable).isEmpty;
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
