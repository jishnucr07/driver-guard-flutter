import 'package:driveguard/features/auth/ui/login_page.dart';
import 'package:driveguard/features/ml%20section/logic/cubit/sensor_data_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://urhfcyaxygjjaxvhqtca.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyaGZjeWF4eWdqamF4dmhxdGNhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgxMzk0MzEsImV4cCI6MjA1MzcxNTQzMX0.ohLpBAU6WvPBVeyPt6SRQXoFi13u_XeVY-HVnIAJRUw',
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => SensorDataCubitCubit(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Colors.black),
          // scaffoldBackgroundColor: Colors.black,
          textTheme: TextTheme(
            titleMedium: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LoginPage());
  }
}
