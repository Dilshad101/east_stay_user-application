class BookingDate {
  final DateTime checkIn;
  final DateTime checkOut;

  BookingDate({required this.checkIn, required this.checkOut});

  factory BookingDate.fromJson(json) {
    final checkInDate = DateTime.parse(json['checkIn']);
    final checkOutDate = DateTime.parse(json['checkOut']);
    return BookingDate(checkIn: checkInDate, checkOut: checkOutDate);
  }
}
