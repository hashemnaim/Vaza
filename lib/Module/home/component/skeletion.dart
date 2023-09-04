import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../../../utils/values.dart';

Widget skeleton(BuildContext context) {
  return Column(
    children: [
      const SpaceH16(),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kPadding,
          vertical: kPadding / 3,
        ),
        child: SkeletonAvatar(
          style: SkeletonAvatarStyle(
            height: widthOfScreen(context) / 2,
            width: widthOfScreen(context),
          ),
        ),
      ),
      subCategorySkeleton(context),
    ],
  );
}

SizedBox subCategorySkeleton(BuildContext context) {
  return SizedBox(
    height: widthOfScreen(context) / 1.1,
    child: ListView.separated(
      itemCount: 7,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      separatorBuilder: (context, index) => const SpaceW12(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                height: widthOfScreen(context) / 2,
                width: widthOfScreen(context) / 3,
              ),
            ),
            const SpaceH8(),
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                height: 10,
                width: widthOfScreen(context) / 3.5,
              ),
            ),
          ],
        );
      },
    ),
  );
}

SizedBox categorySkeleton(BuildContext context) {
  return SizedBox(
      child: GridView.builder(
    itemCount: 10,
    padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
    itemBuilder: (context, index) {
      return const SizedBox(
        child: Column(
          children: [
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                height: 110,
                width: 150,
              ),
            ),
            SpaceH8(),
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                height: 10,
                width: 150,
              ),
            ),
          ],
        ),
      );
    },
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8,
        crossAxisSpacing: 4,
        crossAxisCount: 2,
        childAspectRatio: 1.1),
  ));
}
