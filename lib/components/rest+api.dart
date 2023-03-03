import 'package:dio/dio.dart';

var basic_url = 'http://52.79.233.120:8000/';
// var basic_url = 'https://louishome.shop//';
var dio = Dio();

Future post_data({url, data}) async {
  final response = await dio.post(basic_url + url, data: data);
  return response.data;
}
