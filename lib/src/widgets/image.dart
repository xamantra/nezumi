import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key key,
    @required this.url,
    this.file = false,
    this.asset = false,
    double size,
    double height,
    double width,
    this.borderRadius,
    this.fit,
  })  : this.height = size != null ? size : height,
        this.width = size != null ? size : width,
        super(key: key);

  final String url;
  final bool file;
  final bool asset;
  final double height;
  final double width;
  final BoxFit fit;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 5),
      child: Container(
        height: height,
        width: width,
        child: file
            ? ExtendedImage.file(
                File(url),
                height: height,
                width: width,
                fit: fit ?? BoxFit.fitWidth,
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
              )
            : asset
                ? ExtendedImage.asset(
                    url,
                    height: height,
                    width: width,
                    fit: fit ?? BoxFit.fitWidth,
                    borderRadius: BorderRadius.circular(borderRadius ?? 5),
                  )
                : ExtendedImage.network(
                    url,
                    height: height,
                    width: width,
                    fit: fit ?? BoxFit.fitWidth,
                    borderRadius: BorderRadius.circular(borderRadius ?? 5),
                  ),
      ),
    );
  }
}
