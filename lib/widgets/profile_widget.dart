import 'package:flutter/material.dart';
import 'package:incident_reporter/widgets/profile_list_items.dart';

class ProfilePage extends StatelessWidget {
  //const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.only(top: 10 * 3),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 10 * 5,
                ),
              ],
            ),
          ),
          SizedBox(height: 10 * 2),
          Text(
            'Username',
          ),
          SizedBox(height: 10 * 0.5),
          Text(
            'email@gmail.com',
          ),
          SizedBox(height: 10 * 2),
        ],
      ),
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 10 * 3),
        profileInfo,
      ],
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 10 * 5),
          header,
          Expanded(
            child: ListView(
              children: <Widget>[
                ProfileListItem(
                  icon: Icons.privacy_tip,
                  text: 'Privacy',
                ),
                ProfileListItem(
                  icon: Icons.question_answer,
                  text: 'Help & Support',
                ),
                ProfileListItem(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
                ProfileListItem(
                  icon: Icons.logout_sharp,
                  text: 'Logout',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
