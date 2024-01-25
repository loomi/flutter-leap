import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/assets.dart';

class CustomNetworkImage extends StatefulWidget {
  final String imageUrl;
  final Alignment alignment;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final Widget Function(BuildContext, String, DownloadProgress)? placeholder;
  final Color? backgroundColor;
  final double errorIconSize;
  final String? errorText;
  final TextStyle? errorTextStyle;
  final Color progressIndicatorColor;
  final double borderRadius;

  const CustomNetworkImage({
    Key? key,
    required this.imageUrl,
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.errorWidget,
    this.placeholder,
    this.backgroundColor,
    this.errorIconSize = 65,
    this.errorText,
    this.errorTextStyle,
    this.progressIndicatorColor = Colors.blue,
    this.borderRadius = 0,
  }) : super(key: key);

  @override
  State<CustomNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: CachedNetworkImage(
        imageUrl: widget.imageUrl,
        alignment: widget.alignment,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        errorWidget: widget.errorWidget ??
            (context, url, error) => Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: widget.backgroundColor ?? Colors.grey.shade300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.alertIcon,
                        height: widget.errorIconSize,
                      ),
                      if (widget.errorText != null)
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            widget.errorText!,
                            style: widget.errorTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        )
                    ],
                  ),
                ),
        progressIndicatorBuilder: widget.placeholder ??
            (context, url, progress) => Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: widget.backgroundColor ?? Colors.grey.shade300,
                  child: Center(
                    child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widget.progressIndicatorColor,
                      ),
                    ),
                  ),
                ),
      ),
    );
  }
}
