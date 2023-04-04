import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO-DO LIST'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            TextFormField(
              controller: controller.textcontroller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.teal),
                    borderRadius: BorderRadius.circular(15)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                hintText: "Add New Task",
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (controller.textcontroller.text.isEmpty) {
                  return "Required";
                } else if (controller.textlist
                    .contains(controller.textcontroller.text)) {
                  return "All ready including";
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: FilledButton.tonal(
                onPressed: () {
                  controller.textlist.addIf(
                      (controller.textcontroller.text.isNotEmpty &&
                          !controller.textlist
                              .contains(controller.textcontroller.text)),
                      controller.textcontroller.text);
                  controller.task();
                  controller.textcontroller.clear();
                },
                child: const Text(
                  "Add Task",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.teal.shade100,
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(
              () => controller.textlist.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.textlist.length,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => ListTile(
                              leading: Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                value: controller.textlist2
                                    .contains(controller.textlist[index]),
                                onChanged: (value) {
                                  controller.textlist2
                                          .contains(controller.textlist[index])
                                      ? controller.textlist2
                                          .remove(controller.textlist[index])
                                      : controller.textlist2
                                          .add(controller.textlist[index]);
                                  controller.select();
                                },
                              ),
                              title: Text(
                                controller.textlist[index],
                                style: TextStyle(
                                    decoration: controller.textlist2.contains(
                                  controller.textlist[index],
                                )
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  debugPrint(
                                      "=============>${controller.textlist[index]}");
                                  controller.textlist2
                                      .remove(controller.textlist[index]);
                                  controller.textlist.removeAt(index);

                                  controller.delete();
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: Text(
                        "No Task",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
