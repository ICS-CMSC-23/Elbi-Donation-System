import 'package:elbi_donation_system/providers/auth_provider.dart';
import 'package:elbi_donation_system/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/route_model.dart';

class MainDrawer extends StatefulWidget {
  final List<RouteModel> routes;
  const MainDrawer({super.key, required this.routes});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: const Text(
              "Elbi GenerosiTree",
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8, left: 15),
                child: Text("Dark Mode: "),
              ),
              Switch(
                  inactiveTrackColor: Theme.of(context).primaryColor,
                  activeColor: Theme.of(context).primaryColor,
                  value: context.watch<ThemeProvider>().isDarkTheme,
                  onChanged: (e) {
                    context.read<ThemeProvider>().toggleDarkTheme();
                  })
            ],
          ),
          ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: widget.routes.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(widget.routes[index].name),
                    onTap: () {
                      if (widget.routes[index].path == "/login") {
                        context.read<AuthProvider>().signOut();
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/login", (r) => false);
                      }
                      Navigator.pushNamed(context, widget.routes[index].path);
                    });
              })
        ],
      ),
    );
  }
}
