import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:first/routes.dart';
import 'package:flutter/material.dart';
import 'package:matricular/matricular.dart';
import 'package:provider/provider.dart';
import 'package:routefly/routefly.dart';

import '../api/matricular_api.dart';
import '../utils/config_state.dart';

class NecessidadePage extends StatelessWidget {
  const NecessidadePage({super.key});

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
              child: const NecessidadePage(),
            ));
  }

  Future<Response<BuiltList<NecessidadeEspecialDTO>>> listaNecessidades(
      NecessidadeEspecialControllerApi necessidadeEspController) {
    try {
      return necessidadeEspController.necessidadeEspecialControllerListAll();
    } on DioException catch (exception) {
      debugPrint("Erro necessidades: ${exception.response}");
      return Future.value(
          [] as FutureOr<Response<BuiltList<NecessidadeEspecialDTO>>>?);
    }
  }

  @override
  Widget build(BuildContext context) {
    NecessidadeEspecialControllerApi? necessidadeEspController =
        context.read<AppAPI>().api.getNecessidadeEspecialControllerApi();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Necessidades Especiais"),
      ),
      body: FutureBuilder<Response<BuiltList<NecessidadeEspecialDTO>>>(
        future: listaNecessidades(necessidadeEspController),
        builder: (context,
            AsyncSnapshot<Response<BuiltList<NecessidadeEspecialDTO>>>
                snapshot) {
          return buildListView(snapshot);
        },
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.inversePrimary,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Routefly.navigate(routePaths.login);
              },
            ),
            IconButton(
                icon: const Icon(Icons.account_box),
                onPressed: () {
                  Routefly.navigate(routePaths.matriculas).then((_) {});
                }),
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Routefly.pushNavigate(
                          routePaths.necessidades.insert.necessidadeInsert)
                      .then((_) {});
                }),
          ],
        ),
      ),
    );
  }

  Widget buildListView(
      AsyncSnapshot<Response<BuiltList<NecessidadeEspecialDTO>>> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
          itemCount: snapshot.data?.data?.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
                child: Card(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                  ListTile(
                    title: Text("${snapshot.data!.data?[index].titulo}",
                        style: const TextStyle(fontSize: 22.0))
                  )
                ])));
          });
    } else if (snapshot.hasError) {
      return const Text('Erro ao buscar necessidades');
    } else {
      return const CircularProgressIndicator();
    }
  }
}
