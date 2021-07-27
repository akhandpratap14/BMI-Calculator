import 'package:bmi/results_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'iconContent.dart';
import 'ReusableCard.dart';
import 'constant.dart';
import 'results_page.dart';
import 'brain.dart';

enum Gender { Male, Female }

class appFuntion extends StatefulWidget {
  @override
  _appFuntionState createState() => _appFuntionState();
}

class _appFuntionState extends State<appFuntion> {
  var selectedGender;
  int height = 180;
  int weight = 75;
  int age = 19;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Calcuate BMI',
            style: TextStyle(
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    colour: selectedGender == Gender.Male
                        ? kactiveCardColor
                        : kInactiveCardColor,
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.Male;
                      });
                    },
                    cardChild:
                        iconContent(icon: FontAwesomeIcons.mars, label: 'Male'),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: selectedGender == Gender.Female
                        ? kactiveCardColor
                        : kInactiveCardColor,
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.Female;
                      });
                    },
                    cardChild: iconContent(
                      icon: FontAwesomeIcons.venus,
                      label: 'Female',
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
                colour: kactiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Height',
                      style: klabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(height.toString(), style: kHeightTextStyle),
                        Text(
                          'cm',
                          style: klabelTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.white,
                          thumbColor: Color(0xFFEb1555),
                          overlayColor: Color(0x15EB1555),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 10.0),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 17.0)),
                      child: Slider(
                          value: height.toDouble(),
                          min: 120.0,
                          max: 220.0,
                          activeColor: Color(0xFFEB1555),
                          inactiveColor: Color(0xFF8D8E98),
                          onChanged: (double newValue) {
                            setState(() {
                              height = newValue.round();
                            });
                          }),
                    )
                  ],
                )),
          ),
          Expanded(
            child: Row(children: <Widget>[
              Expanded(
                child: ReusableCard(
                  colour: kactiveCardColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Weight',
                        style: klabelTextStyle,
                      ),
                      Text(
                        weight.toString(),
                        style: kHeightTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AppButton(
                            icon: FontAwesomeIcons.minus,
                            onPressed: () {
                              setState(() {
                                weight--;
                              });
                            },
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          AppButton(
                            icon: FontAwesomeIcons.plus,
                            onPressed: () {
                              setState(() {
                                weight++;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ReusableCard(
                  colour: kactiveCardColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Age',
                        style: klabelTextStyle,
                      ),
                      Text(
                        age.toString(),
                        style: kHeightTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AppButton(
                            icon: FontAwesomeIcons.minus,
                            onPressed: () {
                              setState(() {
                                age--;
                              });
                            },
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          AppButton(
                            icon: FontAwesomeIcons.plus,
                            onPressed: () {
                              setState(() {
                                age++;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
          BottomWidget(
            buttonTittle: 'Calculate',
            onTap: () {
              BmiCalculator cal = BmiCalculator(height: height, weight: weight);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsPage(
                    bmiResult: cal.calBmi(),
                    resultText: cal.getResult(),
                    interpretationText: cal.getInterpretation(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BottomWidget extends StatelessWidget {
  BottomWidget({required this.buttonTittle, required this.onTap});

  final onTap;
  final buttonTittle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(17.0),
        height: kbottomContainerHeight,
        width: double.infinity,
        child: Center(
          child: Text(
            buttonTittle,
            style: TextStyle(fontFamily: 'Roboto', fontSize: 25.0),
          ),
        ),
        decoration: BoxDecoration(
          color: kbottomContainerColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  AppButton({required this.icon, required this.onPressed});
  final IconData icon;
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
      constraints: BoxConstraints.tightFor(width: 51.6, height: 51.6),
      elevation: 6.0,
      onPressed: onPressed,
    );
  }
}
