import 'package:flutter/material.dart';
import 'package:platy/features/calculation/calculation_global.dart';
import 'package:platy/features/calculation/custom_list_tile.dart';
import 'package:platy/features/calculation/theme.dart';

class CalculateMedicamentsQAWidget extends StatefulWidget {
  const CalculateMedicamentsQAWidget({Key? key}) : super(key: key);

  @override
  _CalculateMedicamentsQAWidgetState createState() =>
      _CalculateMedicamentsQAWidgetState();
}

class _CalculateMedicamentsQAWidgetState
    extends State<CalculateMedicamentsQAWidget> {
  List<String> titles = [
    'Yes',
    'No',
  ];
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 63),
        Text(
          'Medicaments',
          textAlign: TextAlign.center,
          style: whiteTheme.textTheme.bodyMedium,
        ),
        const Text(
          'Do you take any medications regularly?',
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: ListView.builder(
            itemCount: titles.length,
            itemBuilder: (context, index) {
              return CustomListTile(
                title: titles[index],
                isChecked: _selectedIndex == index,
                onTilePressed: (isChecked) {
                  setState(() {
                    if (isChecked) {
                      _selectedIndex = index;
                      if (titles[index] == "Yes") {
                        CalculateGlobalWidget.of(context)
                            .userModelBuilder
                            .is_medicaments = true;
                      } else {
                        CalculateGlobalWidget.of(context)
                            .userModelBuilder
                            .is_medicaments = false;
                      }
                      CalculateGlobalWidget.of(context).setButtonActivity(true);
                    } else {
                      _selectedIndex = null;
                      CalculateGlobalWidget.of(context)
                          .setButtonActivity(false);
                    }
                  });
                },
              );
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
