import 'package:east_stay/blocs/home_bloc/home_bloc.dart';
import 'package:east_stay/blocs/search_bloc/search_bloc.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/components/filter_box.dart';
import 'package:east_stay/resources/components/search_bar.dart';
import 'package:east_stay/resources/components/search_room_tile.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({super.key});
  final boxNotifier = ValueNotifier(false);
  final priceNotifier = ValueNotifier<double?>(null);
  final filterNotifier = ValueNotifier({
    'Classic': false,
    'Elite': false,
    'Deluxe': false,
    'Luxury': false,
  });
  @override
  Widget build(BuildContext context) {
    // final dwidth = MediaQuery.sizeOf(context).width;
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
            filterBox(),
            searchBar(),
          ],
        ),
      ),
    );
  }

  Positioned filterBox() {
    return Positioned(
      top: 70,
      left: 20,
      right: 20,
      child: FilterBox(
        boxNotifier: boxNotifier,
        filterNotifier: filterNotifier,
        priceNotifier: priceNotifier,
      ),
    );
  }

  Positioned searchBar() {
    return Positioned(
      left: 20,
      right: 20,
      child: Column(
        children: [
          AppSearchBar(
            ishome: false,
            filterNotifier: filterNotifier,
            priceNotifier: priceNotifier,
            onFilterPressed: () => boxNotifier.value = !boxNotifier.value,
          ),
          Container(height: 20, color: AppColor.backgroundColor),
        ],
      ),
    );
  }
}
