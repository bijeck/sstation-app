import 'package:flutter/material.dart';
import 'package:sstation/core/common/widgets/shimmer_loading.dart';
import 'package:sstation/core/extensions/context_extension.dart';

class PackageLoadingCard extends StatelessWidget {
  const PackageLoadingCard({super.key});

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
              children: [
                Row(
                  children: [
                    ShimmerLoading(
                      Container(
                        width: 70,
                        height: 70,
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
                              width: 100,
                              height: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: Colors.grey.withOpacity(0.5), width: 1)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerLoading(
                            Container(
                              width: 100,
                              height: 20,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: ShimmerLoading(
                              Container(
                                width: 100,
                                height: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShimmerLoading(
                            Container(
                              width: 100,
                              height: 20,
                              color: Colors.black,
                            ),
                          ),
                          ShimmerLoading(
                            Container(
                              width: 100,
                              height: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: context.width,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: Colors.grey.withOpacity(0.5), width: 1)),
                  ),
                  child: ShimmerLoading(
                    Container(
                      width: 100,
                      height: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
