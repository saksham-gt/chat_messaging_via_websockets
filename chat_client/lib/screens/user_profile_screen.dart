import 'package:chat_client/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  static const routeName = '/user-profile-screen';
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toUser = ModalRoute.of(context)!.settings.arguments as User;
    showReportDialog() async {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                backgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                content: Text(
                  'Are you sure you want to report ${toUser.name}?',
                  style: const TextStyle(color: Colors.teal),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'No',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              ));
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(toUser.name!),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 50),
          Expanded(
            child: Image.network(toUser.dpUrl!, fit: BoxFit.fitHeight),
          ),
          const SizedBox(height: 50),
          ListTile(
            tileColor: Colors.blueGrey[100],
            leading: const Icon(
              Icons.flag,
              color: Colors.red,
            ),
            title: const Text(
              'Report User',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () async => await showReportDialog(),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }
}
