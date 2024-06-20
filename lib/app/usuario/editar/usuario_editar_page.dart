import 'package:dio/dio.dart';
import 'package:first/app/usuario/editar/usuario_editar_state.dart';
import 'package:flutter/material.dart';
import 'package:matricular/matricular.dart';
import 'package:signals/signals_flutter.dart';

class UsuarioEditDialog extends StatefulWidget {
  final int idUsuario;
  final String pessoaNome;
  final String email;
  final String pessoaTelefone;
  final String cargo;
  final String cpf;
  final UsuarioControllerApi usuarioControllerApi;

  const UsuarioEditDialog({
    super.key,
    required this.usuarioControllerApi,
    required this.idUsuario,
    required this.pessoaNome,
    required this.email,
    required this.pessoaTelefone,
    required this.cargo,
    required this.cpf,
  });

  @override
  State<UsuarioEditDialog> createState() => _UsuarioEditDialogState();
}

class _UsuarioEditDialogState extends State<UsuarioEditDialog> {
  UsuarioEditarState state = UsuarioEditarState();
  late UsuarioControllerApi controllerApi;

  @override
  void initState() {
    super.initState();
    state.idUsuario = widget.idUsuario;
    state.cpf = widget.cpf;
    state.nomePessoa.value = widget.pessoaNome;
    state.email.value = widget.email;
    state.telefone.value = widget.pessoaTelefone;
    state.cargo.value = widget.cargo;
  }

  realizaAtualizacao() async {
    if (state.validaDados()) {
      UsuarioAlterarDTO usuarioAlterarDTO = buildUsuarioAlterarDTO().build();
      try {
        controllerApi = widget.usuarioControllerApi;
        var response = await controllerApi.usuarioControllerNovoAlterar(
            id: widget.idUsuario, usuarioAlterarDTO: usuarioAlterarDTO);
        if (response.statusCode == 200) {
          debugPrint(response.toString());
          showMessage(context, "Usuario Alterado com Sucesso");
          Navigator.of(context).pop();
        } else {
          showMyDialog(context, response.statusMessage.toString(), "ERRO");
        }
      } on DioException catch (erro) {
        showMyDialog(context, erro.message.toString(), "ERRO");
      }
    } else {
      showMyDialog(context, "Erro campos incorretos", "ERRO");
    }
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: const TextStyle(fontSize: 22.0)),
    ));
  }

  void showMyDialog(BuildContext context, String message, String titulo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o AlertDialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  UsuarioAlterarDTOBuilder buildUsuarioAlterarDTO() {
    var senha = (state.senha.toString() == null || state.senha.toString() == '')
        ? null
        : state.senha.toString();

    var senhaAntiga = (state.senhaAntiga.toString() == null ||
            state.senhaAntiga.toString() == '')
        ? null
        : state.senhaAntiga.toString();

    var usuarioAlterar = UsuarioAlterarDTOBuilder();
    usuarioAlterar.id = state.idUsuario;
    usuarioAlterar.senha = senha;
    usuarioAlterar.senhaAntiga = senhaAntiga;
    usuarioAlterar.cargo =
        UsuarioAlterarDTOCargoEnum.valueOf(state.cargo.toString());
    usuarioAlterar.email = state.email.toString();
    usuarioAlterar.pessoaCpf = state.cpf;
    usuarioAlterar.pessoaNome = state.nomePessoa.toString();
    usuarioAlterar.pessoaTelefone = state.telefone.toString();
    usuarioAlterar.idUsuarioRequisicao = 1;
    return usuarioAlterar;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Vizualizar / Editar Usuario',
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: TextEditingController()
                    ..text = state.nomePessoa.toString(),
                  onChanged: state.nomePessoa.set,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  controller: TextEditingController()
                    ..text = state.cargo.toString(),
                  onChanged: state.nomePessoa.set,
                  decoration: const InputDecoration(labelText: 'Cargo'),
                ),
                TextField(
                  controller: TextEditingController()
                    ..text = state.telefone.toString(),
                  onChanged: state.telefone.set,
                  decoration: const InputDecoration(labelText: 'Telefone'),
                ),
                TextField(
                  controller: TextEditingController()
                    ..text = state.email.toString(),
                  onChanged: state.email.set,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: state.emailErro.watch(context)),
                ),
                TextField(
                  onChanged: state.senhaAntiga.set,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Senha Antiga'),
                ),
                TextField(
                  onChanged: state.senha.set,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Nova Senha'),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: realizaAtualizacao,
                      child: const Text('Atualizar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
