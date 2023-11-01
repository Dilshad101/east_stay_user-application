import 'package:east_stay/data/network/network_api_services.dart';
import 'package:east_stay/data/shared_preferences/shared_pref.dart';
import 'package:east_stay/resources/app_urls/app_urls.dart';
import 'package:east_stay/utils/type_def.dart';

class AuthRepo {
  EitherResponse loginUser(userData) async =>
      await ApiServices.postApi(userData, AppUrls.userLogin);
  EitherResponse signupUserValidation(userData) async =>
      await ApiServices.postApi(userData, AppUrls.userSignupValidation);
  EitherResponse signupUser(userData) async =>
      await ApiServices.postApi(userData, AppUrls.userSignup);
  EitherResponse getUserProfie(String token) async =>
      await ApiServices.getApi(AppUrls.getUserProfie, token);
  EitherResponse changePassword(data) async => await ApiServices.patchApi(
      data, AppUrls.changePassword, SharedPref.instance.getUser()!);
  EitherResponse updateUserProfile(userData, String token) async {
    return await ApiServices.patchApi(
        userData, AppUrls.updateUserProfile, token);
  }
}
