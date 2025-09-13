import 'package:fidely_app/blocs/loyalty_card/loyalty_card_bloc.dart';
import 'package:fidely_app/repositories/loyalty_card_repository.dart';
import 'package:fidely_app/services/loyalty_card_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pine/di/dependency_injector_helper.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({super.key, required this.child});

  @override
  Widget build(BuildContext context) => DependencyInjectorHelper(
    repositories: [
      RepositoryProvider<LoyaltyCardRepository>(
        create: (_) => LoyaltyCardRepository(LoyaltyCardService.instance),
      ),
    ],
    blocs: [
      BlocProvider<LoyaltyCardBloc>(
        create: (context) =>
            LoyaltyCardBloc(repository: context.read())..loadLoyaltyCards(),
      ),
    ],
    child: child,
  );
}
