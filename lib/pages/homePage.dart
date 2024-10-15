import 'package:flutter/material.dart';
import 'package:space_book/components/drawer.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

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
        body: Container());
  }
}
