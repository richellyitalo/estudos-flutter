import 'package:flutter/material.dart';
import '../components/main_drawer.dart';
import '../models/settings.dart';

class SettingsScreen extends StatefulWidget {
  final Function(Settings) onSettingsChanged;

  const SettingsScreen(this.onSettingsChanged);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var settings = Settings();

  Widget _settingsSwitchWidget(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(title),
      value: value,
      onChanged: (value) {
        onChanged(value);
        widget.onSettingsChanged(settings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            child:
                Text('Settings', style: Theme.of(context).textTheme.headline6),
            padding: EdgeInsets.all(20),
          ),
          Expanded(
            child: ListView(
              children: [
                _settingsSwitchWidget(
                  'Exibir sem glúten',
                  'Exibe apenas receitas sem glútem',
                  settings.isGlutenFree,
                  (value) => setState(() {
                    settings.isGlutenFree = value;
                  }),
                ),
                _settingsSwitchWidget(
                  'Exibir sem lactose',
                  'Exibe apenas receitas sem lactose',
                  settings.isLactoseFree,
                  (value) => setState(() {
                    settings.isLactoseFree = value;
                  }),
                ),
                _settingsSwitchWidget(
                  'Apenas veganas',
                  'Exibe apenas receitas vegandas',
                  settings.isVegan,
                  (value) => setState(() {
                    settings.isVegan = value;
                  }),
                ),
                _settingsSwitchWidget(
                  'Apenas vegetariana',
                  'Exibe apenas receitas vegetarianas',
                  settings.isVegetarian,
                  (value) => setState(() {
                    settings.isVegetarian = value;
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
