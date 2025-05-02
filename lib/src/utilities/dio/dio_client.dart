// ignore_for_file: avoid_dynamic_calls
import "dart:async";
import "dart:developer";
import "dart:io";

import "package:dio/dio.dart";
import 'package:six_g_app/src/core/data/models/base_res.dart';
import "package:six_g_app/src/utilities/general.dart";
import "package:flutter/foundation.dart";

class DioClient {
  DioClient._();

  static Dio? _dio;

  static Dio get instance => _dio ??= getInstance();

  //header
  static Dio getInstance() {
    Dio httpClient = Dio(
      BaseOptions(
        receiveTimeout: const Duration(milliseconds: 30000),
        sendTimeout: null,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Accept': '*/*',
          'Access-Control-Allow-Origin': '*',
        },
        queryParameters: {
          "dev_type": "android",
          "dev_ver": "30",
          "app_ver": "2.0.28",
          "port": "uapp"
        },
      ),
    );
    // intercept
    httpClient.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.baseUrl = app.env.baseUrl;
          options.headers.addAll({
            // "Authorization": app.token,
            //'x-language': AppContext.instance.locale,
            //'x-ip-address': WifiDetails.ipDetails?.ip,
            //'x-timezone': WifiDetails.ipDetails?.timezone,
          });

          print("==========Token::: ${app.token}");
          options.queryParameters.addAll({
            "lang": app.locale.languageCode,
            "token": app.token,
            "time": DateTime.now().toIso8601String(),
            "sign": app.sign,
          });

          var request = options.data;
          try {
            // request = jsonEncode(options.data);
          } catch (e) {
            /**Ignored */
          }
          // log('Token: ${TokenStorage.getToken()}');
          log('${options.method} ===> ${options.baseUrl}${options.path}\nRequest: $request');

          return handler.next(options);
        },
        onError: (error, handler) async {
          var apiMsg = 'Something Went Wrong ${error.response?.statusCode}';
          try {
            apiMsg = error.response?.data['message'];
          } catch (_) {
            /**Ignored */
          }
          log('Error on ===> ${error.requestOptions.baseUrl}${error.requestOptions.path}\nMessage: $apiMsg');
          return handler.next(error);
        },
        onResponse: (response, handler) async {
          log('Response on ===> ${response.requestOptions.baseUrl}${response.requestOptions.path}\nMessage: $response');
          handler.next(response);
        },
      ),
    );

    _dio = httpClient;
    return httpClient;
  }

  static void retryRequest(
      RequestOptions requestOptions, ErrorInterceptorHandler handler) async {
    var response = await _dio!.fetch(requestOptions);
    handler.resolve(response);
  }

  static BaseResponse<T> dioCatch<T>(Object e) {
    try {
      e as DioException;
      var url = e.requestOptions.path;
      var response = e.response;

      //*** Just telegrame report to track issue
      // try {
      //   final useStaticKeys = EncryptRoutes.withStaticKeys.contains(e.requestOptions.uri);
      //   var _requestBody = AppEncryption.decrypt(e.requestOptions.data['payload'], useStaticKey: useStaticKeys);
      //   TelegramReport.send(ReportModel(
      //       message:
      //       "[BaseResponse]: $_uri  \n Request Unsuccess[ $statusCode ] : $response \n[RequestBody] : $_requestBody"));
      // } catch (e) {
      //   TelegramReport.send(ReportModel(
      //     message: "[BaseResponse]: $_uri  \n Request Unsuccess[ $statusCode ] : $response \n[CatchDecry] error",
      //   ));
      // }
      //***

      log('BaseResponse Unsuccess :\n $url \n Full Url ${e.requestOptions.uri} \n $response',
          name: 'DioCatch');

      if (kDebugMode) {}
      return BaseResponse(
        success: false,
        message: e.response?.data['message'] ??
            'Service currently not available, please try again.',
        statusCode: e.response?.data['code'] ?? 0,
      );

      //* server down
      if (e.error.runtimeType == SocketException) {
        if (kDebugMode) {}
        return BaseResponse(
          success: false,
          message: 'Service currently not available, please try again.',
          statusCode: e.response?.statusCode ?? 0,
          // isUM: (e.response?.statusCode ?? 0) >= 500,
        );
      }
      if (kDebugMode) {}
      return BaseResponse(
        success: false,
        message: 'Something went wrong',
        statusCode: e.response?.statusCode ?? 0,
        // isUM: (e.response?.statusCode ?? 0) >= 500,
      );
    } catch (e) {
      if (kDebugMode) {}
      return const BaseResponse(
        success: false,
        message: 'Service currently not available, please try again.',
        statusCode: 0,
        // isUM: true,
      );
    }
  }

  static Future<BaseResponse<T>> postMethod<T>({
    dynamic request,
    required String path,
    required T Function(dynamic) parseData,
    void Function(int, int)? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      Dio dio = DioClient.instance;
      var res = await dio.post(path,
          data: request,
          onSendProgress: onSendProgress,
          cancelToken: cancelToken);
      log('Response: $res', name: 'POST');
      BaseResponse<T> result =
          BaseResponse.generate(response: res, parseData: parseData);
      return result;
    } catch (e) {
      if (kDebugMode) {}
      return dioCatch(e);
    }
  }

  static Future<BaseResponse<T>> getMethod<T>({
    required String path,
    required T Function(dynamic) parseData,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      /// Test slow performance 15s
      // await Future.delayed(const Duration(seconds: 15));
      Dio dio = DioClient.instance;
      var res = await dio.get(path, queryParameters: queryParameters);
      log('queryParameters: $queryParameters', name: 'GET');
      BaseResponse<T> result =
          BaseResponse.generate(response: res, parseData: parseData);
      return result;
    } catch (e) {
      if (kDebugMode) {}
      return dioCatch(e);
    }
  }

  static Future<BaseResponse<T>> putMethod<T>({
    Object? request,
    required String path,
    required T Function(dynamic) parseData,
  }) async {
    try {
      Dio dio = DioClient.instance;
      var res = await dio.put(path, data: request);
      // log('Response: $res', name: 'PUT');
      BaseResponse<T> result =
          BaseResponse.generate(response: res, parseData: parseData);
      return result;
    } catch (e) {
      return dioCatch(e);
    }
  }

  static Future<BaseResponse<T>> deleteMethod<T>({
    Object? request,
    required String path,
    required T Function(dynamic) parseData,
  }) async {
    try {
      Dio dio = DioClient.instance;
      var res = await dio.delete(path, data: request);
      // log('Response: $res', name: 'DELETE');
      BaseResponse<T> result =
          BaseResponse.generate(response: res, parseData: parseData);
      return result;
    } catch (e) {
      return dioCatch(e);
    }
  }
}
