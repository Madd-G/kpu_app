import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpu_app/controllers/gender_controller.dart';

class GenderButton extends StatelessWidget {
  const GenderButton({
    Key? key,
    required this.index,
    required this.title,
  }) : super(key: key);
  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final controller = Get.put(GenderController());

    return GestureDetector(
      onTap: () {
        controller.selectedGender.value = index;
      },
      child: Obx(
        () => Container(
          height: 40.0,
          width: size.width * 0.4,
          decoration: BoxDecoration(
            color: (controller.selectedGender.value == index)
                ? Colors.black38
                : const Color(0xffD9D9D9),
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
