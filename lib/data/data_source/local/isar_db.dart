import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../model/gender_model.dart';
import '../../model/size_model.dart';
import '../../model/sort_by_model.dart';

class IsarDb {
  late final Isar isar;

  Future<void> init({bool isTesting = false}) async {
    if (isTesting) {
      isar = await Isar.open([
        GenderModelSchema,
        SizeModelSchema,
        SortByModelSchema,
      ], directory: "");
    } else {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [
          GenderModelSchema,
          SizeModelSchema,
          SortByModelSchema,
        ],
        directory: dir.path,
      );
    }
  }

  void close() => isar.close();

  Future<void> clear() async {
    await isar.writeTxn(() async {
      await isar.clear();
    });
  }

  Future<List<GenderModel>> getGenders() async {
    try {
      final getGenders = await isar.genderModels.where().findAll();
      return getGenders;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  Future<void> saveGenders(List<GenderModel> genders) async {
    try {
      await isar.writeTxn(() async {
        await isar.genderModels.clear();
        isar.genderModels.putAll(genders);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<List<SizeModel>> getSizes() async {
    try {
      final getSizes = await isar.sizeModels.where().findAll();
      return getSizes;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  Future<void> saveSizes(List<SizeModel> sizes) async {
    try {
      await isar.writeTxn(() async {
        await isar.sizeModels.clear();
        isar.sizeModels.putAll(sizes);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<List<SortByModel>> getSortByList() async {
    try {
      final getSortByList = await isar.sortByModels.where().findAll();
      return getSortByList;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  Future<void> saveSortByList(List<SortByModel> sortByList) async {
    try {
      await isar.writeTxn(() async {
        await isar.sortByModels.clear();
        isar.sortByModels.putAll(sortByList);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
