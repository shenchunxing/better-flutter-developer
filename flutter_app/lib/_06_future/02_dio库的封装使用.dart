
import 'package:dio/dio.dart';

main() {
   HttpRequest.request('https://httpbin.org/get' ,
       method: 'post',
       params: {'name' : 'jack','age' : 18},
       interceptor: null).then((value) {

   });
}

class HttpConfig { //基础配置
  static const baseURL = 'https://httpbin.org'; //接口地址
  static const timeout = 5000;//超时时间
}

class HttpRequest { //请求
   static final BaseOptions options = BaseOptions(
     baseUrl: HttpConfig.baseURL,connectTimeout: HttpConfig.timeout
   );

   static final Dio dio = Dio(options);

   /**
    * url，可选的参数、方法名、拦截器
    */
   static Future<T> request<T>(
       String url , {String method = 'get' , Map<String , dynamic>? params , Interceptor? interceptor}) async {

     // 1.请求的单独配置
     final options = Options(method: method);

     // 2.添加第一个拦截器
     Interceptor dInter = InterceptorsWrapper(
         onRequest: (RequestOptions options , RequestInterceptorHandler handler) {
           // 1.在进行任何网络请求的时候, 可以添加一个loading显示
           // 2.很多页面的访问必须要求携带Token,那么就可以在这里判断是有Token
           // 3.对参数进行一些处理,比如序列化处理等
           print('请求被拦截');
         },
       onResponse: (Response response , ResponseInterceptorHandler handler) {
         print('响应被拦截');
       },

       onError: (DioError error , ErrorInterceptorHandler handler) {
         print('错误被拦截');
       }
     );

     List<Interceptor> inters = [dInter];
     if (inters != null) {
       inters.add(interceptor!); //添加拦截器
     }

     dio.interceptors.addAll(inters);

     // 3.发送网络请求
     try {
       Response response = await dio.request<T>(url,queryParameters: params,options: options);
       return response.data;
     } on DioError catch(e) {
       return Future.error(e);
     }
   }
}