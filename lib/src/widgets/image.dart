import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class SymmetricImage extends StatelessWidget {
  const SymmetricImage({
    Key key,
    @required this.url,
    @required this.size,
    this.borderRadius,
  }) : super(key: key);

  final String url;
  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 5),
      child: ExtendedImage.network(
        url,
        height: size,
        width: size,
        fit: BoxFit.fitWidth,
        borderRadius: BorderRadius.circular(borderRadius ?? 5),
      ),
    );
  }
}
