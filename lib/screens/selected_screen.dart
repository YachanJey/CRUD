import 'package:crud/model/user_model.dart';
import 'package:crud/provider/crud_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectedUsersScreen extends StatelessWidget {
  const SelectedUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Selected Users Name and Email"),
        backgroundColor: Colors.blue,
      ),
      body: userProvider.selectedUsers.isEmpty
          ? const Center(child: Text("No users selected yet."))
          : ListView.builder(
              itemCount: userProvider.selectedUsers.length,
              itemBuilder: (context, index) {
                User user = userProvider.selectedUsers[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(user.name[0]),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            userProvider.removeUserFromSelection(user);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${user.name} removed!'))
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

 
}
