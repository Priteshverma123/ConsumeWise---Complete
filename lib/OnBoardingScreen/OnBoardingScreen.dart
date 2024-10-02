import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttercuredoc/LogSign/Welcome.dart';
import 'package:fluttercuredoc/OnBoardingScreen/OnBOardingSize.dart';
import 'package:fluttercuredoc/OnBoardingScreen/OnBoardingContent.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;
  List colors = const [
    Color(0xffDAD3C8),
    Color(0xffFFE5DE),
    Color(0xffDCF6E6),
  ];

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: Color(0xFF000000),
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 30 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;

    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: contents.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: SizeConfig.blockV! * 45,
                        ),
                        SizedBox(
                          height: (height >= 840) ? 10 : 0,
                        ),
                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w800,
                            fontSize: (width <= 550) ? 35 : 40,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          contents[i].desc,
                          style: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w300,
                            fontSize: (width <= 550) ? 17 : 25,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                          (int index) => _buildDots(
                        index: index,
                      ),
                    ),
                  ),
                  _currentPage + 1 == contents.length
                      ? Padding(
                    padding: const EdgeInsets.all(30),
                    child: ElevatedButton(
                      onPressed: () async{
                        final pres = await SharedPreferences.getInstance();
                        pres.setBool('onboarding', true);
                        Get.off(WelcomeScreen());
                      },
                      child: const Text("START"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: (width <= 550)
                            ? const EdgeInsets.symmetric(
                            horizontal: 110, vertical: 20)
                            : EdgeInsets.symmetric(
                            horizontal: width * 0.2, vertical: 25),
                        textStyle:
                        TextStyle(fontSize: (width <= 550) ? 19 : 17 ,fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _controller.jumpToPage(2);
                          },
                          child: const Text(
                            "SKIP",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(color: Colors.black),
                            ),
                            elevation: 0,
                            padding: (width <= 550)
                                ? const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15)
                                : const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 25),
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: (width <= 550) ? 17 : 17,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                            );
                          },
                          child: const Text("NEXT"),
                          style: ElevatedButton.styleFrom(

                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            elevation: 4,
                            padding: (width <= 550)
                                ? const EdgeInsets.symmetric(
                                horizontal:30, vertical: 15)
                                : const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 25),
                            textStyle: TextStyle(
                                fontSize: (width <= 550) ? 17 : 17),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}