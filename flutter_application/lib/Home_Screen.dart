import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Res api call'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final email = user['email'];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user['picture']['thumbnail']),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user['name']['first'] + ' ' + user['name']['last']),
                Text(email, style: TextStyle(fontSize: 10, color: Colors.grey),),
                SizedBox(height: 10),
              ],
            )
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchUser();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

void fetchUser() async {
  print('fetching user data...');
  const url = 'https://randomuser.me/api/?results=100';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final body = response.body;
  final json = jsonDecode(body);

  setState(() {
    users = json['results'];
  });

  print("fetch user complete");
}
}