import 'package:fidely_app/blocs/loyalty_card/loyalty_card_bloc.dart';
import 'package:fidely_app/cubits/data/data_cubit.dart';
import 'package:fidely_app/cubits/search_cubit.dart';
import 'package:fidely_app/cubits/settings/dark_mode_cubit.dart';
import 'package:fidely_app/cubits/loyalty_card/loyalty_card_cubit.dart';
import 'package:fidely_app/cubits/permission/permission_cubit.dart';
import 'package:fidely_app/cubits/settings/language_cubit.dart';
import 'package:fidely_app/cubits/settings/sort_cubit.dart';
import 'package:fidely_app/cubits/settings/view_mode_cubit.dart';
import 'package:fidely_app/repositories/data_repository.dart';
import 'package:fidely_app/repositories/loyalty_card_repository.dart';
import 'package:fidely_app/repositories/permission_repository.dart';
import 'package:fidely_app/services/data_service.dart';
import 'package:fidely_app/services/loyalty_card_service.dart';
import 'package:fidely_app/services/permission_service.dart';
import 'package:fidely_app/services/photo_service.dart';
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
      Provider<PhotoService>(create: (_) => PhotoService.instance),
      Provider<DataService>(create: (_) => DataService()),
    ],
    repositories: [
      RepositoryProvider<LoyaltyCardRepository>(
        create: (_) => LoyaltyCardRepository(LoyaltyCardService.instance),
      ),
      RepositoryProvider<PermissionRepository>(
        create: (context) => PermissionRepository(context.read()),
      ),
      RepositoryProvider<DataRepository>(
        create: (context) => DataRepository(context.read()),
      ),
    ],
    blocs: [
      BlocProvider<DarkModeCubit>(create: (_) => DarkModeCubit()),
      BlocProvider<ViewModeCubit>(create: (_) => ViewModeCubit()),
      BlocProvider<SortCubit>(create: (_) => SortCubit()),
      BlocProvider<LanguageCubit>(create: (_) => LanguageCubit()),
      BlocProvider<SearchCubit>(create: (_) => SearchCubit()),
      BlocProvider<LoyaltyCardBloc>(
        create: (context) =>
            LoyaltyCardBloc(repository: context.read())
              ..loadLoyaltyCards(context.read<SortCubit>().state),
      ),
      BlocProvider<LoyaltyCardCubit>(
        create: (context) => LoyaltyCardCubit(
          repository: context.read(),
          bloc: context.read(),
          photoService: context.read(),
        ),
      ),
      BlocProvider<DataCubit>(
        create: (context) => DataCubit(
          cardRepository: context.read(),
          dataRepository: context.read(),
        ),
      ),
      BlocProvider<PermissionCubit>(
        create: (context) => PermissionCubit(repository: context.read()),
      ),
    ],
    child: child,
  );
}
