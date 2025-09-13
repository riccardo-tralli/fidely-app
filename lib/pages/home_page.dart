import 'package:barcode_widget/barcode_widget.dart';
import 'package:fidely_app/models/loyalty_card.dart';
import 'package:fidely_app/widgets/loyalty_card_widget.dart';
import 'package:fidely_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const route = "/home";

  const HomePage({super.key});

  //! Dev stuff: list of colors for demo cards
  final List<Color> colors = const [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.amber,
    Colors.cyan,
    Colors.indigo,
    Colors.lime,
    Colors.pink,
    Colors.yellow,
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: TopBar(),
    body: Padding(padding: const EdgeInsets.all(8), child: cardList(context)),
  );

  Widget cardList(BuildContext context) => ListView.builder(
    itemCount: colors.length,
    // separatorBuilder: (context, index) => const SizedBox(height: 16),
    itemBuilder: (context, index) => LoyaltyCardWidget(
      //! Dev stuff: demo cards
      card: LoyaltyCard(
        id: index,
        title: "Card ${index + 1}",
        code: List.generate(
          13,
          (i) => String.fromCharCode(65 + (index + i) % 26),
        ).join(),
        type: Barcode.code93(),
        owner: "Owner ${index + 1}",
        color: colors[index],
        note: "Note for card ${index + 1}",
      ),
      isSelected: index == 0,
    ),
  );
}
