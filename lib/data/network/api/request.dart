import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:first_aid/shared/constants/string_assets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Request {
  final String url;
  final dynamic body;

  Request({@required this.url, this.body});

  Future<http.Response> get() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
      try {
        return await http.get(
            Uri.parse(url),
            headers: {
              StringAssets.apiKeyHeader: StringAssets.apiKey
            })
            .timeout(Duration(seconds: 30),
            onTimeout: () {
              return http.Response("Error", StringAssets.timeoutCode);
            });
      } on TimeoutException catch (e) {
        print("Time Out: $e");
        return http.Response("Error", StringAssets.timeoutCode);
      } on SocketException catch (e) {
        print("Socket: $e");
        return http.Response("Error", StringAssets.internetIssueCode);
      } on Error catch (e) {
        print("Error: $e");
        return http.Response("Error", StringAssets.errorCode);
      }
    }
    else{
      return http.Response("Error", StringAssets.internetIssueCode);
    }
  }
}