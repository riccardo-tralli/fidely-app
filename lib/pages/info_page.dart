import 'package:fidely_app/l10n/l10n.dart';
import 'package:fidely_app/misc/themes/spaces.dart';
import 'package:fidely_app/widgets/hicon.dart';
import 'package:fidely_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  static const String route = "/info";

  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(showTitle: false),
      body: Padding(
        padding: EdgeInsets.all(Spaces.medium),
        child: content(context),
      ),
    );
  }

  Widget content(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        spacing: Spaces.extraSmall,
        children: [
          logo(context),
          // title(context),
          subtitle(context),
          version(context),
        ],
      ),
      SizedBox(height: Spaces.large),
      Divider(height: .5, thickness: .5, color: Theme.of(context).dividerColor),
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Spaces.large),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: infos(context),
              ),
              Divider(thickness: .5, color: Theme.of(context).dividerColor),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: thanks(context),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  Widget logo(BuildContext context) =>
      SizedBox(height: 100, child: Image.asset("assets/images/logo.png"));

  Widget title(BuildContext context) => Text(
    L10n.of(context)!.app_title,
    style: Theme.of(context).textTheme.titleLarge?.copyWith(
      color: Theme.of(context).colorScheme.primary,
    ),
  );

  Widget subtitle(BuildContext context) => Text(
    "open-source, free and offline loyalty card wallet",
    textAlign: TextAlign.center,
  );

  Widget version(BuildContext context) => FutureBuilder<PackageInfo>(
    future: PackageInfo.fromPlatform(),
    builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) =>
        snapshot.hasData
        ? Text(
            "v${snapshot.data!.version}",
            style: Theme.of(context).textTheme.bodySmall,
          )
        : SizedBox.shrink(),
  );

  List<Widget> infos(BuildContext context) => [
    ListTile(
      leading: Hicon(HugeIcons.strokeRoundedGithub),
      title: Text(
        L10n.of(context)!.info_page_repository_title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      subtitle: Text("github.com/riccardo-tralli/fidely-app"),
      trailing: Hicon(HugeIcons.strokeRoundedLinkSquare01),
      onTap: () =>
          launchUrl(Uri.parse("https://github.com/riccardo-tralli/fidely-app")),
    ),
    ListTile(
      leading: Hicon(HugeIcons.strokeRoundedContracts),
      title: Text(
        L10n.of(context)!.info_page_terms_title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      subtitle: Text(
        "github.com/riccardo-tralli/fidely-app/blob/main/docs/TERMS_OF_USE.md",
      ),
      trailing: Hicon(HugeIcons.strokeRoundedLinkSquare01),
      onTap: () => launchUrl(
        Uri.parse(
          "https://github.com/riccardo-tralli/fidely-app/blob/main/docs/TERMS_OF_USE.md",
        ),
      ),
    ),
    ListTile(
      leading: Hicon(HugeIcons.strokeRoundedPolicy),
      title: Text(
        L10n.of(context)!.info_page_privacy_title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      subtitle: Text(
        "github.com/riccardo-tralli/fidely-app/blob/main/docs/PRIVACY_POLICY.md",
      ),
      trailing: Hicon(HugeIcons.strokeRoundedLinkSquare01),
      onTap: () => launchUrl(
        Uri.parse(
          "https://github.com/riccardo-tralli/fidely-app/blob/main/docs/PRIVACY_POLICY.md",
        ),
      ),
    ),
  ];

  List<Widget> thanks(BuildContext context) => [
    ListTile(
      leading: Hicon(HugeIcons.strokeRoundedBrush),
      title: Text(
        L10n.of(context)!.info_page_illustrations_title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      subtitle: Text("storyset.com"),
      trailing: Hicon(HugeIcons.strokeRoundedLinkSquare01),
      onTap: () => launchUrl(Uri.parse("https://storyset.com")),
    ),
  ];
}
