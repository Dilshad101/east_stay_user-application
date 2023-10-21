import 'package:east_stay/utils/constents/colors.dart';
import 'package:east_stay/view/search_screen.dart';
import 'package:east_stay/widgets/app_textfield.dart';
import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    this.ishome = true,
    this.onFilterPressed,
  });
  final bool ishome;
  final VoidCallback? onFilterPressed;
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
          child: Row(
            children: [
              Expanded(
                child: ishome
                    ? AppTextField(
                        borderRadius: 6,
                        isReadOnly: true,
                        fillColor: Colors.white,
                        hint: 'Search hotel , appartment...',
                        controller: TextEditingController(),
                        suffixIcon: Icons.search,
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ScreenSearch())),
                      )
                    : AppTextField(
                        borderRadius: 6,
                        hint: 'Search hotel , appartment...',
                        controller: TextEditingController(),
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
