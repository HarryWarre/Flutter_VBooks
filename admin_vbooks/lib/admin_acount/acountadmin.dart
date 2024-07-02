import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: AccountManagementPage(),
  ));
}

class AccountManagementPage extends StatefulWidget {
  @override
  _AccountManagementPageState createState() => _AccountManagementPageState();
}

class _AccountManagementPageState extends State<AccountManagementPage> {
  List<User> users = [
    User(id: 1, name: 'Alice'),
    User(id: 2, name: 'Bob'),
    User(id: 3, name: 'Charlie'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Quản lý tài khoản',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(21, 139, 125, 1)),
          onPressed: () {
            Navigator.pop(context); // Quay lại trang trước đó
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15, 12, 0, 12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.0,
                  color: Colors.grey[400]!,
                ),
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.grey[400]!,
                ),
              ),
            ),
            child: Text(
              'Danh sách tài khoản',
              style: TextStyle(
                fontSize: 18.0,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    Icons.person,
                    size: 36,
                    color: Color.fromRGBO(21, 139, 125, 1),
                  ),
                  subtitle: Text('ID: ${users[index].id}'),
                  title: Text(users[index].name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdateInfoScreen(user: users[index])),
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        users.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to a screen to add new user
          // For simplicity, let's assume you have an AddUserScreen to add new users
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUserScreen()),
          ).then((newUser) {
            if (newUser != null) {
              setState(() {
                users.add(newUser);
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class User {
  final int id;
  final String name;
  // Additional fields for account details can be added here

  User({required this.id, required this.name});
}

// Example of a detailed account information screen
class UpdateInfoScreen extends StatelessWidget {
  final User user;

  UpdateInfoScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết tài khoản'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'User ID: ${user.id}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Name: ${user.name}',
              style: TextStyle(fontSize: 24),
            ),
            // Add more account details as needed
          ],
        ),
      ),
    );
  }
}

// Example screen to add new users
class AddUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Example form to add new user
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm tài khoản mới'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Simulate adding a new user
            User newUser = User(id: 4, name: 'New User');
            Navigator.pop(context, newUser);
          },
          child: Text('Thêm tài khoản'),
        ),
      ),
    );
  }
}
