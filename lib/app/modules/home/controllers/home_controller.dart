import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    init();
    super.onInit();
  }

  TextEditingController textcontroller = TextEditingController();

  final _check = true.obs;
  bool get check => _check.value;
  set check(bool value) => _check.value = value;

  final _textlist = RxList().obs;
  RxList get textlist => _textlist.value;
  set textlist(RxList value) => _textlist.value = value;

  final _textlist2 = RxList().obs;
  RxList get textlist2 => _textlist2.value;
  set textlist2(RxList value) => _textlist2.value = value;

  Future<void> task() async {
    try {
      await FirebaseFirestore.instance.collection("User").doc("Data").set(
        {
          "textlist": textlist.toList(),
          "selected": textlist2.toList(),
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> init() async {
    try {
      final data =
          await FirebaseFirestore.instance.collection("User").doc("Data").get();

      for (var i = 0; i < data["textlist"].length; i++) {
        textlist.add(
          data["textlist"][i],
        );
      }
      for (var i = 0; i < data["selected"].length; i++) {
        textlist2.add(
          data["selected"][i],
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> select() async {
    try {
      await FirebaseFirestore.instance.collection("User").doc("Data").update(
        {
          "selected": textlist2.toList(),
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> delete() async {
    try {
      await FirebaseFirestore.instance.collection("User").doc("Data").update(
        {
          "textlist": textlist.toList(),
          "selected": textlist2.toList(),
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
