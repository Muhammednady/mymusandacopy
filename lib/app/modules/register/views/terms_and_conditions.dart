import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import '../../../../config/myColor.dart';
import 'package:html/parser.dart';
//import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

termsAndConditions(String fileText) {
  Get.bottomSheet(
    GetBuilder(
      init: Get.find<LanguageController>(),
      builder: (_) => Container(
        height: Get.height,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 10,
                right: 10,
                bottom: 30,
              ),
              child: ListView(
                children: [
                  Text(parse(LanguageController.I.privacyPolicy).body!.text,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontFamily: 'montserrat_extra_light',
                      )),
                  // Html(
                  //   data: LanguageController.I.privacyPolicy,
                  //   style: {
                  //     'body': Style(
                  //       color: Colors.black,
                  //       fontSize: FontSize(14),
                  //       fontFamily: 'montserrat_extra_light',
                  //       fontStyle: FontStyle.normal,
                  //       height: Height(1.6),
                  //     ),
                  //     'div': Style(
                  //       color: Colors.black,
                  //       fontSize: FontSize(14),
                  //       fontFamily: 'montserrat_extra_light',
                  //       fontStyle: FontStyle.normal,
                  //       height: Height(1.6),
                  //     ),
                  //   },
                  //   // customTextAlign: (_) {
                  //   //   if (LanguageController.I.getLocale == 'ar') {
                  //   //     return TextAlign.right;
                  //   //   }
                  //   //   return TextAlign.left;
                  //   // },
                  //   // defaultTextStyle: const TextStyle(
                  //   //   color: Colors.black,
                  //   //   fontSize: 14,
                  //   //   fontFamily: 'montserrat_extra_light',
                  //   //   fontStyle: FontStyle.normal,
                  //   //   height: 1.6,
                  //   // ),
                  //   //
                  //   anchorKey: GlobalKey(),
                  // ),
                ],
              ),
            ),
            Positioned(
              top: 30,
              right: LanguageController.I.getLocale == 'ar' ? null : 30,
              left: LanguageController.I.getLocale == 'ar' ? 30 : null,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: MYColor.buttons,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
