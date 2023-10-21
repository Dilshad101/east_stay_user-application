import 'dart:convert';
import 'package:east_stay/data/exceptions/app_exceptions.dart';
import 'package:east_stay/services/app_urls.dart';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;

typedef EitherResponse<T> = Future<Either<AppException, T>>;

class Api {
  Api._();
  static Api get instance => _instance;
  static final Api _instance = Api._();
  final headers = {'Content-Type': 'application/json'};

  EitherResponse loginUser(userData) async =>
      await postApi(userData, AppUrls.userLogin);
  EitherResponse signupUserValidation(userData) async =>
      await postApi(userData, AppUrls.userSignupValidation);

  EitherResponse<Map> postApi(var rawData, String url) async {
    Map fetchedData = {};
    final uri = Uri.parse(url);
    final body = jsonEncode(rawData);
    try {
      final response = await http.post(uri, body: body, headers: headers);
      fetchedData = getResponse(response);
    } catch (e) {
      return Left(e as AppException);
    }
    return Right(fetchedData);
  }

  Map<String, dynamic> getResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return (jsonDecode(response.body));
      case 400:
        throw BadRequestException();
      default:
        throw BadRequestException();
    }
  }
}
