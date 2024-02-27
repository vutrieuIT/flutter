import 'dart:convert';

import 'package:app/models/user.dart';
import 'package:app/services/local_service/local_auth_service.dart';
import 'package:app/services/remote_service/remote_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  Rxn<User> user = Rxn<User>();
  final LocalAuthService _localAuthService = LocalAuthService();

  @override
  void onInit() {
    _localAuthService.init();
    super.onInit();
  }

  void login(
      {required String fullName,
      required String email,
      required String password}) async {
    try {
      EasyLoading.show(
        status: "Loading...",
        dismissOnTap: false
      );

      var res = await RemoteAuthService().login(email: email, password: password);

      if (res.statusCode == 200){
        String token = jsonDecode(res.body)['jwt'];
        var userRes = await RemoteAuthService().createProfile(fullName: fullName, token: token);
        if (userRes.statusCode == 200) {
          user.value = userFromJson(userRes.body);
          await _localAuthService.addToken(token: token);
          await _localAuthService.addUser(user: user.value!);
          EasyLoading.showSuccess("welcome my app");
          Navigator.of(Get.overlayContext!).pop();
        } else {

        EasyLoading.showError("somethings wrong, try again");
        }
      } else {
        EasyLoading.showError("somethings wrong, try again");
      }

    } finally {
      EasyLoading.dismiss();
    }
  }
}
