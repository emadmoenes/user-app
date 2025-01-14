import 'package:flutter/material.dart';
import 'package:user_app/views/widgets/cards_section.dart';
import 'package:user_app/views/widgets/custom_button.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserListView extends StatefulWidget {
  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  late Future<List<User>> futureUsers;
  bool _isDataFetched = false;

  void _fetchData() {
    setState(() {
      futureUsers = UserService().fetchUsers();
      _isDataFetched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GradientButton(
              text: 'Fetch Users',
              onPressed: _fetchData,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Slide to show user card',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: _isDataFetched
                ? FutureBuilder<List<User>>(
                    future: futureUsers,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No users found'));
                      } else {
                        return StackedCards(users: snapshot.data!);
                      }
                    },
                  )
                : Center(
                    child: Text(
                      'Click the button to fetch users',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
