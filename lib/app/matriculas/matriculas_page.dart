import 'dart:async';

import 'package:dio/dio.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:matricular/matricular.dart';
import 'package:provider/provider.dart';
import 'package:routefly/routefly.dart';

import '../../routes.dart';
import '../api/matricular_api.dart';
import '../utils/config_state.dart';

class MatriculaPage extends StatelessWidget {
  const MatriculaPage({super.key});

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
              child: const MatriculaPage(),
            ));
  }

  Future<Response<BuiltList<MatriculaListagemDTO>>> _getData(
      MatriculaControllerApi matriculaController) async {
    try {
      var dado = await matriculaController
          .matriculaControllerListarMatriculasListagemPorStatus(
              statusMatricula: "ATIVO");
      debugPrint("home-page:data:$dado");
      return dado;
    } on DioException catch (e) {
      debugPrint("Erro home:${e.response}");
      return Future.value(
          [] as FutureOr<Response<BuiltList<MatriculaListagemDTO>>>?);
    }
  }

  @override
  Widget build(BuildContext context) {
    MatriculaControllerApi? matriculasController =
        context.read<AppAPI>().api.getMatriculaControllerApi();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Listagem de Matriculas Ativas'),
      ),
      body: FutureBuilder<Response<BuiltList<MatriculaListagemDTO>>>(
          future: _getData(matriculasController),
          builder: (context,
              AsyncSnapshot<Response<BuiltList<MatriculaListagemDTO>>>
                  snapshot) {
            return buildListView(snapshot);
          }),
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
                icon: const Icon(Icons.accessibility_outlined),
                onPressed: () {
                  Routefly.navigate(routePaths.necessidades.path).then((_) {});
                },
              ),
              IconButton(icon: const Icon(Icons.account_circle_sharp),
                onPressed: (){
                   Routefly.navigate(routePaths.usuario).then((_){});
                })
            ],
          )),
    );
  }

  Widget buildListView(
      AsyncSnapshot<Response<BuiltList<MatriculaListagemDTO>>> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data?.data?.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
              child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Theme.of(context).colorScheme.inversePrimary,
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.account_box, size: 60),
                  title: Text("nome: ${snapshot.data!.data?[index].nomeAluno}",
                      style: const TextStyle(fontSize: 22.0)),
                  subtitle: Text(
                      "status: ${snapshot.data!.data?[index].statusMatricula}",
                      style: const TextStyle(fontSize: 18.0)),
                ),
                ButtonBar(
                  children: <Widget>[
                    ElevatedButton(
                      child: const Text('Editar'),
                      onPressed: () {
                        /* ... */
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Excluir'),
                      onPressed: () {
                        /* ... */
                      },
                    ),
                  ],
                ),
              ],
            ),
          ));
        },
      );
    } else if (snapshot.hasError) {
      return const Text('Erro ao acessar dados');
    } else {
      return const CircularProgressIndicator();
    }
  }
}
