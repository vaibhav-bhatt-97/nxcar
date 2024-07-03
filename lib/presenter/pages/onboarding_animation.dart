import 'package:flutter/material.dart';
import 'package:nxcar/constants/nx_colors.dart';

class OnBoardingAnimation extends StatefulWidget {
  const OnBoardingAnimation({super.key, required this.currentIndex});
  final int currentIndex;

  @override
  State<OnBoardingAnimation> createState() => _OnBoardingAnimationState();
}

class _OnBoardingAnimationState extends State<OnBoardingAnimation> {
  late double deviceHeight;
  late double deviceWidth;
  int animationDuration = 500;
  Curve animationStyle = Curves.decelerate;
  late List<Map<String, dynamic>> coordinates;
  late int currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    currentIndex = widget.currentIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OnBoardingAnimation oldWidget) {
    // TODO: implement didUpdateWidget
    currentIndex = widget.currentIndex;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    deviceHeight = MediaQuery.of(context).size.height * 1;
    deviceWidth = MediaQuery.of(context).size.width * 1;
    print("$deviceWidth <-> $deviceHeight");
    coordinates = [
      //0th index
      {
        "2": {
          "top": deviceHeight * .25,
          "bottom": null,
          "left": deviceWidth * .38,
          "right": null
        },
        "3": {"top": null, "bottom": 35, "left": null, "right": 16},
        "4": {"top": 90, "bottom": null, "left": 10, "right": null},
        "5": {"top": null, "bottom": 70, "left": 10, "right": null},
        "6": {"top": 15, "bottom": null, "left": null, "right": 15},
      },
      //1st index
      {
        "2": {
          "top": deviceHeight * .44,
          "bottom": null,
          "left": 10,
          "right": null
        },
        "3": {
          "top": null,
          "bottom": deviceHeight * .27,
          "left": null,
          "right": deviceWidth * .35,
        },
        "4": {"top": 90, "bottom": null, "left": 10, "right": null},
        "5": {
          "top": null,
          "bottom": 35,
          "left": deviceWidth * .58,
          "right": null
        },
        "6": {"top": 15, "bottom": null, "left": null, "right": 15},
      },
      //2nd index
      {
        "2": {
          "top": deviceHeight * .48,
          "bottom": null,
          "left": deviceWidth * .6,
          "right": null
        },
        "3": {
          "top": null,
          "bottom": deviceHeight * .27,
          "left": null,
          "right": deviceWidth * .35,
        },
        "4": {
          "top": deviceHeight * .44,
          "bottom": null,
          "left": 10,
          "right": null
        },
        "5": {
          "top": null,
          "bottom": deviceHeight * .48,
          "left": deviceWidth * .58,
          "right": null
        },
        "6": {
          "top": 90,
          "bottom": null,
          "left": null,
          "right": deviceWidth * .58
        },
      },
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: NXColors.background,
      child: Stack(
        children: [
          Positioned(
            child: Image.asset(
              "lib/assets/images/1.png",
              width: MediaQuery.of(context).size.width * 1.4,
              height: MediaQuery.of(context).size.height * .64,
            ),
          ),
          AnimatedPositioned(
              curve: animationStyle,
              height: 108,
              width: 108,
              top: coordinates[currentIndex]["2"]["top"],
              bottom: coordinates[currentIndex]["2"]["bottom"],
              left: coordinates[currentIndex]["2"]["left"],
              right: coordinates[currentIndex]["2"]["right"],
              duration: Duration(milliseconds: animationDuration),
              child: Image.asset(
                "lib/assets/images/2.png",
                height: 100,
                width: 117,
              )),
          AnimatedPositioned(
              curve: animationStyle,
              height: 108,
              width: 108,
              top: coordinates[currentIndex]["3"]["top"],
              bottom: coordinates[currentIndex]["3"]["bottom"],
              left: coordinates[currentIndex]["3"]["left"],
              right: coordinates[currentIndex]["3"]["right"],
              duration: Duration(milliseconds: animationDuration),
              child: Image.asset(
                "lib/assets/images/3.png",
                height: 115,
                width: 161,
              )),
          AnimatedPositioned(
            curve: animationStyle,
            top: coordinates[currentIndex]["4"]["top"],
            bottom: coordinates[currentIndex]["4"]["bottom"],
            left: coordinates[currentIndex]["4"]["left"],
            right: coordinates[currentIndex]["4"]["right"],
            duration: Duration(milliseconds: animationDuration),
            child: Image.asset(
              "lib/assets/images/4.png",
              height: 100,
              width: 117,
            ),
          ),
          AnimatedPositioned(
              curve: animationStyle,
              height: 77,
              width: 150,
              top: coordinates[currentIndex]["5"]["top"],
              bottom: coordinates[currentIndex]["5"]["bottom"],
              left: coordinates[currentIndex]["5"]["left"],
              right: coordinates[currentIndex]["5"]["right"],
              duration: Duration(milliseconds: animationDuration),
              child: Image.asset(
                "lib/assets/images/5.png",
                height: 100,
                width: 117,
              )),
          AnimatedPositioned(
              curve: animationStyle,
              height: 100,
              width: 120,
              top: coordinates[currentIndex]["6"]["top"],
              bottom: coordinates[currentIndex]["6"]["bottom"],
              left: coordinates[currentIndex]["6"]["left"],
              right: coordinates[currentIndex]["6"]["right"],
              duration: Duration(milliseconds: animationDuration),
              child: Image.asset(
                "lib/assets/images/6.png",
                height: 100,
                width: 117,
              )),
        ],
      ),
    );
  }
}
