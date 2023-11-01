import 'package:east_stay/data/network/network_api_services.dart';
import 'package:east_stay/data/shared_preferences/shared_pref.dart';
import 'package:east_stay/resources/app_urls/app_urls.dart';
import 'package:east_stay/utils/type_def.dart';

class RoomRepo {
  final token = SharedPref.instance.getUser();
  EitherResponse getAllRooms() async =>
      await ApiServices.getApi(AppUrls.getAllHotels);
  EitherResponse getBookedHotels() async =>
      await ApiServices.getApi(AppUrls.getBookedHotels, token);

  EitherResponse getRoomCoupon(String vendorId) async =>
      await ApiServices.getApi(
        AppUrls.getHotelCoupons.replaceFirst('vendorId', vendorId),
      );

  EitherResponse rateARoom(var review) async {
    return await ApiServices.postApi(review, AppUrls.rateARoom);
  }

  EitherResponse getRoomReview(String roomId) async {
    return await ApiServices.getApi(
        AppUrls.getRoomReview.replaceFirst('roomId', roomId), token);
  }
}
