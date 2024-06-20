import 'package:dio/dio.dart';
import 'package:first/app/necessidades/insert/necessidade_insert_state.dart';
import 'package:first/routes.dart';
import 'package:flutter/material.dart';
import 'package:matricular/matricular.dart';
import 'package:provider/provider.dart';
import 'package:routefly/routefly.dart';

import '../../api/matricular_api.dart';
import '../../utils/config_state.dart';

class NecessidadeInsertPage extends StatefulWidget {
  const NecessidadeInsertPage({super.key});

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
              child: const NecessidadeInsertPage(),
            ));
  }

  @override
  State<NecessidadeInsertPage> createState() => _NecessidadeInsertState();
}

class _NecessidadeInsertState extends State<NecessidadeInsertPage> {
  NecessidadeInsertState state = NecessidadeInsertState();
  late NecessidadeEspecialControllerApi controllerApi;

  incluir() async {
    try {
      var necessidadeEspecialDTO = NecessidadeEspecialDTOBuilder();
      necessidadeEspecialDTO.matriculaId = 1;
      necessidadeEspecialDTO.titulo = state.tituloNecessidade.toString();
      final response = await controllerApi.necessidadeEspecialControllerIncluir(
          necessidadeEspecialDTO: necessidadeEspecialDTO.build());
      if (response.statusCode == 200) {
        Routefly.push(routePaths.necessidades.path);
      } else {
        debugPrint("erro ");
      }
    } on DioException catch (erro) {
      debugPrint(erro.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    controllerApi =
        context.read<AppAPI>().api.getNecessidadeEspecialControllerApi();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Inserir nova Necessidade"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          height: MediaQuery.of(context).size.height - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Flexible(
                  child: Text("Preencha os dados da nova \n Necessidade",
                style: TextStyle(
                  fontSize: 20,
                ),
              )),
              const Spacer(flex: 1),
              Flexible(
                  flex: 3,
                  child: TextField(
                    onChanged: state.tituloNecessidade.set,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Titulo Necessidade")),
                  )),
              const Spacer(
                flex: 1,
              ),
              Flexible(
                  flex: 3,
                  child: FilledButton(
                    onPressed: incluir,
                    child: const Text('Incluir'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
