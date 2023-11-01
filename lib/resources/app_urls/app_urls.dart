class AppUrls {
  static const String _baseUrl = 'https://api.electronicsmart.shop';
  static const String userLogin = '$_baseUrl/api/user_signin';
  static const String userSignupValidation = '$_baseUrl/api/user_check';
  static const String userSignup = '$_baseUrl/api/user_signup';
  static const String getAllHotels = '$_baseUrl/api/getRoomdetails';
  static const String getHotelCoupons = '$_baseUrl/api//getCoupon/vendorId';
  static const String getUserProfie = '$_baseUrl/api/user_data';
  static const String getBookedHotels = '$_baseUrl/api/bookingData';
  static const String updateUserProfile = '$_baseUrl/api/editProfile';
  static const String changePassword = '$_baseUrl/api/editpassword';
  static const String rateARoom = '$_baseUrl/api/review';
  static const String cancelRoom = '$_baseUrl/api/cancelbooking';
  static const String getRoomReview = '$_baseUrl/api/getReiviews/roomId';
  static const String applyCoupon = '$_baseUrl/api/coupnapply';
}
