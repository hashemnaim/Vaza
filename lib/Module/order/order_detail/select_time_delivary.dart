import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/values.dart';
import 'controller/order_detail_controller.dart';

class TimeFilterScreen extends StatefulWidget {
  const TimeFilterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimeFilterScreenState createState() => _TimeFilterScreenState();
}

class _TimeFilterScreenState extends State<TimeFilterScreen> {
  List<bool> isSelected = [false, false, false];
  List<String> listTime = ['PM 3 - 10 AM', 'PM 8 - 5 PM', 'AM 12 - 8 PM'];
  OrderDetailController orderDetailController = Get.find();

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: ToggleButtons(
          isSelected: isSelected,
          onPressed: (index) {
            orderDetailController.selectTime.value = listTime[index];
            setState(() {
              for (int buttonIndex = 0;
                  buttonIndex < isSelected.length;
                  buttonIndex++) {
                if (buttonIndex == index) {
                  isSelected[buttonIndex] = !isSelected[buttonIndex];
                } else {
                  isSelected[buttonIndex] = false;
                }
              }
            });
          },
          color: Colors.black,
          selectedColor: Colors.white,
          borderColor: Colors.grey,
          fillColor: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0), child: Text(listTime[0])),
            Padding(
                padding: const EdgeInsets.all(8.0), child: Text(listTime[1])),
            Padding(
                padding: const EdgeInsets.all(8.0), child: Text(listTime[2]))
          ]),
    );
  }
}
