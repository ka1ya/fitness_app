import 'package:flutter/material.dart';
import 'package:platy/features/calculation/calculation_global.dart';

class CalculateHealthStatusSecondWidget extends StatefulWidget {
  const CalculateHealthStatusSecondWidget({super.key});

  @override
  State<CalculateHealthStatusSecondWidget> createState() =>
      _CalculateHealthStatusSecondWidgetState();
}

class _CalculateHealthStatusSecondWidgetState
    extends State<CalculateHealthStatusSecondWidget> {
  bool buttonPH1Selected = false; //PH
  bool buttonPH2Selected = false;
  bool buttonPH3Selected = false;

  bool buttonElectrolyte1Selected = false; //Electrolyte
  bool buttonElectrolyte2Selected = false;
  void checkToNext() {
    if ((buttonPH1Selected || buttonPH2Selected || buttonPH3Selected) &&
        (buttonElectrolyte1Selected || buttonElectrolyte2Selected)) {
      CalculateGlobalWidget.of(context).setButtonActivity(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 63),
        const Center(
          child: Column(
            children: [
              Text(
                'Health status',
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Add information from your last vitamin check-up',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'pH Levels',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              width: 0.29,
              label: 'Acidic',
              isSelected: buttonPH1Selected,
              onPressed: () {
                CalculateGlobalWidget.of(context).userModelBuilder.ph_level =
                    'Acidic';
                setState(() {
                  buttonPH1Selected = true;
                  buttonPH2Selected = false;
                  buttonPH3Selected = false;
                  checkToNext();
                });
              },
            ),
            CustomButton(
              width: 0.29,
              label: 'Neutral',
              isSelected: buttonPH2Selected,
              onPressed: () {
                CalculateGlobalWidget.of(context).userModelBuilder.ph_level =
                    'Neutral';
                setState(() {
                  buttonPH1Selected = false;
                  buttonPH2Selected = true;
                  buttonPH3Selected = false;
                  checkToNext();
                });
              },
            ),
            CustomButton(
              width: 0.29,
              label: 'Alkaline',
              isSelected: buttonPH3Selected,
              onPressed: () {
                CalculateGlobalWidget.of(context).userModelBuilder.ph_level =
                    'Alkaline';
                setState(() {
                  buttonPH1Selected = false;
                  buttonPH2Selected = false;
                  buttonPH3Selected = true;
                  checkToNext();
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Electrolyte Balance',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              width: 0.44,
              label: 'Balanced',
              isSelected: buttonElectrolyte1Selected,
              onPressed: () {
                CalculateGlobalWidget.of(context)
                    .userModelBuilder
                    .electrolyte_balance = 'Balanced';
                setState(() {
                  buttonElectrolyte1Selected = true;
                  buttonElectrolyte2Selected = false;
                  checkToNext();
                });
              },
            ),
            CustomButton(
              width: 0.44,
              label: 'Imbalanced',
              isSelected: buttonElectrolyte2Selected,
              onPressed: () {
                CalculateGlobalWidget.of(context)
                    .userModelBuilder
                    .electrolyte_balance = 'Imbalanced';
                setState(() {
                  buttonElectrolyte1Selected = false;
                  buttonElectrolyte2Selected = true;
                  checkToNext();
                });
              },
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final double width;
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const CustomButton({
    required this.width,
    required this.label,
    required this.isSelected,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 52,
        width: MediaQuery.of(context).size.width * width,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color:
              isSelected ? const Color.fromRGBO(252, 108, 76, 1) : Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.09),
              offset: Offset(1, 3),
              blurRadius: 9,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
