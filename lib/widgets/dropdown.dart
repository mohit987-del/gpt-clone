import 'package:cxw7/constants/colors.dart';
import 'package:cxw7/providers/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDown extends StatefulWidget {
  const DropDown({super.key});

  @override
  State<DropDown> createState() => _DropDownState();
}
class _DropDownState extends State<DropDown> {
  String? current;
  //List<DropdownMenuItem> data = [];
  @override
  Widget build(BuildContext context) {
    final mod = Provider.of<ModelsProvider>(context);
    current = mod.getCurrent;
    return FutureBuilder(
      future: mod.getAllModels(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        }
        return snapshot.data == null || snapshot.data!.isEmpty
            ? const SizedBox.shrink()
            : FittedBox(
                child: DropdownButton(
                  //hint: Text("Select model"),
                  dropdownColor: scaffoldBackgroundColor,
                  iconEnabledColor: Colors.white,
                  items: List<DropdownMenuItem<String>>.generate(
                    snapshot.data!.length,
                    (index) => DropdownMenuItem(
                      value: snapshot.data![index].toString(),
                      child: Text(
                        snapshot.data![index].toString().trim(),
                        style: const TextStyle(
                            overflow: TextOverflow.clip, color: Colors.white),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      current = value.toString();
                    });
                    mod.setCurrent(value.toString());
                  },
                  value: current,
                ),
              );
      },
    );
  }
}
