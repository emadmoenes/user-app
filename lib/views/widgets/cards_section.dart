import 'package:flutter/material.dart';
import 'package:user_app/models/user_model.dart';
import 'user_card.dart';

class StackedCards extends StatelessWidget {
  final List<User> users;

  const StackedCards({required this.users});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        child: PageView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return UserCard(user: users[index]);
          },
        ),
      ),
    );
  }
}
