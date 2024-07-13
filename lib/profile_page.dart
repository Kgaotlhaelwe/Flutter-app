import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  final String token;

  ProfilePage({required this.token});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    getProfile(widget.token);
  }

  Future<void> getProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse('https://gigartz-1.onrender.com/profile'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Profile data: $data'); // Debug print

        setState(() {
          name = data['username'] ?? 'No name provided'; // Handle null values
          email = data['email'] ?? 'No email provided'; // Handle null values
        });
      } else {
        print('Failed to load profile: ${response.body}');
      }
    } catch (e) {
      print('Error fetching profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (name.isEmpty && email.isEmpty)
              CircularProgressIndicator() // Show loading indicator while fetching data
            else ...[
              Text('Name: $name'),
              Text('Email: $email'),
            ]
          ],
        ),
      ),
    );
  }
}
