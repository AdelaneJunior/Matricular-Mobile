import 'package:first/app/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:matricular/matricular.dart';
import 'package:provider/provider.dart';

import '../api/matricular_api.dart';
import '../utils/config_state.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MultiProvider(
          providers: [
            Provider(
              create: (_) => context.read<ConfigState>(),
              dispose: (_, instance) => instance.dispose(),
            ),
            Provider(create: (_) => context.read<AppAPI>())
          ],
          child: const HomePage(),
        ));
  }
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeState state = HomeState();
  AppAPI? appAPI;
  late Matricular matricularApi;

  @override
  Widget build(BuildContext context) {

    appAPI = context.read<AppAPI>();
    matricularApi = appAPI!.api;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Principal'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          height: MediaQuery.of(context).size.height - 120,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 6,
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    heightFactor: 0.4,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Esqueceu a senha'),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}