import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatto_app_mobile/core/constants/app_constants.dart';
import 'core/di/injection_container.dart' as di;
import 'features/tattoo_generator/presentation/bloc/image_saver/index.dart';
import 'features/tattoo_generator/presentation/bloc/tattoo_generator/index.dart';
import 'features/tattoo_generator/presentation/pages/tattoo_generator_page.dart';

final getIt = di.sl;
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TattooGeneratorBloc(
            generateTattoo: getIt(),
          ),
        ),
        BlocProvider(
          create: (context) => ImageSaverBloc(
            saveTattooToGallery: getIt(),
          ),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Tattoo Generator',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppConstants.primaryColor),
          useMaterial3: true,
        ),
        home: const TattooGeneratorPage(),
      ),
    );
  }
}
