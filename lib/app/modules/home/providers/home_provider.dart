import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:musaneda/app/modules/home/cities_model.dart';
import 'package:musaneda/app/modules/home/contracts_model.dart';
import 'package:musaneda/app/modules/home/nationalities_model.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../components/mySnackbar.dart';
import '../../../../config/constance.dart';
import '../../../../config/myColor.dart';
import '../musaneda_model.dart';
import '../sliders_model.dart';

class HomeProvider extends GetConnect{
  final box = GetStorage();

  /// Get all Sliders from api
  Future<Sliders> getSliders() async {
    try {
      final res = await get(
        "${Constance.apiEndpoint}/sliders",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      if (res.body['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "Can't get Sliders",
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Sliders.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// Get all Musaneda from api
  Future<Musaneda> getMusaneda(int page) async {
    try {
      final res = await get(
        "${Constance.apiEndpoint}/musanedas?page=$page",
        //query: {"page":page},
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );
      // if(res.status.code == 0 | 1){
      //   print('res.status.code == 0 | 1 :: ${res.status.code}');
      // }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Musaneda.fromJson(jsonDecode(res.body) as Map<String,dynamic>);
      }
    } catch (e, s) {
      print("exception is that ${e}");
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// Get all Filter Musaneda from api by sending nationalities & age & marital status
  Future<Musaneda> getFilter(
      {required int national ,required int age ,required int marital ,required int page }) async {
    try {
      // final res = await get(
      //   "${Constance.apiEndpoint}/filter?page=$page&age=$age&nationality=$national&marital_status=$marital",
      //   // query: {
      //   //   "page":page,
      //   //   "age":age,
      //   //   "nationality":national,
      //   //   "marital_status":marital
      //   // },
      //   headers: { //page=1&age=1&nationality=69&marital_status=1 //query.map((key, value) => MapEntry(key, value.toString()))
      //     "Accept": "application/json",//page=$page&age=$age&nationality=$national&marital_status=$marital
      //     "Authorization": "Bearer ${Constance.instance.token}",
      //   },
      // );
     // final uri = Uri.parse(scheme: );
      final res = await http.get(
          Uri.parse("${Constance.apiEndpoint}/filter? page=$page&age=$age&nationality=$national&marital_status=$marital"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      if (jsonDecode(res.body)['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "Can't find any filtered musaneda",
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }
      if (res.statusCode != 200) {
        return Future.error(res.statusCode);
      } else {
        return Musaneda.fromJson(jsonDecode(res.body));
      }
    } catch (e, s) {
     // print('Exception is :::::::::: $e');
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// Get all Search Musaneda from api by sending name
  Future<Musaneda> getSearch(keyword) async {
    try {
      final res = await get(
        "${Constance.apiEndpoint}/search?name=$keyword",///search?keyword=
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );
      final response = jsonDecode(res.body) as Map<String , dynamic>;

      if (response['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "Can't find any result",
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }

      // if (res.body['body'] == 1) {
      //   mySnackBar(
      //     title: "success".tr,
      //     message: "correct results",
      //     color: MYColor.warning,
      //     icon: CupertinoIcons.info_circle,
      //   );
      // }
      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Musaneda.fromJson(response['data']);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// Get all Contracts from api
  Future<Contracts> getContracts() async {
    try {
      final res = await get(
        "${Constance.apiEndpoint}/orders-history",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      if (jsonDecode(res.body)['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "Sorry Can't fetch contracts",
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Contracts.fromJson(jsonDecode(res.body) as Map<String,dynamic>);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// Get all Nationalities from api
  Future<Nationalities> getNationalities() async {
    try {
      final res = await get(
        "${Constance.apiEndpoint}/nationalities",  //"${Constance.apiEndpoint}/musaneda_nationality"
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      if (res.body['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "Can't fetch nationalities",
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Nationalities.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }

  /// Get all Cities from api
  Future<Cities> getCities() async {
    try {
      final res = await get(
        "${Constance.apiEndpoint}/cities",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${Constance.instance.token}",
        },
      );

      if (res.body['code'] == 0) {
        mySnackBar(
          title: "error".tr,
          message: "Can't fetch cities",
          color: MYColor.warning,
          icon: CupertinoIcons.info_circle,
        );
      }

      if (res.status.hasError) {
        return Future.error(res.status);
      } else {
        return Cities.fromJson(res.body);
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return Future.error(e.toString());
    }
  }
}
