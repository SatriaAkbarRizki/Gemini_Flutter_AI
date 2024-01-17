import 'package:aispeak/color/theme.dart';
import 'package:aispeak/provider/bubleimage_provider.dart';
import 'package:aispeak/provider/pickimage_provider.dart';
import 'package:aispeak/provider/result_provider.dart';
import 'package:aispeak/provider/textcontroll_provider.dart';
import 'package:aispeak/provider/theme_provider.dart';
import 'package:aispeak/provider/user_provider.dart';
import 'package:aispeak/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';

void main() {
  // First Get You key API from Google AI Studio
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: 'YOU GEMINI KEY API');
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool valueTheme = false;

  @override
  void initState() {
    ThemeProvider();
    super.initState();
  }

  @override
  void dispose() {
    ResultProvider().closeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ResultProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(create: (_) => PickImageProvider()),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(create: (_) => TextProvider()),
        ChangeNotifierProvider(create: (_) => BubbleProvider())
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) => MaterialApp(
          theme: MyTheme().ligthTheme,
          darkTheme: MyTheme().darkTheme,
          themeMode:
              value.themeValue == true ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: Home(),
        ),
      ),
    );
  }
}
