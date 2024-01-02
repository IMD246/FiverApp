import 'package:flutter/material.dart';

class StarWidget extends StatelessWidget {
  const StarWidget({
    super.key,
    required this.width,
    required this.height,
    required this.length,
  });
  final double width;
  final double height;
  final int length;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: width,
        minHeight: height,
      ),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          length,
          (index) {
            return _starItem(height);
          },
        ),
      ),
    );
  }

  Widget _starItem(double sizeItem) {
    return Icon(
      size: sizeItem,
      Icons.star,
      color: Colors.amber,
    );
  }
}
