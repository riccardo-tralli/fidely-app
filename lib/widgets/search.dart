import 'package:fidely_app/blocs/loyalty_card/loyalty_card_bloc.dart';
import 'package:fidely_app/l10n/l10n.dart';
import 'package:fidely_app/misc/themes/spaces.dart';
import 'package:fidely_app/models/category.dart';
import 'package:fidely_app/models/loyalty_card.dart';
import 'package:fidely_app/widgets/hicon.dart';
import 'package:fidely_app/widgets/loyalty_card_widget/loyalty_card_widget.dart';
import 'package:fidely_app/widgets/round_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<LoyaltyCardBloc, LoyaltyCardState>(
        builder: (context, state) {
          Widget child = SizedBox();

          if (state is LoyaltyCardLoadedState && state.cards.isNotEmpty) {
            child = Column(
              spacing: Spaces.medium,
              children: [textInput(context), results(context, state.cards)],
            );
          }

          return Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(Spaces.large),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
            child: child,
          );
        },
      );

  Widget textInput(BuildContext context) => TextFormField(
    controller: _controller,
    decoration: InputDecoration(
      suffixIcon: IconButton(
        onPressed: () {
          _controller.clear();
          setState(() {});
        },
        icon: Hicon(HugeIcons.strokeRoundedCancelCircle),
      ),
    ),
    onChanged: (value) => setState(() {}),
    autofocus: true,
  );

  Widget results(BuildContext context, List<LoyaltyCard> cards) {
    List<LoyaltyCard> filteredCards = cards;

    if (_controller.text.isEmpty) {
      // Show first three favorite (if any) and minimum three non-favorite cards ordered by descending usage count
      filteredCards = cards.where((e) => e.favorite).take(3).toList();
      if (filteredCards.length < 6) {
        filteredCards.addAll(
          cards.where((e) => !e.favorite).toList()
            ..sort((a, b) => b.usageCount.compareTo(a.usageCount)),
        );
        filteredCards = filteredCards.take(6).toList();
      }
    } else {
      // Filter cards by title containing the search query (case insensitive) ordered by title
      filteredCards =
          cards
              .where(
                (e) => e.title.toLowerCase().contains(
                  _controller.text.toLowerCase(),
                ),
              )
              .toList()
            ..sort((a, b) => a.title.compareTo(b.title));
    }

    if (filteredCards.isEmpty) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: Spaces.medium,
          children: [
            Image.asset("assets/images/error.png", width: 150),
            Text(
              L10n.of(context)!.home_page_search_empty_results,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        itemCount: filteredCards.length,
        itemBuilder: (context, index) => result(filteredCards[index]),
        separatorBuilder: (context, index) =>
            Divider(color: Theme.of(context).dividerColor),
      ),
    );
  }

  Widget result(LoyaltyCard card) {
    final Category category = Categories(context).fromName(card.category);

    return ListTile(
      visualDensity: VisualDensity.compact,
      leading: card.favorite
          ? Hicon(HugeIcons.strokeRoundedFavourite, color: Colors.red, size: 12)
          : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: Spaces.small,
        children: [
          Expanded(child: Text(card.title)),
          if (category.icon != null) RoundChip(icon: category.icon),
        ],
      ),
      subtitle: card.owner != null
          ? Text(
              card.owner!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : null,
      onTap: () => LoyaltyCardWidget(card: card).show(context),
    );
  }
}
