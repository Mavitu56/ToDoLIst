import 'package:chat/core/services/notification/chat_notification_service.dart';
import 'package:chat/pages/auth_or_app_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatNotificationService(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple, // Defina a cor primária como transparente
          scaffoldBackgroundColor: Color(0xFF121212), // Defina o fundo como um tom escuro (quase preto)
          primaryColor: Colors.transparent,
          textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.black, // Isso fará com que a cor do texto seja branca.
            displayColor: Colors.black, // Isso fará com que a cor do texto seja branca.
          ), // Defina a cor primária como transparente
          appBarTheme: AppBarTheme(
            color: Colors.transparent, // Defina a cor da barra de aplicativos como transparente
          ),
        ),
        home: const AuthOrAppPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
