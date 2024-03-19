import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fiver/core/constant/api_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaUtils {
  MediaUtils._();

  static Future<bool> checkXFileSizeIsInvalid(XFile file) async {
    final size = await file.readAsBytes();

    if (size.lengthInBytes > ApiConstant.SIZE_IMAGE_REQUIRED) {
      return true;
    }
    return false;
  }

  static Future<bool> checkFileSizeIsInvalid(File? file) async {
    if (file == null) return true;

    final size = await file.length();

    if (size > ApiConstant.SIZE_IMAGE_REQUIRED) {
      return true;
    }

    return false;
  }

  static Future<FormData> settingFormDataForAvatarUpload(
    String filePath,
    String fileName,
  ) async {
    return FormData.fromMap(
      {
        "avatar": await MultipartFile.fromFile(
          filePath,
          filename: fileName,
          contentType: MediaType(
            'image',
            getExtensionFile(filePath),
          ),
        ),
      },
    );
  }

  static Future<FormData> settingFormDataForMultipleXImagesUpload(
    List<XFile> files,
  ) async {
    List<MultipartFile> multipartFileList = [];
    for (int i = 0; i < files.length; i++) {
      multipartFileList.add(
        await MultipartFile.fromFile(
          files[i].path,
          filename: files[i].name,
          contentType: MediaType(
            'image',
            getExtensionFile(files[i].path),
          ),
        ),
      );
    }
    return FormData.fromMap(
      {
        "images": multipartFileList,
      },
    );
  }

  static Future<List<MultipartFile>> settingMultipartFiles(
    List<File> files,
  ) async {
    List<MultipartFile> multipartFileList = [];
    for (int i = 0; i < files.length; i++) {
      String fileName = getFileName(files[i].path);

      multipartFileList.add(
        await MultipartFile.fromFile(
          files[i].path,
          filename: fileName,
          contentType: MediaType(
            'image',
            getExtensionFile(files[i].path),
          ),
        ),
      );
    }
    return multipartFileList;
  }

  static String getExtensionFile(String filePath) {
    return filePath.split(".").last;
  }

  static String getFileName(String filePath) {
    return filePath.split("/").last;
  }

  static Future<File> urlImageToFile({required String url}) async {
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

  static Future<void> clearDirectoryApp(String name) async {
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

  static Future<List<File>> compressImages(
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

  static Future<List<String>> toBase64Strings(
      List<File> originalImageFiles) async {
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

  static int _getQuality(dynamic fileLength) {
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

  static Future<File?> compressImage(
    AssetEntity originalImageFile,
  ) async {
    try {
      final originalFile = (await originalImageFile.file)!;
      final originalSizeInBytes = await originalFile.readAsBytes();
      final List<int> finalCompressedImageData =
          await FlutterImageCompress.compressWithList(
        originalSizeInBytes,
        quality: _getQuality(originalSizeInBytes.length),
      );

      final pdfName = "${originalFile.path}.${getExtensionFile(
        originalFile.path,
      )}";

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
}
