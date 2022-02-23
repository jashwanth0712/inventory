import 'package:flutter/material.dart';
import 'package:inventory/admin/providers/notice_provider.dart';
import 'package:inventory/constants.dart';
import 'package:inventory_repository/inventory_repository.dart';
import 'package:provider/provider.dart';

class CreateNotice extends StatelessWidget {
  const CreateNotice({Key? key, required Admin admin})
      : _admin = admin,
        super(key: key);
  final Admin _admin;

  Widget result(BuildContext context) {
    if (context.watch<NoticeProvider>().isSubmitting) {
      return const CircularProgressIndicator();
    } else if (context.watch<NoticeProvider>().isSubmitted) {
      if (context.watch<NoticeProvider>().isSuccess) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Notice Created Successfully',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Some Unknown Failure',
            style: TextStyle(
              color: Colors.red.shade600,
            ),
          ),
        );
      }
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.59,
      maxChildSize: 0.69,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25), topLeft: Radius.circular(25)),
          ),
          width: double.infinity,
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Notice Creation",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    autofocus: true,
                    onChanged: (val) {
                      context.read<NoticeProvider>().changeTitle(title: val);
                    },
                    decoration:
                        AppTextFields.minimalTextFieldDecoration.copyWith(
                      hintText: 'Title',
                      errorText: context.read<NoticeProvider>().title.isEmpty &&
                              context.read<NoticeProvider>().isTitleDirty
                          ? "Title can't be empty"
                          : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    onChanged: (val) {
                      context
                          .read<NoticeProvider>()
                          .changeDescription(description: val);
                    },
                    maxLines: 3,
                    decoration:
                        AppTextFields.minimalTextFieldDecoration.copyWith(
                      hintText: 'Description',
                      errorText:
                          context.read<NoticeProvider>().description.isEmpty &&
                                  context.read<NoticeProvider>().isDescDirty
                              ? "Description can't be empty"
                              : null,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                result(context),
                const SizedBox(height: 10),
                InkWell(
                  onTap: (() {
                    context.read<NoticeProvider>().submitting();
                    context.read<NoticeProvider>().submitted(admin: _admin);
                    Future.delayed(const Duration(seconds: 3), () {
                      context.read<NoticeProvider>().resetSubmission();
                      if (context.read<NoticeProvider>().isSuccess) {
                        Navigator.pop(context);
                        context.read<NoticeProvider>().resetAll();
                      }
                    });
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15.0, // soften the shadow
                          spreadRadius: 2.0, //extend the shadow
                          offset: Offset(
                            2.0, // Move to right 10  horizontally
                            2.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                      child: Text(
                        "Create",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
