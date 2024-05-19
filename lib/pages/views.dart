import 'package:flutter/material.dart';
import 'package:light_water_pays/pages/form-light/form_light.dart';
import 'package:flutter/services.dart';

import '../shared/components/appbar_custom.dart';
import '../shared/components/darwer_custom.dart';

class ViewPages extends StatefulWidget {
  const ViewPages({super.key});

  @override
  State<ViewPages> createState() => _ViewPagesState();
}

class _ViewPagesState extends State<ViewPages> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndexPage = 0;

  List<Widget> listPages = [
    const FormLight(),
  ];

  void onChangePage(int indexPageSelected) {
    setState(() {
      currentIndexPage = indexPageSelected;
    });
  }

  void onToggleEndDrawer() {
    if (scaffoldKey.currentState?.isDrawerOpen == true &&
        scaffoldKey.currentState?.hasDrawer == true) {
      scaffoldKey.currentState?.closeDrawer();
    } else {
      scaffoldKey.currentState?.openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      appBar: AppBarCustomWidget(
        openDrawerNavigation: onToggleEndDrawer,
      ),
      body: Scaffold(
        key: scaffoldKey,
        body: listPages[currentIndexPage],
        drawer: DrawerCustom(
          currentIndexPage: currentIndexPage,
          onChangePage: onChangePage,
        ),
      ),
    );
  }
}
