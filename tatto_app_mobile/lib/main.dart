import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'features/tattoo_generator/presentation/bloc/tattoo_generator_bloc.dart';
import 'features/tattoo_generator/presentation/pages/tattoo_generator_page.dart';

final getIt = di.sl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tattoo Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => TattooGeneratorBloc(
          generateTattoo: getIt(),
        ),
        child: const TattooGeneratorPage(),
      ),
    );
  }
}
