import 'package:flutter/material.dart';

import 'package:sstation/core/common/widgets/text_base.dart';
import 'package:sstation/core/extensions/context_extension.dart';
import 'package:sstation/core/res/colours.dart';
import 'package:sstation/core/res/media_res.dart';
import 'package:sstation/features/station/domain/entities/station.dart';

class StationCard extends StatelessWidget {
  const StationCard({
    super.key,
    required this.station,
  });

  final Station station;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        clipBehavior: Clip.hardEdge,
        elevation: 4,
        color: Colours.sentPackageColour,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          width: context.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage(MediaRes.warehouse),
                      ),
                    ),
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        value: station.name,
                        weight: FontWeight.w600,
                        size: 18,
                      ),
                      const SizedBox(height: 5),
                      BaseText(
                        maxLine: 3,
                        overflow: TextOverflow.ellipsis,
                        value: station.address.isNotEmpty
                            ? '${station.name} ${station.address}'
                            : 'Un-serviceable Area',
                        weight: FontWeight.normal,
                        size: 13,
                        color: Colours.secondayTextColour,
                      ),
                    ],
                  )),
                ],
              ),
              const SizedBox(height: 5),
              Container(
                width: context.width,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.withOpacity(0.6),
                      width: 1,
                    ),
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i = 0; i < station.stationImages.length; i++)
                        Container(
                          margin: const EdgeInsets.only(right: 5, top: 10),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: station.stationImages.isNotEmpty &&
                                      station.stationImages[i]
                                          .startsWith('https://')
                                  ? NetworkImage(
                                      station.stationImages[i],
                                    )
                                  : const AssetImage(MediaRes.warehouse)
                                      as ImageProvider,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
