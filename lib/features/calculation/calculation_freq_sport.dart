import 'package:flutter/material.dart';
import 'package:platy/features/calculation/calculation_global.dart';
import 'package:platy/features/calculation/custom_list_tile.dart';
import 'package:platy/features/calculation/theme.dart';

class CalculateFreqSportWidget extends StatefulWidget {
  const CalculateFreqSportWidget({Key? key}) : super(key: key);

  @override
  _CalculateFreqSportWidgetState createState() =>
      _CalculateFreqSportWidgetState();
}

class _CalculateFreqSportWidgetState extends State<CalculateFreqSportWidget> {
  List<String> titles = [
    'Every Day',
    '5-6 Times a Week',
    '3-4 Times a Week',
    '2 Times a Week',
    '2-3 Times a Month',
    'Once a Month',
    'Occasionally',
    'Rarely'
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
          'How frequently do you do sports?',
          textAlign: TextAlign.center,
          style: whiteTheme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
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
                      CalculateGlobalWidget.of(context)
                          .userModelBuilder
                          .activities_frequency = titles[index];
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
      ],
    );
  }
}
