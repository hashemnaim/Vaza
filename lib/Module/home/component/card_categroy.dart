import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/values.dart';
import '../../../widgets/custom_network_image.dart';
import '../controller/home_controller.dart';

// ignore: must_be_immutable
class CardCategory extends StatelessWidget {
  CardCategory({super.key, required this.photo, required this.name});
  final String photo, name;

  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomNetworkImage(
              imagePath: photo, height: 125, width: 160, boxFit: BoxFit.fill),
          const SpaceH12(),
          Center(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Center(
          //       child: Container(
          //         width: StorageService.isGuestUser() == false ? 108 : 150,
          //         height: 30,
          //         decoration: BoxDecoration(
          //             color: AppColors.cardColor,
          //             borderRadius: BorderRadius.circular(8)),
          //         child: Center(
          //           child: Text('${productsList[index].price} ${"SAR".tr}',
          //               style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          //                   fontWeight: FontWeight.w500,
          //                   color: AppColors.black50)),
          //         ),
          //       ),
          //     ),
          //     const SpaceW4(),
          //     if (StorageService.isGuestUser() == false)
          //       Padding(
          //         padding: const EdgeInsets.only(right: 6),
          //         child: Container(
          //           decoration: BoxDecoration(
          //               color: AppColors.cardColor,
          //               borderRadius: BorderRadius.circular(8)),
          //           height: 32,
          //           child: Padding(
          //             padding: const EdgeInsets.all(4.0),
          //             child: LikeButton(
          //               size: 20,
          //               likeBuilder: (isLiked) {
          //                 return CustomSvgImage(
          //                   "heart",
          //                   color: productsList[index].isFavorite == false
          //                       ? Colors.black
          //                       : Colors.red,
          //                   isColor: true,
          //                 );
          //               },
          //               isLiked: productsList[index].isFavorite,
          //               onTap: (isLiked) async {
          //                 if (StorageService.isGuestUser()) {
          //                   showSnackBar(message: "You are guest user");
          //                   return isLiked;
          //                 } else {
          //                   onFavoriteClick(
          //                     favoriteId: productsList[index].id ?? 0,
          //                     favoriteType: !isLiked
          //                         ? FavoriteType.like
          //                         : FavoriteType.dislike,
          //                   );
          //                   return !isLiked;
          //                 }
          //               },
          //             ),
          //           ),
          //         ),
          //       )
          //   ],
          // )
        ]),
      ),
    );
  }
}
