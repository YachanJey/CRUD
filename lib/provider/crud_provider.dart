import 'package:crud/model/user_model.dart';
import 'package:crud/repo/crud_repo.dart';
import 'package:flutter/material.dart';


class UserProvider with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  List<User> _users = [];
  bool _isLoading = false;
  
  String? _error;
  List<User> _selectedUsers = [];
  List<User> get selectedUsers => _selectedUsers;


  // Getters
  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch users and update state
  Future<void> loadUsers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _users = await _userRepository.fetchUsers();
    } catch (e) {
      _error = 'Failed to load users: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

   // Method to add a user to the selected list
  void addUserToSelection(User user) {
    if (!selectedUsers.contains(user)) {
      selectedUsers.add(user);
      notifyListeners();
    }
  }

  // Remove a user from the selection
  void removeUserFromSelection(User user) {
    _selectedUsers.remove(user);
    notifyListeners();
  }
  

}
