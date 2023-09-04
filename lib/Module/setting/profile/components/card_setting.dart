import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../../utils/values.dart';
import '../../../../helper/storage_helper.dart';

// ignore: must_be_immutable
class ListCard extends StatelessWidget {
  ListCard({
    Key? key,
    required this.context,
    required this.icon,
    required this.text,
    required this.onTap,
    required this.trailingText,
  }) : super(key: key);

  final BuildContext context;
  final Widget icon;
  final String text;
  final Function() onTap;
  String trailingText;

  @override
  Widget build(BuildContext context) {
    return Material(
      // padding: const EdgeInsets.only(bottom: kPadding),
      color: Colors.white,
      borderRadius: BorderRadius.circular(kBorderRadius),
      child: Container(
        color: Colors.transparent,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          onTap: onTap,
          focusColor: AppColors.primaryColor.withOpacity(.1),
          hoverColor: AppColors.primaryColor.withOpacity(.1),
          minLeadingWidth: 30,
          leading: Container(
            child: icon,
          ),
          title: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              trailingText.isNotEmpty ? Text(trailingText) : Container(),
              Icon(
                StorageService.getcurrentLanguage() == "en"
                    ? EvaIcons.chevronRight
                    : EvaIcons.chevronLeft,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
