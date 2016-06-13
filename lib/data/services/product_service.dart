import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';

class ProductService {
  Future<List<Map<String, dynamic>>> fetchProducts({String? category}) async {
    try {
      Uri url = Uri.parse(ApiConstants.productsEndpoint);
      if (category != null && category != 'All') {
        url = url.replace(queryParameters: {'category': category});
      }

      final response = await http.get(url, headers: {
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);

        List<dynamic> list = [];
        if (data is Map<String, dynamic> && data.containsKey('data')) {
          list = data['data'];
        } else if (data is List) {
          list = data;
        }

        return list.map((item) {
          final map = item as Map<String, dynamic>;
          // Map API 'name' to UI 'title'
          if (map.containsKey('name') && !map.containsKey('title')) {
            map['title'] = map['name'];
          }
          return map;
        }).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
