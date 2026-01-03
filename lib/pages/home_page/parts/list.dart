part of "../home_page.dart";

Widget list({
  required BuildContext context,
  required LoyaltyCardLoadedState state,
}) => BlocListener<SortCubit, SortMode>(
  listener: (context, state) {
    context.read<LoyaltyCardBloc>().loadLoyaltyCards(state);
  },
  child: BlocBuilder<ViewModeCubit, ViewMode>(
    builder: (context, viewMode) {
      final bool categorySortMode =
          context.read<SortCubit>().state.option == SortOption.category;
      List<Widget> children = List.empty(growable: true);

      final favorites = state.cards.where((e) => e.favorite).toList()
        ..sort((a, b) => a.usageCount > b.usageCount ? -1 : 1);
      if (favorites.isNotEmpty) {
        children.add(favoriteList(context, favorites));
      }

      if (categorySortMode) {
        for (Category category
            in context.read<SortCubit>().state.reverse
                ? Categories(context).list.reversed
                : Categories(context).list) {
          List<LoyaltyCard> cards = state.cards
              .where((e) => e.category == category.name)
              .toList();

          if (cards.isNotEmpty) {
            children.addAll([
              categoryChip(context, category),
              viewMode.columns == 1 ? listBuilder(cards) : gridBuilder(cards),
            ]);
          }
        }
      } else {
        children.add(
          viewMode.columns == 1
              ? listBuilder(state.cards)
              : gridBuilder(state.cards),
        );
      }

      return CustomScrollView(slivers: children);
    },
  ),
);

Widget favoriteList(BuildContext context, List<LoyaltyCard> favorites) =>
    SliverToBoxAdapter(
      child: Container(
        height: 100,
        margin: EdgeInsets.only(top: Spaces.small, bottom: Spaces.small),
        padding: EdgeInsets.all(Spaces.small),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withAlpha(25),
        ),
        child: Row(
          children: [
            RotatedBox(
              quarterTurns: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: Spaces.extraSmall,
                children: [
                  Hicon(
                    HugeIcons.strokeRoundedFavourite,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 16,
                  ),
                  Text(
                    L10n.of(context)!.home_page_favorite_section_title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: favorites
                    .map(
                      (e) => LoyaltyCardWidget(
                        card: e,
                        width: 100,
                        showBarcode: false,
                        showOwner: false,
                        compressed: true,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );

Widget categoryChip(BuildContext context, Category category) => SliverPadding(
  padding: EdgeInsets.only(left: Spaces.medium, top: Spaces.medium),
  sliver: SliverToBoxAdapter(
    child: RoundChip(label: category.label, icon: category.icon),
  ),
);

Widget listBuilder(List<LoyaltyCard> cards) => SliverPadding(
  padding: EdgeInsets.symmetric(horizontal: Spaces.small),
  sliver: SliverList.builder(
    itemCount: cards.length,
    itemBuilder: (context, index) => LoyaltyCardWidget(card: cards[index]),
  ),
);

Widget gridBuilder(List<LoyaltyCard> cards) => SliverPadding(
  padding: EdgeInsets.symmetric(horizontal: Spaces.small),
  sliver: SliverGrid.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 3 / 2,
    ),
    itemCount: cards.length,
    itemBuilder: (context, index) => LoyaltyCardWidget(
      card: cards[index],
      showBarcode: false,
      showOwner: false,
    ),
  ),
);
