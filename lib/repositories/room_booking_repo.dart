import 'package:east_stay/data/network/network_api_services.dart';
import 'package:east_stay/data/shared_preferences/shared_pref.dart';
import 'package:east_stay/resources/app_urls/app_urls.dart';
import 'package:east_stay/utils/type_def.dart';

class RoomBookingRepo {
  final token = SharedPref.instance.getUser();
  EitherResponse applyCoupon(var coupon) async {
    return await ApiServices.postApi(coupon, AppUrls.applyCoupon, token);
  }

  EitherResponse cancelRoom(var bookId) async {
    return await ApiServices.postApi(bookId, AppUrls.cancelRoom);
  }
}
