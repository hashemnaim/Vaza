// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final String value;
  final List<Item>? itemsList;
  final Color dropdownColor, hintColor;
  final String? hint;
  final Function(Item?)? onChanged;
  final double height;
  final double fontSize;
  final Color? backgroundColor, fontColor, borderColor, iconColor;

  const CustomDropDown({
    this.value = "",
    this.itemsList,
    this.hint = "",
    this.dropdownColor = Colors.white,
    this.onChanged,
    this.height = 55,
    this.fontSize = 10,
    this.backgroundColor = Colors.white,
    this.fontColor = Colors.black,
    this.borderColor = Colors.grey,
    this.hintColor = Colors.black,
    this.iconColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButton(
        underline: Container(),
        isExpanded: true,
        iconSize: 25,
        hint: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            hint!,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: hintColor, fontSize: 14, height: 1),
          ),
        ),
        style: Theme.of(context).textTheme.headlineSmall,
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.keyboard_arrow_down,
            color: iconColor,
            size: 22,
          ),
        ),
        dropdownColor: dropdownColor,
        // value: itemsList[getIndex()],
        items: itemsList!
            .map(
              (Item item) => DropdownMenuItem<Item>(
                value: item,
                child: Text(
                  item.name!,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}

class Item {
  int? id;
  String? name;

  Item({
    this.id,
    this.name,
  });

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;

    return data;
  }
}
