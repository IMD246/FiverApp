import 'package:fiven/data/model/base_model.dart';

class Student extends BaseResponseModel {
  final String name;
  Student({
    required this.name,
  });

  @override
  fromJson(Map<String, dynamic> map) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
