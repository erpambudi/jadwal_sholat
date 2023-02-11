import 'package:flutter/material.dart';
import 'package:jadwal_sholat/common/constants/app_values.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              color: Colors.white,
              height: 300,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: AppValues.margin_18,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: List.generate(5, (index) {
                return Container(
                  margin: const EdgeInsets.only(
                    bottom: AppValues.margin,
                    left: AppValues.margin,
                    right: AppValues.margin,
                  ),
                  height: 60,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppValues.radius_12),
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
