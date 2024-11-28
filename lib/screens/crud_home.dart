import 'package:crud/model/user_model.dart';
import 'package:crud/provider/crud_provider.dart';
import 'package:crud/screens/selected_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'CRUD Application',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 79, 79, 245),
      ),
      body: userProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : userProvider.error != null
              ? Center(child: Text(userProvider.error!))
              : ListView.builder(
                  itemCount: userProvider.users.length,
                  itemBuilder: (context, index) {
  User user = userProvider.users[index];
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          user.name[0],
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      title: Text(
        user.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Email: ${user.email}"),
          Text("Phone: ${user.phone}"),
          Text("Address: ${user.address.city}, ${user.address.street}"),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.add, color: Colors.green),
        onPressed: () {
          userProvider.addUserToSelection(user);  // Add to selected list
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${user.name} added!'))
          );
        },
      ),
    ),
  );
}

                ),
      floatingActionButton: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    FloatingActionButton(
      heroTag: 'refresh',
      onPressed: () {
        userProvider.loadUsers(); // Reload users
      },
      backgroundColor: Colors.blue,
      child: const Icon(Icons.refresh),
    ),
    const SizedBox(height: 10), // Spacing between buttons
    FloatingActionButton(
      heroTag: 'selected_users',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SelectedUsersScreen()),
        );
      },
      backgroundColor: Colors.green,
      child: const Icon(Icons.people), // Icon for selected users
    ),
  ],
),

    );
  }
}
