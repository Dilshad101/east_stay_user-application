// ignore_for_file: prefer_const_constructors

import 'package:east_stay/blocs/search_bloc/search_bloc.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/views/search_screen.dart';
import 'package:east_stay/resources/components/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSearchBar extends StatelessWidget {
  AppSearchBar({
    super.key,
    this.ishome = true,
    this.onFilterPressed,
    this.onChanged,
    this.filterNotifier,
    this.priceNotifier,
  });

  final bool ishome;
  final VoidCallback? onFilterPressed;
  final void Function(String)? onChanged;
  final ValueNotifier<Map<String, bool>>? filterNotifier;
  final ValueNotifier<double?>? priceNotifier;
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ishome
          ? const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            )
          : const EdgeInsets.all(0),
      child: Hero(
        tag: 'search',
        child: Material(
          color: AppColor.backgroundColor,
          child: Row(
            children: [
              Expanded(
                child: ishome
                    ? AppTextField(
                        borderRadius: 6,
                        isReadOnly: true,
                        fillColor: Colors.white,
                        hint: 'Search city, state...',
                        suffixIcon: Icons.search,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ScreenSearch()),
                        ),
                      )
                    : AppTextField(
                        controller: searchController,
                        hint: 'Search city, state...',
                        onChanged: (val) {
                          List<String> filters = [];
                          filterNotifier!.value.forEach((key, value) {
                            if (value) {
                              filters.add(key);
                            }
                          });
                          context.read<SearchBloc>().add(SearchHotelEvent(
                                query: val,
                                filterList: filters,
                                priceRange: priceNotifier?.value,
                              ));
                        },
                        fillColor: Colors.white,
                        suffixIcon: Icons.search,
                      ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(width: 1, color: AppColor.grey[400]!),
                  color: Colors.white,
                ),
                child: IconButton(
                  onPressed: onFilterPressed,
                  icon: const Icon(Icons.tune_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
