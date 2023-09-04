import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IconBtnWithCounter extends StatelessWidget {
  IconBtnWithCounter({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.press,
    this.isSmall,
    this.numOfitem = 0,
  }) : super(key: key);

  final Widget icon;
  Color iconColor;
  Color backgroundColor;
  final int numOfitem;
  final GestureTapCallback press;
  bool? isSmall = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: press,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
                // padding: EdgeInsets.all(5),
                height: isSmall == true ? 30 : 40,
                width: isSmall == true ? 30 : 40,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: icon
                //  Icon(
                //   icon,
                //   color: iconColor,
                //   size: isSmall == true ? 20 : 25,
                // ),
                ),
            if (numOfitem != 0)
              Positioned(
                top: 3,
                right: 0,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF4848),
                    shape: BoxShape.circle,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
