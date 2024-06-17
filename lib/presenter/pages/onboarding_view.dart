import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nxcar/constants/nx_colors.dart';
import 'package:nxcar/data/models/onboarding_content.dart';
import 'package:nxcar/presenter/pages/signup_view.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late PageController _controller;
  late Timer _timer;
  List<OnBoardingContent> contentList = [
    OnBoardingContent(
        title: "Buy a Pre Owned Car with Confidence",
        image: "lib/assets/images/Welcome Screen 1.png"),
    OnBoardingContent(
        title: "Rev Up Your Dreams With Our Used Car Loans",
        image: "lib/assets/images/Welcome Screen 2.png"),
    OnBoardingContent(
        title: "Simplified Used Car With Financing With Nxcar",
        image: "lib/assets/images/Welcome Screen 3.png"),
  ];
  int currentIndex = 0;

  @override
  void initState() {
    _controller = PageController(initialPage: 0); // Initialize PageController with the initial page
    _startAutoScroll(); // Start automatic scrolling
    super.initState();
  }

  // Function to start automatic scrolling
  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_controller.hasClients) {
        final nextPage = (_controller.page!.toInt() + 1) % contentList.length;
        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the PageController
    _timer.cancel(); // Cancel the timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NXColors.background,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: PageView.builder(
                controller: _controller,
                physics: const BouncingScrollPhysics(), // Bouncy scroll physics
                itemCount: contentList.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index; // Update currentIndex when the page changes
                  });
                },
                itemBuilder: (_, index) => Column(
                  children: [
                    Image.asset(
                      contentList[index].image!,
                      height: MediaQuery.of(context).size.height * .63,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      contentList[index].title!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 35),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: List.generate(
                      contentList.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 240),
                        height: 12,
                        width: currentIndex == index ? 40 : 12, // Animate width change based on currentIndex
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? NXColors.primary
                              : NXColors.disabled, // Change color based on currentIndex
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    print("Go to next screen");
                    _timer.cancel(); // Cancel the timer before navigating
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SignUpView(),
                      ),
                    ).then((value) {
                      if (value == null) {
                        _startAutoScroll(); // Restart auto scroll when coming back from the next screen
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: NXColors.primary,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white, // Icon color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
