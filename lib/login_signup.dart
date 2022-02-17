import 'package:flutter/material.dart';
import 'package:inventory/admin/login/view/login_screen.dart';
import 'package:inventory/admin/login/components/login_form.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'top_bar.dart';
final pages = [
  Scaffold(
    backgroundColor: Colors.red.shade50,
    body: Stack(
      children: [
        TopBar(Colors.red,Colors.red.shade300,Colors.red.shade100),
        Column(
          children: [
            SizedBox(height: 55,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Inventory App',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 40),),
            ),
            SizedBox(height: 50,),
            Lottie.network('https://assets2.lottiefiles.com/packages/lf20_zf9mqyhk.json'),
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Lottie.network('https://assets10.lottiefiles.com/packages/lf20_zmKJtL.json',width: 60),
              ],
            ),
          ],
        )
      ],
    )
  ),
  Scaffold(
    backgroundColor: Colors.black,
    body: TopBar(Colors.blueAccent,Colors.blueAccent.shade100,Colors.blueAccent.withOpacity(0.5)),
  ),
  Scaffold(
    backgroundColor: Colors.lightGreen.shade50,
    body: Stack(
      children: [
        TopBar(Colors.lightGreen,Colors.lightGreenAccent.shade200,Colors.lightGreenAccent.withOpacity(0.5)),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 400,
              child: LoginForm(),
            )
          ],
        )
      ],
    )
  ),
  LoginScreen(),

];

class toggler extends StatefulWidget {
  const toggler({Key? key}) : super(key: key);

  @override
  _togglerState createState() => _togglerState();
}

class _togglerState extends State<toggler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(pages: pages),
    );
  }
}
