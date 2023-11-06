import 'package:fiven/core/base/base_service.dart';
import 'package:fiven/data/model/student.dart';

abstract class StudentService extends BaseSerivce {
  StudentService(super.rest);
  Future<Student> getStudent();
}
