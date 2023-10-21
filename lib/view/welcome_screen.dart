import 'package:east_stay/widgets/button.dart';
import 'package:flutter/material.dart';

class ScreenWelcome extends StatelessWidget {
  const ScreenWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    final dheight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SizedBox(
        height: dheight,
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: dheight * 0.6,
                width: double.maxFinite,
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(left: 20, bottom: 20),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/welcome.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const Text.rich(TextSpan(children: [
                  TextSpan(
                      text: 'EAST',
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                    text: ' Stay',
                    style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  )
                ]))),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child:  const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: SizedBox()),
                  Text(
                    "Let's \nFind the best stay \naround the world ",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      height: 1.8,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  PrimaryButton(label: "Let's go")
                  
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
