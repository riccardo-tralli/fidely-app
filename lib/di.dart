import 'package:fidely_app/blocs/loyalty_card/loyalty_card_bloc.dart';
import 'package:fidely_app/cubits/loyalty_card/loyalty_card_cubit.dart';
import 'package:fidely_app/cubits/permission/permission_cubit.dart';
import 'package:fidely_app/repositories/loyalty_card_repository.dart';
import 'package:fidely_app/repositories/permission_repository.dart';
import 'package:fidely_app/services/loyalty_card_service.dart';
import 'package:fidely_app/services/permission_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pine/di/dependency_injector_helper.dart';
import 'package:provider/provider.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({super.key, required this.child});

  @override
  Widget build(BuildContext context) => DependencyInjectorHelper(
    providers: [
      Provider<PermissionService>(create: (_) => PermissionService()),
    ],
    repositories: [
      RepositoryProvider<LoyaltyCardRepository>(
        create: (_) => LoyaltyCardRepository(LoyaltyCardService.instance),
      ),
      RepositoryProvider<PermissionRepository>(
        create: (context) => PermissionRepository(context.read()),
      ),
    ],
    blocs: [
      BlocProvider<LoyaltyCardBloc>(
        create: (context) =>
            LoyaltyCardBloc(repository: context.read())..loadLoyaltyCards(),
      ),
      BlocProvider<LoyaltyCardCubit>(
        create: (context) =>
            LoyaltyCardCubit(repository: context.read(), bloc: context.read()),
      ),
      BlocProvider<PermissionCubit>(
        create: (context) => PermissionCubit(repository: context.read()),
      ),
    ],
    child: child,
  );
}
