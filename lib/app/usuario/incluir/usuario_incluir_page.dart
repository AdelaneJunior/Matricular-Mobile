
import 'dart:ui';

import 'package:first/app/usuario/incluir/usuario_incluir_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matricular/matricular.dart';
import 'package:provider/provider.dart';
import 'package:routefly/routefly.dart';
import 'package:signals/signals_flutter.dart';

import '../../api/matricular_api.dart';
import '../../utils/config_state.dart';

class UsuarioIncluirPage extends StatefulWidget{

  const UsuarioIncluirPage({super.key});

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
          child: const UsuarioIncluirPage(),
        ));
  }

  @override
  State<UsuarioIncluirPage> createState() => _UsuarioIncluirState();
}

class _UsuarioIncluirState extends State<UsuarioIncluirPage> {

 UsuarioIncluirState state = UsuarioIncluirState();
 late UsuarioControllerApi controllerApi;
 List<String> cargos = ['SECRETARIA', 'DIRETORA', 'COORDENADORA'];



  @override
  Widget build(BuildContext context) {
    controllerApi = context.read<AppAPI>().api.getUsuarioControllerApi();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Incluir Usuário")
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height - 50,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const Flexible(
                  child: Text(
                      "Peencha as informações",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                  )
              ),
              const SizedBox(height: 30),
              Flexible(
                  child: TextField(
                    onChanged: state.pessoaNome.set,
                    decoration:  InputDecoration(
                      border: const OutlineInputBorder(),
                      label: const Text("Nome*"),
                      labelStyle: const TextStyle(
                          color: Colors.black),
                      errorText: state.erroPessoaNome.watch(context)
                    ),
                  )),
              const SizedBox(height: 20),
              Flexible(
                  child: TextField(
                    onChanged: state.pessoaCpf.set,
                    decoration:  InputDecoration(
                      border: const OutlineInputBorder(),
                      label: const Text("CPF*"),
                      labelStyle: const TextStyle(
                          color: Colors.black),
                      errorText: state.erroPessoaCpf.watch(context)
                    ),
                  )),
              const SizedBox(height: 20),
              Flexible(
                  child: TextField(
                    onChanged: state.pessoaTelefone.set,
                    decoration:  InputDecoration(
                      border: const OutlineInputBorder(),
                      label: const Text("Telefone*"),
                      labelStyle: const TextStyle(
                          color: Colors.black),
                      errorText: state.erroPessoaTelefone.watch(context)
                    ),
                  )),
              const SizedBox(height: 20),
              Flexible(
                  child: TextField(
                    onChanged: state.email.set,
                    decoration:  InputDecoration(
                        border: const OutlineInputBorder(),
                        label: const Text("E-mail*"),
                        labelStyle: const TextStyle(
                            color: Colors.black),
                      errorText: state.erroEmail.watch(context)
                    ),
                  )),
              const SizedBox(height: 20),
              Flexible(
                child: DropdownButtonFormField<String>(
                  value: state.cargo.value.isEmpty ? cargos.first : state.cargo.value,
                  onChanged: (newValue) {
                    setState(() {
                      state.cargo.set(newValue ?? cargos.first);
                    });
                  },
                  items: cargos.map((String cargo) {
                    return DropdownMenuItem<String>(
                      value: cargo,
                      child: Text(cargo),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Cargo*',
                    labelStyle: TextStyle(
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Flexible(
                  child: TextField(
                    onChanged: state.senha.set,
                    decoration:  InputDecoration(
                        border: const OutlineInputBorder(),
                        label: const Text("Senha*"),
                        labelStyle: const TextStyle(
                            color: Colors.black),
                      errorText: state.erroSenha.watch(context)
                    ),
                  )),
              const SizedBox(height: 20),
              Flexible(
                  child: TextField(
                    onChanged: state.confirmaSenha.set,
                    decoration:  InputDecoration(
                        border: const OutlineInputBorder(),
                        label: const Text("Confirmar Senha*"),
                        labelStyle: const TextStyle(
                            color: Colors.black),
                      errorText: state.erroConfirmarSenha.watch(context)
                    ),
                  )),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Routefly.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 16),
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 7,
                    ),
                    child: const Text(
                      'CANCELAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      state.incluir(controllerApi, context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 16),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      elevation: 7
                    ),
                    child: const Text(
                        'INCLUIR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    )
                  ),
                ]
              )
            ],
          ),
        ),
      ),
    );
  }

}