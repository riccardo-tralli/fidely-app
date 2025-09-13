import 'package:fidely_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  static const route = "/card";

  const CardPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: TopBar(),
    body: const Center(child: Text("Card Page")),
  );
}
