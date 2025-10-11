import 'package:fidely_app/cubits/dark_mode_cubit.dart';
import 'package:fidely_app/widgets/hicon.dart';
import 'package:fidely_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

class SettingsPage extends StatefulWidget {
  static const route = "/settings";

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = context.read<DarkModeCubit>().state;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: TopBar(roundedBorders: true),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [themeModeOption(context)]),
    ),
  );

  Widget themeModeOption(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Theme Mode", style: Theme.of(context).textTheme.titleMedium),
      Text("Select your preferred theme mode"),
      const SizedBox(height: 8),
      Row(
        spacing: 16,
        children: [
          Expanded(
            child: option(
              context: context,
              icon: HugeIcons.strokeRoundedSun02,
              label: "Light",
              onTap: () {
                setState(() {
                  _themeMode = ThemeMode.light;
                });
                context.read<DarkModeCubit>().set(ThemeMode.light);
              },
              active: _themeMode == ThemeMode.light,
            ),
          ),
          Expanded(
            child: option(
              context: context,
              icon: HugeIcons.strokeRoundedMoon01,
              label: "Dark",
              onTap: () {
                setState(() {
                  _themeMode = ThemeMode.dark;
                });
                context.read<DarkModeCubit>().set(ThemeMode.dark);
              },
              active: _themeMode == ThemeMode.dark,
            ),
          ),
          Expanded(
            child: option(
              context: context,
              icon: HugeIcons.strokeRoundedSmartPhone02,
              label: "System",
              onTap: () {
                setState(() {
                  _themeMode = ThemeMode.system;
                });
                context.read<DarkModeCubit>().set(ThemeMode.system);
              },
              active: _themeMode == ThemeMode.system,
            ),
          ),
        ],
      ),
    ],
  );

  Widget option({
    required BuildContext context,
    required List<List<dynamic>> icon,
    required String label,
    required Function onTap,
    bool active = false,
  }) => InkWell(
    borderRadius: BorderRadius.circular(16),
    onTap: () => onTap(),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: active
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).cardColor,
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 8,
        children: [
          Hicon(icon, color: active ? Colors.white : null),
          Text(label, style: TextStyle(color: active ? Colors.white : null)),
        ],
      ),
    ),
  );
}
