class AppUrls {
  static const String _baseUrl = "https://quickbook-backend.onrender.com";
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
  static const String getRoomReview = '$_baseUrl/api/getReiviews/';
  static const String applyCoupon = '$_baseUrl/api/coupnapply';
  static const String getTopRatedRooms = '$_baseUrl/api/top-rated-rooms';
  static const String addToWishlist = '$_baseUrl/api/wishlist/add';
  static const String getWishListedRooms = '$_baseUrl/api/wishlist/';
  static const String getAvailableDates = '$_baseUrl/api/getDates/';
  static const String bookRoom = '$_baseUrl/api/createbooking';
  static const String removeFromWishlist = '$_baseUrl/api//delete-wishlist/';
}
// 'https://api.electronicsmart.shop'