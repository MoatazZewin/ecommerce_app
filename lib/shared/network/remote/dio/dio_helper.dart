import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl:'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }


  static Future<Response> get({
    required String path,
    Map<String ,dynamic>? query,
    String lang = 'ar',
    String? token })async
  {
    dio.options.headers = {
      'Content_Type':'application/json',
      'Lang':lang,
      'Authorization':token,
    };
    return await dio.get(path, queryParameters:  query);
  }

  static Future<Response> Post({
   required String path,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
    required Map<String, dynamic> data
   })async{
    dio.options.headers ={
      'Content_Type':'application/json',
      'Lang':lang,
      'Authorization':token,
    };
    return await dio.post(path,
      queryParameters: query,
      data: data,
    );

}
}