import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platy/features/bloc/platy_bloc_bloc.dart';
import 'package:platy/features/mainPage/profile/profileHealth/theme.dart';

class ProfileFastingDaysWidget extends StatefulWidget {
  const ProfileFastingDaysWidget({super.key});

  @override
  State<ProfileFastingDaysWidget> createState() =>
      _ProfileFastingDaysWidgetState();
}

class _ProfileFastingDaysWidgetState extends State<ProfileFastingDaysWidget> {
  List<String> days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  List<bool> isSelected = List.generate(7, (index) => false);
  List<String> choosedTitles = [];
  bool _isButtonActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: IconButton(
            icon: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back),
                SizedBox(width: 8),
                Text('Back'),
              ],
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        leadingWidth: 90,
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Image.asset('assets/images/logo_small.png'),
      ),
      body: BlocListener<PlatyBloc, PlatyBlocState>(
        listener: (context, state) {
          if (state is ProfileIncludesDataState) {
            for (int i = 0; i < 3; i++) {
              Navigator.of(context).pop();
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 63),
              Text(
                'Indicate fasting days',
                textAlign: TextAlign.center,
                style: whiteTheme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              const Text(
                'What is your eating type?',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(days.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected[index] = !isSelected[index];
                        choosedTitles.add(days[index]);
                        _isButtonActive = true;
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: isSelected[index]
                                ? const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFFFF8064),
                                      Color(0xFFDB3D1A),
                                    ],
                                  )
                                : null,
                            color: isSelected[index]
                                ? null
                                : const Color.fromRGBO(23, 23, 23, 0.25),
                          ),
                          child: Center(
                            child: Text(
                              days[index],
                              style: TextStyle(
                                color: isSelected[index]
                                    ? Colors.white
                                    : Colors.white,
                                fontSize: 18,
                                fontFamily: 'Gilroy',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              const Spacer(),
              Container(
                height: 54.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF59A7A7),
                      Color(0xFFAFCD6D),
                    ],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: _isButtonActive
                      ? () {
                          BlocProvider.of<PlatyBloc>(context).add(
                              UpdateProfilePatchEvent(
                                  {'fasting_days': choosedTitles}));
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
