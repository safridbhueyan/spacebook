import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_book/components/drawer.dart';
import 'package:space_book/components/input_alert_box.dart';
import 'package:space_book/services/auth/database/database_provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //database provider
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);
//text controller
  final _messageController = TextEditingController();

  //show post message dialog box
  void _openPostMessageBox() {
    showDialog(
      context: context,
      builder: (context) => MyinputalertBox(
          textController: _messageController,
          hintext: "whats poppin?",
          onpressed: () async {
            //post in db
            await postMessage(_messageController.text);
          },
          onpressedText: "post"),
    );
  }

//user wants to post a massge
  Future<void> postMessage(String message) async {
    await databaseProvider.postMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          "H O M E P A G E",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Mydrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: _openPostMessageBox,
        child: Icon(Icons.add),
      ),
    );
  }
}
