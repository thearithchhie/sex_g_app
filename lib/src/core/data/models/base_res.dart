// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls
import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:six_g_app/src/utilities/dio/dio_client.dart';

class BaseResponse<T> {
  final int statusCode;
  final bool success;
  final T? result;
  final String message;
  final bool hasReachedMaxLoad;

  // final Meta meta;

  /// Under Maintanance
  final bool isUM;

  const BaseResponse({
    this.success = false,
    this.statusCode = 0,
    this.message = 'err',
    this.result,
    this.hasReachedMaxLoad = false,
    this.isUM = false,
  });

  static BaseResponse<T> generate<T>({
    required Response<dynamic> response,
    required T Function(dynamic data) parseData,
  }) {
    try {
      bool hasReachedMaxLoad = false;
      if (response.data is Map &&
          response.data.containsKey('current_page') &&
          response.data.containsKey('allpage')) {
        hasReachedMaxLoad =
            int.parse(response.data['current_page'].toString()) >=
                int.parse(response.data['allpage'].toString());
      }
      return BaseResponse(
        success: response.data['code'] == 200,
        statusCode: response.data['code'] ?? 0,
        message: response.data['message'] ?? 'n/a',
        result: parseData(response.data['data'] ?? response.data),
        hasReachedMaxLoad: hasReachedMaxLoad,
        isUM: (response.statusCode ?? 0) >= 500,
      );
    } catch (e) {
      var uri = '====${response.requestOptions.uri}=====';

      log('$uri \n $e ', name: 'BaseResponse Catch');

      // TelegramReport.send(
      //   ReportModel(
      //     message: "[BaseResponse]: $_uri  \n ${e.toString()} \n ${response.toString()}",
      //   ),
      // );
      return DioClient.dioCatch(e);
    }
  }

  factory BaseResponse.fromMap(Map<String, dynamic> map) {
    log('BaseResponse: $map');
    return BaseResponse<T>(
        message: map['message'] ?? 'success',
        result: map as T,
        statusCode: 0,
        success: true);
  }
}
