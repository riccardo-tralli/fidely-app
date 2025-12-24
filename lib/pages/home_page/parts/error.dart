part of "../home_page.dart";

Widget error({required BuildContext context, required String message}) =>
    SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: Spaces.medium,
        children: [
          Image.asset("assets/images/error.png", width: 300),
          Text(
            L10n.of(context)!.home_page_generic_error_title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(message),
        ],
      ),
    );
