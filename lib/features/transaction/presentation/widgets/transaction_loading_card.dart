import 'package:flutter/material.dart';
import 'package:sstation/core/common/widgets/shimmer_loading.dart';

class TransactionLoadingCard extends StatelessWidget {
  const TransactionLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, top: 10),
      child: Card(
        elevation: 5,
        surfaceTintColor: Colors.grey,
        color: Colors.grey.shade300,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      ShimmerLoading(
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                          ),
                          width: 50,
                          height: 50,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ShimmerLoading(
                              Container(
                                color: Colors.black,
                                width: 50,
                                height: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            ShimmerLoading(
                              Container(
                                color: Colors.black,
                                width: 100,
                                height: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            ShimmerLoading(
                              Container(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  color: Colors.black,
                                  width: 150,
                                  height: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
