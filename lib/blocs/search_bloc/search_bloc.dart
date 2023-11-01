import 'package:east_stay/blocs/home_bloc/home_bloc.dart';
import 'package:east_stay/models/room_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.homeBloc) : super(SearchInitial()) {
    on<SearchHotelEvent>(_onSearch);
    on<SearchShowAllEvent>(_refresh);
  }
  final HomeBloc homeBloc;
  _onSearch(SearchHotelEvent event, Emitter<SearchState> emit) {
    List<Hotel> rawHotelList = homeBloc.hotelList;
    List<String> selectedCategories =
        event.filterList.map((e) => e.toLowerCase()).toList();
    double? maxPrice = event.priceRange;

    if (selectedCategories.isNotEmpty) {
      rawHotelList = rawHotelList
          .where((hotel) =>
              selectedCategories.contains(hotel.category.toLowerCase()))
          .toList();
    }

    final searchQuery = event.query.toLowerCase();

    rawHotelList = rawHotelList
        .where((hotel) =>
            hotel.state.toLowerCase().contains(searchQuery) ||
            hotel.city.toLowerCase().contains(searchQuery))
        .toList();

    if (maxPrice != null) {
      rawHotelList = rawHotelList.where((hotel) {
        final price = double.parse(hotel.price);
        return price <= maxPrice;
      }).toList();
    }

    if (rawHotelList.isNotEmpty) {
      emit(SearchFoundState(hotelList: rawHotelList));
    } else {
      emit(SearchNotFoundState());
    }
  }

  _refresh(SearchShowAllEvent event, Emitter<SearchState> emit) {
    emit(SearchFoundState(hotelList: homeBloc.hotelList));
  }
}
