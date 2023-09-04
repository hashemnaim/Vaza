import 'package:faza_app/utils/values.dart';
import 'package:faza_app/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

class CardCategoryHome extends StatelessWidget {
  const CardCategoryHome({
    super.key,
    required this.image,
    required this.title,
  });

  final String image, title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 126,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: CustomNetworkImage(
                imagePath: image,
                height: 100,
                width: 110,
                backgroundColor: Colors.white,
                borderRadius: 12,
                boxFit: BoxFit.fill),
          ),
          const SpaceH4(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(title,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 16)),
          ),
        ]),
      ),
    );
  }
}
