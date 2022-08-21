import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  const ShimmerWidget({this.width = 400, required this.height});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey[200]!,
        child: Padding(
          padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );
}
