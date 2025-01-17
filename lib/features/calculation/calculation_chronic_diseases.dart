import 'package:flutter/material.dart';
import 'package:platy/features/calculation/calculation_global.dart';
import 'package:platy/features/calculation/custom_list_tile.dart';
import 'package:platy/features/calculation/theme.dart';

class CalculateChronicDiseasesListWidget extends StatefulWidget {
  const CalculateChronicDiseasesListWidget({Key? key}) : super(key: key);

  @override
  _CalculateChronicDiseasesListWidgetState createState() =>
      _CalculateChronicDiseasesListWidgetState();
}

class _CalculateChronicDiseasesListWidgetState
    extends State<CalculateChronicDiseasesListWidget> {
  List<String> titles = [
    'Diabetes',
    'Cardiovascular diseases',
    'Food allergies',
    'Gastrointestinal disorders',
    'Autoimmune conditions',
  ];
  List<bool> _isCheckedList = [];
  List<String> choosedTitles = [];
  TextEditingController? controllerTextField;
  List<String> diseasesArray = [];

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
        diseasesArray = controllerTextField!.text.split(',');
        choosedTitles.addAll(diseasesArray);
        CalculateGlobalWidget.of(context).setButtonActivity(true);
        CalculateGlobalWidget.of(context).userModelBuilder.chronic_diseases =
            choosedTitles;
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
          'Chronic Diseases',
          textAlign: TextAlign.center,
          style: whiteTheme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 10),
        const Text(
          'If you are not allergic, skip this step.',
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
                        .chronic_diseases = choosedTitles;
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
