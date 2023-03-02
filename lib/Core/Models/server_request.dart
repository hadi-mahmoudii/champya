import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;

import '../Config/app_session.dart';
import '../Widgets/error_result.dart';

class ServerRequest {
  // Future<Either<ErrorResult, List>> fetchDatas(String url,
  //     {List<dynamic>? datas}) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         'X-Requested-With': 'XMLHttpRequest',
  //         'Authorization': AppSession.token,
  //       },
  //     );
  //     // // print(response.statusCode);
  //     // print(response.body);
  //     var values = json.decode(response.body);
  //     return Right(values);
  //   } catch (e) {
  //     return Left(ErrorResult.fromException(e));
  //   }
  // }

  Future<Either<ErrorResult, dynamic>> fetchData(String url,
      {List<dynamic>? datas}) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': AppSession.token,
          'accept-language': 'en',
        },
      );
      var values = json.decode(response.body);
      return Right(values);
    } catch (e) {
      return Left(ErrorResult.fromException(e));
    }
  }

  Future<Either<ErrorResult, dynamic>> sendData(String url,
      {Map? datas}) async {
    try {
      // print(AppSession.token);
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': AppSession.token,
          "Content-Type": "application/json",
          "Accept": "application/json",
          'accept-language': 'en',
        },
        body: json.encode(datas),
      );
      // print(json.encode(datas)  );
      // print(response.body);
      var values = json.decode(response.body);
      return Right(values);
    } catch (e) {
      return Left(ErrorResult.fromException(e));
    }
  }

  Future<Either<ErrorResult, dynamic>> updateData(String url,
      {Map? datas}) async {
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': AppSession.token,
          'accept-language': 'en',
        },
        body: datas,
      );
      var values = json.decode(response.body);
      return Right(values);
    } catch (e) {
      return Left(ErrorResult.fromException(e));
    }
  }

  Future<Either<ErrorResult, dynamic>> deleteData(String url,
      {List<dynamic>? datas}) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': AppSession.token,
        },
      );
      var values = json.decode(response.body);
      return Right(values);
    } catch (e) {
      return Left(ErrorResult.fromException(e));
    }
  }
}
