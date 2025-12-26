part of "../home_page.dart";

Widget list({
  required BuildContext context,
  required LoyaltyCardLoadedState state,
}) => BlocBuilder<ViewModeCubit, ViewMode>(
  builder: (context, viewMode) {
    final bool categorySortMode =
        context.read<SortCubit>().state.option == SortOption.category;
    List<Widget> children = List.empty(growable: true);

    if (categorySortMode) {
      for (Category category in Categories(context).list) {
        List<LoyaltyCard> cards = state.cards
            .where((e) => e.category == category.name)
            .toList();

        if (cards.isNotEmpty) {
          children.addAll([
            SliverPadding(
              padding: EdgeInsets.only(
                left: Spaces.extraSmall,
                top: Spaces.medium,
                right: Spaces.extraSmall,
              ),
              sliver: SliverToBoxAdapter(
                child: RoundChip(label: category.label, icon: category.icon),
              ),
            ),
            if (viewMode.columns == 1) listBuilder(cards),
            if (viewMode.columns == 2) gridBuilder(cards),
          ]);
        }
      }
    } else {
      if (viewMode.columns == 1) children.add(listBuilder(state.cards));
      if (viewMode.columns == 2) children.add(gridBuilder(state.cards));
    }

    return CustomScrollView(slivers: children);
  },
);

Widget listBuilder(List<LoyaltyCard> cards) => SliverList.builder(
  itemCount: cards.length,
  itemBuilder: (context, index) => LoyaltyCardWidget(card: cards[index]),
);

Widget gridBuilder(List<LoyaltyCard> cards) => SliverGrid.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 3 / 2,
  ),
  itemCount: cards.length,
  itemBuilder: (context, index) => LoyaltyCardWidget(card: cards[index]),
);
