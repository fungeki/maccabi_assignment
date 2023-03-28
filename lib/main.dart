import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maccabi_assignment/pages/home/display_categories_root_page.dart';
import 'package:maccabi_assignment/utils/styles.dart';

import 'blocs/home/display_products_from_categories_bloc.dart';

void main() {
  runApp(const MaccabiAssignment());
}

class MaccabiAssignment extends StatelessWidget {
  const MaccabiAssignment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DisplayProductsFromCategoriesBloc(),
        ),
        //more generic blocs... :)
      ],
      child: MaterialApp(
          title: 'Maccabi assignment',
          theme: ThemeData(
            fontFamily: GoogleFonts.heebo().fontFamily,
            scaffoldBackgroundColor: Styles.kScaffoldBackgroundColor,
            useMaterial3: true,
            appBarTheme: AppBarTheme(color: Styles.kAppBarBackgroundColor),
          ),
          home: const DisplayCategoriesRootPage()),
    );
  }
}
