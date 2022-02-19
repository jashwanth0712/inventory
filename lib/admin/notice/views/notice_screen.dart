import 'package:flutter/material.dart';
import 'package:inventory_repository/inventory_repository.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  Admin admin = Admin();
  bool initialised = false;
  var products;
  @override
  void initState() {
    super.initState();
    initialise();
  }

  void initialise() async {
    admin = await admin.getToken();
    try {
      products = await admin.product.getAll();
      setState(() {
        initialised = true;
      });
    } on APIRequestError catch (error) {
      print(error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() => {}),
        child: const Icon(
          Icons.add_rounded,
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: 20,
              left: 20,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ListView(
                  children: const [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Notices",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
