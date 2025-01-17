import 'package:flutter/material.dart';
import 'package:platy/features/calculation/calculation_global.dart';
import 'package:platy/features/calculation/custom_list_tile.dart';
import 'package:platy/features/calculation/theme.dart';

class CalculateActivitySportListWidget extends StatefulWidget {
  const CalculateActivitySportListWidget({Key? key}) : super(key: key);

  @override
  _CalculateActivitySportListWidgetState createState() =>
      _CalculateActivitySportListWidgetState();
}

class _CalculateActivitySportListWidgetState
    extends State<CalculateActivitySportListWidget> {
  List<String> titles = [
    'Walking Outdoor',
    'Boxing / kickboxing',
    'Circuit training',
    'Crossfit',
    'Cycling',
    'Dance',
    'Gym classes',
    'Gymnastics',
    'Interval training',
    'Martial arts',
    'Running',
    'Triathlete',
    'Swimming',
    'Personal training',
    'Pilates',
    'Pole fitness',
    'Rock climbing',
    'Sports',
    'Tai chi',
    'Weight training',
    'Yoga',
  ];
  List<bool> _isCheckedList = [];
  List<String> choosedTitles = [];
  TextEditingController? controllerTextField;
  List<String> sportsArray = [];

  @override
  void initState() {
    super.initState();
    controllerTextField = TextEditingController();
    controllerTextField!.addListener(_onTextFieldChanged);
    _isCheckedList = List.generate(titles.length, (index) => false);
  }

  void _onTextFieldChanged() {
    setState(() {
      if (controllerTextField!.text.isNotEmpty) {
        sportsArray = controllerTextField!.text.split(',');
        choosedTitles.addAll(sportsArray);
        CalculateGlobalWidget.of(context).userModelBuilder.activities =
            choosedTitles;
        CalculateGlobalWidget.of(context).setButtonActivity(true);
      } else {
        CalculateGlobalWidget.of(context).setButtonActivity(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 63),
        Text(
          'Activity/Sport:',
          textAlign: TextAlign.center,
          style: whiteTheme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 10),
        const Text(
          'Which Type of the activity you do?',
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 30),
        Container(
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.09000000357627869),
                offset: Offset(1, 3),
                blurRadius: 9,
              ),
              BoxShadow(
                color: Colors.white,
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: ' Add your option separated by commas',
              hintStyle: const TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
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
                        .activities = choosedTitles;
                    CalculateGlobalWidget.of(context)
                        .setButtonActivity(_isCheckedList.contains(true));
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
