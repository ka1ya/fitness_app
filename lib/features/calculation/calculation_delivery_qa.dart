import 'package:flutter/material.dart';
import 'package:platy/features/calculation/calculation_global.dart';
import 'package:platy/features/calculation/custom_list_tile.dart';
import 'package:platy/features/calculation/theme.dart';

class CalculateDeliveryQAWidget extends StatefulWidget {
  const CalculateDeliveryQAWidget({Key? key}) : super(key: key);

  @override
  _CalculateDeliveryQAWidgetState createState() =>
      _CalculateDeliveryQAWidgetState();
}

class _CalculateDeliveryQAWidgetState extends State<CalculateDeliveryQAWidget> {
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
          'Do you plan to use delivery services this week?',
          textAlign: TextAlign.center,
          style: whiteTheme.textTheme.bodyMedium,
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
                            .is_delivery = true;
                      } else {
                        CalculateGlobalWidget.of(context)
                            .userModelBuilder
                            .is_delivery = false;
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
