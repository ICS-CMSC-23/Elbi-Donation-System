import 'package:elbi_donation_system/models/route_model.dart';
import 'package:flutter/material.dart';

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
            ),
          ),
          ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: widget.routes.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(widget.routes[index].name),
                    onTap: () {
                      Navigator.pushNamed(context, widget.routes[index].path);
                    });
              })
        ],
      ),
    );
  }
}
