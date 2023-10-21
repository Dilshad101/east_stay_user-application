import 'package:east_stay/data/network/network_api_services.dart';
import 'package:east_stay/resources/app_urls/app_urls.dart';
import 'package:east_stay/utils/type_def.dart';

class AuthRepo {
  EitherResponse loginUser(userData) async =>
      await ApiServices.postApi(userData, AppUrls.userLogin);
  EitherResponse signupUserValidation(userData) async =>
      await ApiServices.postApi(userData, AppUrls.userSignupValidation);
}