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
              "Elbi Donation System",
              style: TextStyle(fontSize: 40),
            ),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8, left: 15),
                child: Text("Dark Mode: "),
              ),
              Switch(
                  value: true,
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
