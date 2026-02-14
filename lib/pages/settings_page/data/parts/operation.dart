part of "../export_import_settings_page.dart";

Widget operation({
  required BuildContext context,
  required DataOperation operation,
  bool loading = false,
  bool success = false,
  String? errorMessage,
}) => Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  spacing: Spaces.medium,
  children: [
    icon(context, operation, loading, success),
    title(context, operation, loading, success),
    if (loading)
      message(
        L10n.of(context)!.export_import_settings_page_operation_message_loading,
      ),
    if (!loading && operation == DataOperation.export && success)
      message(
        L10n.of(
          context,
        )!.export_import_settings_page_operation_message_export_success,
      ),
    if (!loading && operation == DataOperation.import && success)
      message(
        L10n.of(
          context,
        )!.export_import_settings_page_operation_message_import_success,
      ),
    if (!loading && !success && errorMessage != null)
      message(
        errorMessage == "no_data"
            ? L10n.of(
                context,
              )!.export_import_settings_page_operation_message_failure_no_data
            : errorMessage,
      ),
    if (loading)
      Center(
        child: LoadingAnimationWidget.waveDots(
          color: Theme.of(context).colorScheme.primary,
          size: 48,
        ),
      ),
    if (!loading)
      TextButton(
        onPressed: () => context.read<DataCubit>().reset(),
        child: Text(
          L10n.of(context)!.export_import_settings_page_operation_close,
        ),
      ),
  ],
);

Widget icon(
  BuildContext context,
  DataOperation operation,
  bool loading,
  bool success,
) => Container(
  padding: EdgeInsets.all(Spaces.medium),
  decoration: BoxDecoration(
    color: loading
        ? Theme.of(context).colorScheme.primary.withAlpha(25)
        : success
        ? Colors.green.withAlpha(25)
        : Colors.red.withAlpha(25),
    border: Border.all(
      color: loading
          ? Theme.of(context).colorScheme.primary.withAlpha(50)
          : success
          ? Colors.green.withAlpha(50)
          : Colors.red.withAlpha(50),
    ),
    borderRadius: BorderRadius.circular(RRadius.medium),
  ),
  child: Hicon(
    loading
        ? operation == DataOperation.export
              ? HugeIcons.strokeRoundedDownload03
              : HugeIcons.strokeRoundedUpload03
        : success
        ? HugeIcons.strokeRoundedCheckmarkSquare03
        : HugeIcons.strokeRoundedAlertSquare,
    color: loading
        ? Theme.of(context).colorScheme.primary
        : success
        ? Colors.green
        : Colors.red,
    size: 48,
  ),
);

Widget title(
  BuildContext context,
  DataOperation operation,
  bool loading,
  bool success,
) => SizedBox(
  width: double.infinity,
  child: Text(
    loading
        ? operation == DataOperation.export
              ? L10n.of(
                  context,
                )!.export_import_settings_page_operation_title_export
              : L10n.of(
                  context,
                )!.export_import_settings_page_operation_title_import
        : success
        ? L10n.of(context)!.export_import_settings_page_operation_title_success
        : L10n.of(context)!.export_import_settings_page_operation_title_failure,
    style: Theme.of(context).textTheme.headlineMedium,
    textAlign: TextAlign.center,
  ),
);

Widget message(String message) => Text(message, textAlign: TextAlign.center);
