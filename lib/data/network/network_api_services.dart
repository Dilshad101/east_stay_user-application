import 'dart:convert';
import 'package:east_stay/data/exceptions/app_exceptions.dart';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;

import '../../utils/type_def.dart';


class ApiServices {
  static final _headers = {'Content-Type': 'application/json'};
  
  static EitherResponse<Map> postApi(var rawData, String url) async {
    Map fetchedData = {};
    final uri = Uri.parse(url);
    final body = jsonEncode(rawData);
    try {
      final response = await http.post(uri, body: body, headers: _headers);
      fetchedData = getResponse(response);
    } catch (e) {
      return Left(e as AppException);
    }
    return Right(fetchedData);
  }

  static Map<String, dynamic> getResponse(http.Response response) {
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
