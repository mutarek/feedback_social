import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/old_code/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  Future<void> _refresh() async {
    final data = Provider.of<FriendRequestProvider>(context, listen: false);
    data.getData();

    final data2 = Provider.of<NotificationsProvider>(context, listen: false);
    data2.getData();
  }

  final List<Widget> _widgetOptions = [
    // const Index(),
    // const Text("home page"),
    const HomePageScreen(),
    const FriendRequest(),
    const NotificationsScreen(),
    const Flag(),
    // const Text("Flag"),
    const Menu()
    // const Text("Menu"),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 2) {
        NotificationsProvider().notificationCount = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Consumer<NotificationsProvider>(builder: (context, provider, child) {
        return Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        );
      }),
      bottomNavigationBar:
          Consumer<NotificationsProvider>(builder: (context, provider, child) {
        return BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                  backgroundColor: Colors.transparent),
              const BottomNavigationBarItem(
                  icon: Icon(
                    MdiIcons.accountGroupOutline,
                  ),
                  label: 'Friends',
                  backgroundColor: Colors.transparent),
              BottomNavigationBarItem(
                  icon: (provider.notificationCount == 0)
                      ? const Icon(LineIcons.bell)
                      : Stack(
                          children: [
                            const Icon(
                              LineIcons.bell,
                            ),
                            Positioned(
                                top: -1,
                                right: -1,
                                child: Stack(
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.5),
                                        child: Text(
                                          "${provider.notificationCount}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ),
                  label: 'Notification',
                  backgroundColor: Colors.transparent),
              const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.flag,
                  ),
                  label: 'Flag',
                  backgroundColor: Colors.transparent),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Profile',
                backgroundColor: Colors.transparent,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Palette.primary,
            unselectedItemColor: const Color.fromARGB(255, 75, 74, 74),
            showSelectedLabels: false,
            iconSize: 35,
            onTap: _onItemTapped,
            elevation: 0);
      }),
    );
  }
}
