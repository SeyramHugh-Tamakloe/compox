import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as requests;
import './httpCustomException.dart';

class PartsService {
  static const base_url =
      "https://compx-769c7-default-rtdb.europe-west1.firebasedatabase.app/data/";

  static const headers = {
    'Content-Type': 'application/json',
    'Charset': 'utf-8'
  };

  Future<dynamic> getAllParts() async {
    try {
      final response =
          await requests.get("$base_url/partsData.json", headers: headers);
      final responseValue = _handleResponse(response);
      return responseValue;
    } on SocketException catch (e) {
      throw FetchDataException("There is no internet connection");
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> addToCarts(
      String email, Map<dynamic, dynamic> cartItem) async {
    try {
      final response = await requests.post("$base_url/cartData/$email",
          headers: headers, body: json.encode(cartItem));
      final responseValue = _handleResponse(response);
      return responseValue;
    } on SocketException catch (e) {
      throw FetchDataException("There is no internet connection");
    } catch (e) {
      print(e);
    }
  }

  dynamic _handleResponse(requests.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}
