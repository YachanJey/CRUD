import 'dart:convert';
import 'package:crud/model/user_model.dart';
import 'package:http/http.dart' as http;


class UserRepository {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/users';

  // Fetch users from the API
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Convert JSON response to List<User>
      final List<dynamic> userJson = json.decode(response.body);
      return userJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
