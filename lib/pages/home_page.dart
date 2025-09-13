import 'package:fidely_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const route = "/home";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: TopBar(),
    body: const Center(child: Text("Home Page")),
  );
}
