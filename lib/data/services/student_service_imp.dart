import 'package:fiven/base/rest_client.dart';
import 'package:fiven/core/enum.dart';
import 'package:fiven/data/model/student.dart';
import 'package:fiven/domain/services/student_service.dart';

import '../../core/di/locator_service.dart';

class StudentServiceImp implements StudentService {
  @override
  Future<Student> getStudent() async => restClient.request(MethodType.get, 'student');

  @override
  RestClient restClient = locator<RestClient>();
}
