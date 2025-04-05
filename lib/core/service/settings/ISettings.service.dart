import 'package:dartz/dartz.dart';

abstract class ISettingsService {
  Future<Either<Unit, Unit>> setLanguage();
}
