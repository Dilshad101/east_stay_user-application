import 'package:flutter/material.dart';

class Amenities extends StatelessWidget {
  const Amenities({
    super.key,
    required this.amenities,
  });
  final List<String> amenities;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        childAspectRatio: 1 / .9,
      ),
      itemCount: amenities.length,
      itemBuilder: (context, index) => Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: Text(
          amenities[index],
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     const Icon(Icons.wifi),
        //     const SizedBox(height: 5),
        //     Text(
        //       amenities[index],
        //       style: const TextStyle(
        //         fontSize: 12,
        //         fontWeight: FontWeight.w600,
        //         letterSpacing: 1,
        //       ),
        //       overflow: TextOverflow.ellipsis,
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
