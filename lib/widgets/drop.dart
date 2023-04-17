import 'package:cxw7/constants/colors.dart';
import 'package:cxw7/widgets/widgets.dart';
import 'package:flutter/material.dart';
class ShowModal {
  static Future<void> showModal(BuildContext context) async {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Choose model : "),
              DropDown(),
            ],
          ),
        );
      },
    );
  }
}
