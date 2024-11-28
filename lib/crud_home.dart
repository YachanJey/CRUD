import 'package:flutter/material.dart';

class CrudHome extends StatefulWidget {
  const CrudHome({super.key});

  @override
  State<CrudHome> createState() => _CrudHomeState();
}

class _CrudHomeState extends State<CrudHome> {
  
  List<User> users = [];

  //text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  int? editingIndex;

  // Function to add or update user
  void _addOrUpdateUser() {
    if (nameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        countryController.text.isNotEmpty) {
      final user = User(
        name: nameController.text,
        age: int.parse(ageController.text),
        country: countryController.text,
      );

      setState(() {
        if (editingIndex != null) {
          users[editingIndex!] = user;
          editingIndex = null; // Reset after updating
        } else {
          // Add new user
          users.add(user);
        }
      });

      nameController.clear();
      ageController.clear();
      countryController.clear();
    }
  }

  void _deleteUser(int index) {
    setState(() {
      users.removeAt(index);
    });
  }

 
  void _updateFields(int index) {
    final user = users[index];
    nameController.text = user.name;
    ageController.text = user.age.toString();
    countryController.text = user.country;
    setState(() {
      editingIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Center(
          child: Text(
            "CRUD APPLICATION",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input fields for name, age, and country with decoration
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: countryController,
                    decoration: InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _addOrUpdateUser,
              child: Text(
                editingIndex == null ? 'Add User' : 'Update User',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            // Displaying the user list
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        user.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Age: ${user.age}, Country: ${user.country}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.green),
                            onPressed: () => _updateFields(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteUser(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Data model for User
class User {
  final String name;
  final int age;
  final String country;

  User({required this.name, required this.age, required this.country});
}
