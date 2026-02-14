import 'package:fidely_app/cubits/data/data_cubit.dart';
import 'package:fidely_app/l10n/l10n.dart';
import 'package:fidely_app/misc/themes/rradius.dart';
import 'package:fidely_app/misc/themes/spaces.dart';
import 'package:fidely_app/widgets/hicon.dart';
import 'package:fidely_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

part "parts/export.dart";
part "parts/import.dart";
part "parts/operation.dart";

class ExportImportSettingsPage extends StatefulWidget {
  static const String route = "/settings/export_import";

  const ExportImportSettingsPage({super.key});

  @override
  State<ExportImportSettingsPage> createState() =>
      _ExportImportSettingsPageState();
}

class _ExportImportSettingsPageState extends State<ExportImportSettingsPage> {
  bool _includePhotos = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(showTitle: false),
      body: Padding(
        padding: EdgeInsets.all(Spaces.medium),
        child: BlocBuilder<DataCubit, DataCubitState>(
          builder: (context, state) => switch (state) {
            DataCubitLoadingState() => operation(
              context: context,
              operation: state.operation,
              loading: true,
            ),
            DataCubitExportSuccessState() => operation(
              context: context,
              operation: DataOperation.export,
              success: true,
            ),
            DataCubitErrorState() => operation(
              context: context,
              operation: state.operation,
              success: false,
              errorMessage: state.message,
            ),
            _ => content(context),
          },
        ),
      ),
    );
  }

  Widget content(BuildContext context) => SingleChildScrollView(
    child: Column(
      spacing: Spaces.extraLarge,
      children: [
        Card(
          elevation: 1,
          child: export(
            context: context,
            includePhotos: _includePhotos,
            onIncludePhotosChanged: (value) {
              setState(() => _includePhotos = value);
            },
          ),
        ),
        Card(elevation: 1, child: import(context: context)),
      ],
    ),
  );
}
