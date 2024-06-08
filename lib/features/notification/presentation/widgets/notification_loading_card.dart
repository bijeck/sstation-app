import 'package:flutter/material.dart';
import 'package:sstation/core/common/widgets/shimmer_loading.dart';
import 'package:sstation/core/extensions/context_extension.dart';

class NotificationLoadingCard extends StatelessWidget {
  const NotificationLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 5),
      color: Colors.grey[300],
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShimmerLoading(
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black),
                  width: 50,
                  height: 50,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerLoading(
                    Container(
                      color: Colors.black,
                      width: 150,
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
                      color: Colors.black,
                      width: 100,
                      height: 15,
                    ),
                  ),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}
