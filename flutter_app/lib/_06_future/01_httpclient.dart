import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

main () {
  requestNetwork3();
}

//HttpClient
void requestNetwork() async {
  // 1.创建HttpClient对象
   final httpclient = HttpClient();
   // 2.构建请求的uri
   final uri = Uri.parse('http://123.207.32.32:8000/api/v1/recommen');
   // 3.构建请求
   final request = await httpclient.getUrl(uri);
   // 4.发送请求，必须
   final response = await request.close();
   if(response.statusCode == HttpStatus.ok) {
     print (await response.transform(utf8.decoder).join()); //解析数据
   } else {
     print(response.statusCode);
   }
}

//http系统库
void requestNetwork2() async {
  final client = http.Client();
  final url = Uri.parse('http://123.207.32.32:8000/api/v1/recommend');
  final response = await client.get(url);
  if(response.statusCode == HttpStatus.ok) {
    print (response.body);
  } else {
    print(response.statusCode);
  }
}

//dio第三方库
void requestNetwork3() async {
   final dio = Dio();
   final response = await dio.get('http://123.207.32.32:8000/api/v1/recommend');
   if (response.statusCode == HttpStatus.ok) {
     print(response.data);
   } else {
     print(response.statusCode);
   }
}