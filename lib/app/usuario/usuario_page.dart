import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:first/app/usuario/editar/usuario_manter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:matricular/matricular.dart';
import 'package:provider/provider.dart';
import 'package:routefly/routefly.dart';
import 'package:signals/signals_flutter.dart';

import '../../routes.dart';
import '../api/matricular_api.dart';

class UsuarioPage extends StatefulWidget {
  const UsuarioPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => UsuarioPage(),
    );
  }

  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  late UsuarioControllerApi usuarioController;
  List<int> selectedItems = [];
  final refresh = signal('');

  Future<Response<BuiltList<UsuarioDTO>>> listaUsuarios(
      UsuarioControllerApi usuarioControllerApi, String refresh) {
    try {
      return usuarioControllerApi.usuarioControllerListAll();
    } on DioException catch (exception) {
      debugPrint("Erro usuarios: ${exception.response}");
      return Future.value([] as FutureOr<Response<BuiltList<UsuarioDTO>>>?);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    usuarioController = context.read<AppAPI>().api.getUsuarioControllerApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Usuários"),
      ),
      body: Stack(
        children: <Widget>[
          ListenableBuilder(
            listenable: Routefly.listenable,
            builder: (BuildContext context, snapshot) {
              return FutureBuilder<Response<BuiltList<UsuarioDTO>>>(
                future: listaUsuarios(usuarioController, refresh.watch(context)),
                builder: (context, AsyncSnapshot<Response<BuiltList<UsuarioDTO>>> snapshot) {
                  return buildListView(snapshot);
                },
              );
            },
          ),
          Positioned(
            bottom: 16.0,
            left: MediaQuery.of(context).size.width / 2 - 28,
            child: FloatingActionButton(
              onPressed: () {
               Routefly.pushNavigate(routePaths.usuario.incluir.usuarioIncluir)
                   .then((_){});
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
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
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListView(AsyncSnapshot<Response<BuiltList<UsuarioDTO>>> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data?.data?.length,
        itemBuilder: (BuildContext context, int index) {
          final usuario = snapshot.data!.data![index];
          final isSelected = selectedItems.contains(usuario.id);
          final hasAnySelected = selectedItems.isNotEmpty;
          return Center(
            child: Card(
              color: isSelected ? Colors.white70 : null,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return UsuarioManterDialog(
                        usuarioControllerApi: usuarioController,
                        idUsuario: usuario.id!,
                        pessoaNome: usuario.pessoaNome!,
                        pessoaTelefone: usuario.pessoaTelefone!,
                        email: usuario.email!,
                        cargo: usuario.cargo!.name,
                        cpf: usuario.pessoaCpf!,
                      );
                    },
                  );
                },
                onLongPress: () {
                  setState(() {
                    if (isSelected) {
                      selectedItems.remove(usuario.id);
                    } else {
                      selectedItems.add(usuario.id!);
                    }

                    if (selectedItems.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Alerta"),
                            content: Text("Itens selecionados: ${selectedItems.length}"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        usuario.pessoaNome!,
                        style: const TextStyle(fontSize: 22.0),
                      ),
                      subtitle: Text(
                        "email: ${usuario.email}",
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else if (snapshot.hasError) {
      return const Text('Erro ao buscar usuários');
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
