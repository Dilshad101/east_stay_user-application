part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchShowAllEvent extends SearchEvent {}

class SearchHotelEvent extends SearchEvent {
  final String query;
  final List<String> filterList;
  final double? priceRange;
  SearchHotelEvent(
      {required this.query, required this.filterList, this.priceRange});
}
