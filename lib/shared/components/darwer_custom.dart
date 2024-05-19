import 'package:flutter/material.dart';

class DrawerCustom extends StatefulWidget {
  const DrawerCustom({super.key, required this.currentIndexPage, required this.onChangePage});

  final int currentIndexPage;
  final Function(int) onChangePage;

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  void onTapChangePage(int index) {
    widget.onChangePage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 40,
              left: 30,
              right: 0,
              bottom: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.settings_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Configuración',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const MenuItemButton(
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.only(top: 15, left: 53),
                    ),
                  ),
                  child: Text(
                    'Datos de la cuenta',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const MenuItemButton(
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.only(top: 0, left: 53),
                    ),
                  ),
                  child: Text(
                    'Notificaciones',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.2),
                  height: 1,
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: const Row(
                    children: [
                      Icon(Icons.logout_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Cerrar sesión',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
