import 'package:fiver/core/utils/util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fiver/core/constant/constants.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/res/colors.dart';
import 'package:fiver/data/data_source/local/isar_db.dart';
import 'package:fiver/data/data_source/local/preferences.dart';
import 'package:fiver/data/model/size_model.dart';
import 'package:fiver/data/model/sort_by_model.dart';
import 'package:fiver/data/repositories/local/local_common_repository.dart';
import 'package:fiver/domain/repositories/common_repository.dart';

void main() {
  late LocalCommonRepository localCommonRepository;
  late Preferences pref;
  late IsarDb isarDb;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);
    SharedPreferences.setMockInitialValues({});
    await initLocatorSerivce();
    pref = locator<Preferences>();
    await pref.init();
    isarDb = locator<IsarDb>();
    await isarDb.init(isTesting: true);
    localCommonRepository = locator<CommonRepository>(
      instanceName: Constants.instanceLocalCommonRepository,
    ) as LocalCommonRepository;
  });

  tearDownAll(() async {
    await pref.clear();
    isarDb.close();
  });

  test("must be caching colors after calling saveColors", () async {
    final colors = [
      color020202,
      colorF6F6F6,
      colorF48117,
      colorBEA9A9,
      color91BA4F,
      color2CB1B1
    ];

    await localCommonRepository.saveColors(colors);

    final getColors = await localCommonRepository.getColors();

    expect(
        equalList(
          colors,
          getColors,
        ),
        true);
  });

  test("must be caching sizes after calling saveSizes", () async {
    final sizes = [
      SizeModel(id: 1, sizeName: "XS"),
      SizeModel(id: 2, sizeName: "S"),
      SizeModel(id: 3, sizeName: "M"),
      SizeModel(id: 4, sizeName: "L"),
      SizeModel(id: 5, sizeName: "XL"),
    ];

    await localCommonRepository.saveSizes(sizes);

    final getSizes = await localCommonRepository.getSizes();

    expect(
        equalList(
          sizes,
          getSizes,
          equal: (item1, item2) => item1.id == item2.id,
        ),
        true);
  });

  test("must be caching rangePrice data after calling saveRangePrice",
      () async {
    List<double> rangePrice = [3, 5];

    await localCommonRepository.savePriceRange(rangePrice);

    final getRangePrice = await localCommonRepository.getRangePrice();

    expect(equalList(rangePrice, getRangePrice), true);
  });

  test("must be caching sortByList data after calling saveSortByList",
      () async {
    final sortByList = [
      SortByModel(id: 1, name: "Popular"),
      SortByModel(id: 2, name: "Newest"),
      SortByModel(id: 3, name: "Customer review"),
      SortByModel(id: 4, name: "Price: lowest to high"),
      SortByModel(id: 5, name: "Price: highest to low"),
    ];

    await localCommonRepository.saveSortByList(sortByList);

    final getSortByList = await localCommonRepository.getSortByList();

    expect(
        equalList(
          sortByList,
          getSortByList,
          equal: (item1, item2) => item1.id == item2.id,
        ),
        true);
  });
}
