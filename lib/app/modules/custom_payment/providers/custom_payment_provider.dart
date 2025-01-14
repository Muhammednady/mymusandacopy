import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:musaneda/app/modules/custom_payment/payment_response.dart';
import 'package:musaneda/config/constance.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CustomPaymentProvider extends GetConnect {

  Future<PaymentResponse> checkout(Map data) async {
   try{
     final response = await post(
       "${Constance.apiEndpoint}/checkouts",
       data,
       headers: {
         'Accept': 'application/json',
         'Authorization': "Bearer ${Constance.instance.token}",
       },
     );

     log('response : ${response.body}', name: 'home_provider_checkout');

     if (response.status.hasError) {
       //return PaymentResponse.fromJson(response.body);
       return Future.error(response.status.code!);
     } else {
       return PaymentResponse.fromJson(response.body);
     }

   }catch(e,s){
     print('Exception in Future<PaymentResponse> checkout(Map data)');
     await Sentry.captureException(e,stackTrace: s);
     return Future.error(e);
   }
  }

  Future<PaymentResponse> payments(Map data) async {
    final response = await post(
      "${Constance.apiEndpoint}/payments",
      data,
      headers: {
        'Accept': 'application/json',
        'Authorization': "Bearer ${Constance.instance.token}",
      },
    );
    log('response : ${response.body}', name: 'home_provider_payments');

    if (response.status.hasError) {
      //return PaymentResponse.fromJson(response.body);
      return Future.error(response.status.code!);
    } else {
      return PaymentResponse.fromJson(response.body);
    }
  }

  void validate(response) {
    if (response.body['errors']['amount'] != null) {
      Get.snackbar(
        'Error',
        response.body['errors']['amount'][0],
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    if (response.body['errors']['entityID'] != null) {
      Get.snackbar(
        'Error',
        response.body['errors']['entityID'][0],
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    if (response.body['errors']['merchantTransactionId'] != null) {
      Get.snackbar(
        'Error',
        response.body['errors']['merchantTransactionId'][0],
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    if (response.body['errors']['address'] != null) {
      Get.snackbar(
        'Error',
        response.body['errors']['address'][0],
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    if (response.body['errors']['city'] != null) {
      Get.snackbar(
        'Error',
        response.body['errors']['city'][0],
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    if (response.body['errors'] != null) {
      Get.snackbar(
        'Error',
        response.body['errors'][0],
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
