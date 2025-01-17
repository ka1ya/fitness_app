import 'package:flutter/material.dart';
import 'package:platy/features/calculation/calculation_global.dart';
import 'package:platy/features/calculation/theme.dart';

class CalculateMedicamentsWidget extends StatefulWidget {
  const CalculateMedicamentsWidget({Key? key}) : super(key: key);

  @override
  _CalculateMedicamentsWidgetState createState() =>
      _CalculateMedicamentsWidgetState();
}

class _CalculateMedicamentsWidgetState
    extends State<CalculateMedicamentsWidget> {
  TextEditingController? controllerTextField;
  List<String> medicamentsArray = [];
  @override
  void initState() {
    super.initState();
    controllerTextField = TextEditingController();
    controllerTextField!.addListener(_onTextFieldChanged);
  }

  @override
  void dispose() {
    controllerTextField!.dispose();
    super.dispose();
  }

  void _onTextFieldChanged() {
    setState(() {
      if (controllerTextField!.text.isNotEmpty) {
        medicamentsArray = controllerTextField!.text.split(',');
        CalculateGlobalWidget.of(context).userModelBuilder.medicaments =
            medicamentsArray;
        CalculateGlobalWidget.of(context).setButtonActivity(true);
      } else {
        CalculateGlobalWidget.of(context).setButtonActivity(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 63),
        Text(
          'Medicaments',
          textAlign: TextAlign.center,
          style: whiteTheme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 10),
        const Text(
          'Choose the ones below',
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 30),
        Container(
          height: 140,
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
            controller: controllerTextField,
            decoration: InputDecoration(
              hintText: ' Please write down the name of the medicine',
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
        const Spacer(),
      ],
    );
  }
}
