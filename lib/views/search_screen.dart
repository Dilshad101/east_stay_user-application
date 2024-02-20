import 'package:east_stay/blocs/home_bloc/home_bloc.dart';
import 'package:east_stay/blocs/search_bloc/search_bloc.dart';
import 'package:east_stay/resources/components/filter_box.dart';
import 'package:east_stay/resources/components/search_bar.dart';
import 'package:east_stay/resources/components/search_room_tile.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({super.key});
  final priceNotifier = ValueNotifier<double?>(null);
  final filterNotifier = ValueNotifier({
    'Classic': false,
    'Elite': false,
    'Deluxe': false,
    'Luxury': false,
  });
  @override
  Widget build(BuildContext context) {
    context.read<SearchBloc>().add(SearchShowAllEvent());
    return Scaffold(
      appBar: AppBar(title: const Text('Discover your room'), elevation: 0),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Stack(
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadedSuccessState) {
                  return BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchFoundState) {
                        return ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.hotelList.length,
                          itemBuilder: (context, index) => SearchTile(
                            hotel: state.hotelList[index],
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 15),
                        );
                      } else if (state is SearchNotFoundState) {
                        return Center(
                          child:
                              Text('No Hotels found', style: AppText.largeDark),
                        );
                      }
                      return const Center(child: Text('Search hotels'));
                    },
                  );
                }
                return const SizedBox();
              },
            ),
            searchBar(context),
          ],
        ),
      ),
    );
  }

  Positioned searchBar(BuildContext context) {
    return Positioned(
      left: 20,
      right: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSearchBar(
            ishome: false,
            filterNotifier: filterNotifier,
            priceNotifier: priceNotifier,
            onFilterPressed: () => showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              builder: (context) => FilterBox(
                filterNotifier: filterNotifier,
                priceNotifier: priceNotifier,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
