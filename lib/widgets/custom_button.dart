import 'package:faza_app/utils/values.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomPrimaryButton extends StatelessWidget {
  CustomPrimaryButton({
    Key? key,
    required this.text,
    required this.onPress,
    required this.color,
    this.isOutlined = false,
    this.isDisabled = false,
    this.icon,
    required this.textColor,
    this.borderRadius,
    this.isSmallText = false,
  }) : super(key: key);

  String text;
  VoidCallback onPress;
  Color color;
  Color textColor;
  BorderRadiusGeometry? borderRadius;
  bool? isOutlined;
  bool? isDisabled;
  Widget? icon;
  bool? isSmallText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: widthOfScreen(context),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: borderRadius ??
                  BorderRadius.circular(
                    kBorderRadius,
                  ),
              side: BorderSide(
                color: isDisabled == true ? AppColors.grey : color,
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            isDisabled == true
                ? AppColors.grey
                : isOutlined != true
                    ? color
                    : Colors.transparent,
          ),
          overlayColor: MaterialStateProperty.all(
            textColor.withOpacity(.1),
          ),
        ),
        onPressed: isDisabled == true ? null : onPress,
        child: icon ??
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: isSmallText == true ? 14 : 19,
              ),
            ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.style,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPress,
    this.background,
    this.enable = true,
    this.isOutlined = false,
    this.icon,
    this.borderRadius,
  }) : super(key: key);

  String text;
  Color color;
  Color? background;
  Function() onPress;
  double? borderRadius;

  bool? isOutlined;
  bool? enable;
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enable == true ? onPress : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          enable == true ? background ?? Colors.transparent : AppColors.grey50,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? kBorderRadius,
            ),
            side: BorderSide(
              color: isOutlined == true ? color : Colors.transparent,
            ),
          ),
        ),
        overlayColor: enable == true
            ? MaterialStateProperty.all(
                color.withOpacity(.1),
              )
            : MaterialStateProperty.all(
                AppColors.grey.withOpacity(.1),
              ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: enable == true ? color : AppColors.black50,
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.color,
  }) : super(key: key);

  IconData icon;
  Function() onTap;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: color ?? AppColors.primaryColor,
        borderRadius: BorderRadius.circular(kBorderRadius),
        boxShadow: [
          BoxShadow(
            blurRadius: 7,
            spreadRadius: 1,
            color: AppColors.grey.withOpacity(.5),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor:
              color?.withOpacity(.1) ?? AppColors.primaryColor.withOpacity(.1),
          highlightColor: AppColors.white.withOpacity(.1),
          borderRadius: BorderRadius.circular(kBorderRadius),
          onTap: onTap,
          child: Icon(
            icon,
            color: AppColors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
