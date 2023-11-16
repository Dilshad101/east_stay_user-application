import 'package:east_stay/utils/app_exceptions.dart';
import 'package:either_dart/either.dart';

typedef EitherResponse<T> = Future<Either<AppException, T>>;
