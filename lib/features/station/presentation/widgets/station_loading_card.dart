import 'package:flutter/material.dart';
import 'package:sstation/core/common/widgets/shimmer_loading.dart';

class StationLoadingCard extends StatelessWidget {
  const StationLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      surfaceTintColor: Colors.grey,
      color: Colors.grey.shade300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ShimmerLoading(
                      Container(
                        width: 50,
                        height: 50,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerLoading(
                            Container(
                              width: 150,
                              height: 20,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          ShimmerLoading(
                            Container(
                              width: 250,
                              height: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i = 0; i < 8; i++)
                        ShimmerLoading(
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            width: 50,
                            height: 50,
                            color: Colors.black,
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
