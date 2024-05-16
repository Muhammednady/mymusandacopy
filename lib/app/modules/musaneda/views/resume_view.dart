import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

import '../../../../config/myColor.dart';
import '../controllers/musaneda_controller.dart';

class ResumeView extends GetView<MusanedaController> {
  const ResumeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.primary,
        title: Text('resume'.tr , style: TextStyle(fontSize: 20.0),),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: controller,
        builder: (_) => Stack(
          children: [

            PDFView(
              filePath: Get.arguments,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: true,
              pageSnap: true,
              defaultPage: controller.currentPage!,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation: false,
              onRender: (p) {
                controller.pages = p;
                controller.changeIsReady(false);
              },
              onError: (error) {
                controller.errorMessage = error.toString();
                if (kDebugMode) {
                  print(error.toString());
                }
              },
              onPageError: (page, error) {
                controller.errorMessage = '$page: ${error.toString()}';
                if (kDebugMode) {
                  print('$page: ${error.toString()}');
                }
              },
              // onViewCreated: (pdfCtrl) {
              //   controller.cTr.complete(pdfCtrl);
              // },
              onLinkHandler: (String? uri) {
                if (kDebugMode) {
                  print('Goto uri: $uri');
                }
              },
              onPageChanged: (int? page, int? total) {
                if (kDebugMode) {
                  print('Page change: $page/$total');
                }
                controller.currentPage = page;
              },
            ),
            Stack(
              children: [
                Container(
                  height: 40,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: MYColor.primary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
