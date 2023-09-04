import 'package:cached_network_image/cached_network_image.dart';
import 'package:faza_app/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

// ignore: must_be_immutable
class CustomNetworkImage extends StatefulWidget {
  CustomNetworkImage({
    Key? key,
    required this.imagePath,
    required this.height,
    required this.width,
    this.boxFit,
    this.borderRadius,
    this.borderColor,
    this.backgroundColor,
    this.borderWidth,
  }) : super(key: key);
  String imagePath;
  double height;
  double width;
  BoxFit? boxFit;
  double? borderRadius;
  Color? borderColor;
  Color? backgroundColor;
  double? borderWidth;

  @override
  State<CustomNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: CachedNetworkImage(
        imageUrl: widget.imagePath,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            // boxShadow: [
            //   if (widget.borderRadius != null)
            //     const BoxShadow(
            //       color: AppColors.white,
            //       spreadRadius: 0.0,
            //       blurRadius: 2,
            //     ),
            // ],
            shape: widget.borderRadius == -1
                ? BoxShape.circle
                : BoxShape.rectangle,
            // border: Border.all(
            //   color: widget.borderColor ?? AppColors.white,
            //   width: widget.borderWidth ?? 0,
            // ),
            borderRadius: widget.borderRadius == -1
                ? null
                : BorderRadius.circular(widget.borderRadius ?? kBorderRadius),
            image: DecorationImage(
              image: imageProvider,
              fit: widget.boxFit ?? BoxFit.contain,
            ),
          ),
        ),
        placeholder: (context, url) => SizedBox(
          height: widget.height,
          child: SkeletonAvatar(
            style: SkeletonAvatarStyle(
              shape: widget.borderRadius == -1
                  ? BoxShape.circle
                  : BoxShape.rectangle,
              borderRadius: widget.borderRadius == -1
                  ? null
                  : BorderRadius.circular(widget.borderRadius ?? kBorderRadius),
              width: double.infinity,
              height: widget.height,
            ),
          ),
        ),
        errorWidget: (context, url, error) =>
            const Icon(Icons.error_outline_rounded),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomNetworkImageWithoutHeight extends StatelessWidget {
  CustomNetworkImageWithoutHeight({
    Key? key,
    required this.imageUrl,
    this.borderRadius,
    this.boxFit,
  }) : super(key: key);

  String imageUrl;
  double? borderRadius = 0;
  BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          // shape:
          //     widget.borderRadius == -1 ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          image: DecorationImage(
            image: imageProvider,
            fit: boxFit ?? BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) {
        return Container(
          color: AppColors.greyBackground,
        );
      },
      // placeholder: (context, url) {
      //   return FittedBox(
      //     fit: boxFit ?? BoxFit.fill,
      //     child: const SkeletonAvatar(),
      //   );
      // },
    );
  }
}
