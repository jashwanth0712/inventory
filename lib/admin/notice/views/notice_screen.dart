import 'package:flutter/material.dart';
import 'package:inventory/admin/notice/components/create.dart';
import 'package:inventory/constants.dart';
import 'package:inventory/utils/show_bottom_sheet.dart';
import 'package:inventory_repository/inventory_repository.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  Admin admin = Admin();
  bool initialised = false;
  late List notices;
  @override
  void initState() {
    super.initState();
    initialise();
  }

  void initialise() async {
    admin = await admin.getToken();
    try {
      notices = (await admin.notice.getAll())['notices'];
      setState(() {
        initialised = true;
      });
    } on APIRequestError catch (error) {
      print(error.message);
    }
  }

  Widget noticesList() {
    return !initialised
        ? const CircularProgressIndicator(
            color: Colors.black,
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: notices.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: ListTile(
                  title: Text(
                    '${notices[index]['title'].substring(0, 1).toUpperCase() + notices[index]['title'].substring(1)}',
                  ),
                  subtitle: Text('${notices[index]['description']}'),
                  trailing: const Icon(
                    Icons.edit,
                  ),
                  style: ListTileStyle.drawer,
                ),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          buildBottomSheet(
            child: CreateNotice(admin: admin),
            context: context,
          );
        }),
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
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Notices",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  noticesList(),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: 20,
                  //     vertical: 5,
                  //   ),
                  //   child: ListTile(
                  //     title: Text('Notices'),
                  //     subtitle: Text('Some subtitle'),
                  //     trailing: Icon(
                  //       Icons.edit,
                  //     ),
                  //     style: ListTileStyle.drawer,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
