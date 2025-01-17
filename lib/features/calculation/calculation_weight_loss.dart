import 'package:flutter/material.dart';
import 'package:platy/features/calculation/calculation_global.dart';
import 'package:platy/features/calculation/custom_list_tile.dart';
import 'package:platy/features/calculation/theme.dart';

class CalculateWeightLossWidget extends StatefulWidget {
  const CalculateWeightLossWidget({super.key});

  @override
  State<CalculateWeightLossWidget> createState() =>
      _CalculateWeightLossWidgetState();
}

class _CalculateWeightLossWidgetState extends State<CalculateWeightLossWidget> {
  List<String> titles = [
    'Weight Management',
    'Fat Burning',
    'Weight Loss and Muscle \nPreservation',
    'Satiety and Digestive Health',
  ];
  List<bool> _isCheckedList = [];
  List<String> choosedTitles = [];
  @override
  void initState() {
    super.initState();
    _isCheckedList = List.generate(titles.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 63),
          Text(
            'Weight loss',
            textAlign: TextAlign.center,
            style: whiteTheme.textTheme.bodyMedium,
          ),
          const Text(
            'Select a target',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: titles.length,
              itemBuilder: (context, index) {
                return CustomListTile(
                  title: titles[index],
                  isChecked: _isCheckedList[index],
                  onTilePressed: (isChecked) {
                    setState(() {
                      choosedTitles.add(titles[index]);
                      _isCheckedList[index] = isChecked;
                      CalculateGlobalWidget.of(context)
                          .userModelBuilder
                          .weight_goals = choosedTitles;
                      CalculateGlobalWidget.of(context)
                          .setButtonActivity(_isCheckedList.contains(true));
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
