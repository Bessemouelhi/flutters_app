import 'package:bmi_calculator/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'icon_card.dart';

const bottomHeight = 60.0;
const bottomColor = Colors.red;
const activeCardColor = 0xFF1D1E33;
const inactiveCardColor = 0xFF111328;
const iconCardMale = FontAwesomeIcons.mars;
const iconCardFemale = FontAwesomeIcons.venus;

enum Gender { male, female }

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    child: ReusableCard(
                      color: Color(selectedGender == Gender.male
                          ? activeCardColor
                          : inactiveCardColor),
                      childCard: IconCard(
                        iconData: iconCardMale,
                        label: 'MALE',
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () => {
                    setState(() {
                      selectedGender = Gender.female;
                    })
                  },
                  child: ReusableCard(
                    color: Color(selectedGender == Gender.female
                        ? activeCardColor
                        : inactiveCardColor),
                    childCard: IconCard(
                      iconData: iconCardFemale,
                      label: 'FEMALE',
                    ),
                  ),
                )),
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(color: Color(activeCardColor)),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: ReusableCard(
                  color: Color(activeCardColor),
                )),
                Expanded(
                    child: ReusableCard(
                  color: Color(activeCardColor),
                )),
              ],
            ),
          ),
          Container(
            color: bottomColor,
            margin: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            height: bottomHeight,
          )
        ],
      ),
    );
  }
}
