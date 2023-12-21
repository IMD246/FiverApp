import 'package:fiver/core/constant/constants.dart';
import 'package:fiver/core/di/locator_service.dart';
import 'package:fiver/core/utils/util.dart';
import 'package:fiver/data/data_source/local/isar_db.dart';
import 'package:fiver/data/data_source/local/preferences.dart';
import 'package:fiver/data/repositories/local/local_common_repository.dart';
import 'package:fiver/domain/repositories/common_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_remote_common_repository.dart';

void main() {
  late LocalCommonRepository localCommonRepository;
  late TestRemoteCommonRepository testRemoteCommonRepository;
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
    testRemoteCommonRepository = TestRemoteCommonRepository();
  });

  tearDownAll(() async {
    await pref.clear();
    isarDb.close();
  });

  test(
      "gender list data must be cached after calling get remote data from getGenders ",
      () async {
    final genders = await testRemoteCommonRepository.getGenders();

    final localGenders = await localCommonRepository.getGenders();

    expect(
      true,
      equalList(
        genders,
        localGenders,
        equal: (item1, item2) => item1.id == item2.id,
      ),
    );
  });

  test(
      "sort by list data must be cached after calling get remote data from getSortByList ",
      () async {
    final sortByList = await testRemoteCommonRepository.getSortByList();

    final localSortByList = await localCommonRepository.getSortByList();

    expect(
        true,
        equalList(
          sortByList,
          localSortByList,
          equal: (item1, item2) => item1.id == item2.id,
        ));
  });

  test(
      "size list data must be cached after calling get remote data from getSizes ",
      () async {
    final sizes = await testRemoteCommonRepository.getSizes();

    final localSizes = await localCommonRepository.getSizes();

    expect(
        true,
        equalList(
          sizes,
          localSizes,
          equal: (item1, item2) => item1.id == item2.id,
        ));
  });

  test(
      "color list data must be cached after calling get remote data from getColors ",
      () async {
    final colors = await testRemoteCommonRepository.getColors();

    final localColors = await localCommonRepository.getColors();

    expect(
        true,
        equalList(
          colors,
          localColors,
        ));
  });

  test(
      "rangePrice data must be cached after calling get remote data from getRangePrice ",
      () async {
    final rangePrice = await testRemoteCommonRepository.getRangePrice();

    final localRangePrice = await localCommonRepository.getRangePrice();

    expect(
        true,
        equalList(
          rangePrice,
          localRangePrice,
        ));
  });
}
