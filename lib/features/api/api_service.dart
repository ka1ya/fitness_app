import 'package:dio/dio.dart';

class TokenManager {
  static String? _token;

  static String? getToken() {
    return _token;
  }

  static void saveToken(String token) {
    _token = token;
  }
}

class ApiService {
  final Dio _dio;
  final String _baseUrl = 'http://16.171.1.90/api/v1';

  ApiService() : _dio = Dio(BaseOptions(baseUrl: 'http://16.171.1.90/api/v1'));

  Future<Map<String, dynamic>> fetchData(String path, Map<String, dynamic> queryParams) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParams,
        options: _getTokenOptions(),
      );
      return response.data as Map<String, dynamic>;
    } catch (error) {
      print('Error fetching data: $error');
      return {'error': 'Failed to fetch data'};
    }
  }

  Future<Map<String, dynamic>> postData(String path, Map<String, dynamic> postData) async {
    try {
      final response = await _dio.post(
        path,
        data: postData,
        options: _getTokenOptions(),
      );
      return response.data as Map<String, dynamic>;
    } catch (error) {
      print('Error posting data: $error');
      return {'error': 'Failed to post data'};
    }
  }

  Future<Map<String, dynamic>> putData(String path, Map<String, dynamic> queryParams) async {
    try {
      final response = await _dio.put(
        path,
        queryParameters: queryParams,
        options: _getTokenOptions(),
      );
      return response.data as Map<String, dynamic>;
    } catch (error) {
      print('Error putting data: $error');
      return {'error': 'Failed to put data'};
    }
  }

  Future<Map<String, dynamic>> deleteData(String path, Map<String, dynamic> queryParams) async {
    try {
      final response = await _dio.delete(
        path,
        queryParameters: queryParams,
        options: _getTokenOptions(),
      );
      return response.data as Map<String, dynamic>;
    } catch (error) {
      print('Error deleting data: $error');
      return {'error': 'Failed to delete data'};
    }
  }

  Future<Map<String, dynamic>> patchData(String path, Map<String, dynamic> queryParams) async {
    try {
      final response = await _dio.patch(
        path,
        queryParameters: queryParams,
        options: _getTokenOptions(),
      );
      return response.data as Map<String, dynamic>;
    } catch (error) {
      print('Error patching data: $error');
      return {'error': 'Failed to patch data'};
    }
  }

  Options _getTokenOptions() {
    return Options(
      headers: TokenManager._token?.isNotEmpty == true
          ? {'Authorization': 'Bearer ${TokenManager._token}'}
          : null,
    );
  }
}