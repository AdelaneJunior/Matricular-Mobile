import 'package:dio/dio.dart';
import 'package:first/app/usuario/editar/usuario_manter_state.dart';
import 'package:flutter/material.dart';
import 'package:matricular/matricular.dart';

class UsuarioManterDialog extends StatefulWidget {
  final int idUsuario;
  final String pessoaNome;
  final String email;
  final String pessoaTelefone;
  final String cargo;
  final String cpf;
  final UsuarioControllerApi usuarioControllerApi;

  const UsuarioManterDialog({
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
  State<UsuarioManterDialog> createState() => _UsuarioManterDialogState();
}

class _UsuarioManterDialogState extends State<UsuarioManterDialog> {
  UsuarioManterState state = UsuarioManterState();
  late UsuarioControllerApi controllerApi;
  var isEdicao = false;
  List<String> cargos = [];

  @override
  void initState() {
    super.initState();

    state.idUsuario = widget.idUsuario;
    state.cpf = widget.cpf;
    state.nomePessoa.value = widget.pessoaNome;
    state.email.value = widget.email;
    state.telefone.value = widget.pessoaTelefone;
    state.cargo.value = widget.cargo;

    UsuarioDTOCargoEnum.values.forEach((cargo)
        { if(cargo.name != UsuarioDTOCargoEnum.ADMIN.name){
          cargos.add(cargo.name);
        }
      }
    );
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
          showMessage(context, "Usuário Alterado com Sucesso");
          Navigator.of(context).pop();
        } else {
          mostrarDialogSimples(context, response.statusMessage.toString(), "ERRO");
        }
      } on DioException catch (erro) {
        mostrarDialogSimples(context, (erro.response != null
            ? erro.response?.data["message"] : "erro"), "ERRO");
      }
    } else {
      mostrarDialogSimples(context, "Erro campos incorretos", "ERRO");
    }
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: const TextStyle(fontSize: 22.0)),
    ));
  }

  void mostrarDialogSimples(BuildContext context, String message, String titulo) {
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


  void mostrarDialogExcluir(BuildContext context, String message, String titulo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(message),
          actions: <Widget>[
            TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  },
                child: const Text('Cancelar')),
            TextButton(
              onPressed: () {
                excluirDeFato();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  void excluirUsuario(){
    if(state.idPreenchido.value) {
      mostrarDialogExcluir(context,
          "Você tem certeza que deseja excluir o usuário : ${widget.pessoaNome
              .toString()}",
          "Excluir Usuários ${state.idUsuario.toString()}");
      }
    }

  void excluirDeFato() async {
    try {
      controllerApi = widget.usuarioControllerApi;
      var response =
          await controllerApi.usuarioControllerRemover(id: state.idUsuario);
      if (response.statusCode == 200) {
        showMessage(context, "Usuário excluido com sucesso");
        return Navigator.of(context).pop();
      } else {
        mostrarDialogSimples(context, "erro","Erro");
      }
    } on DioException catch (erro) {
      mostrarDialogSimples(context,(erro.response != null ?
      erro.response?.data["message"] : "erro"), "Erro");

    }
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

  void _contralEdicao(){
    setState(() {
      isEdicao = !isEdicao;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Controle Usuario',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 14),
                TextField(
                  enabled: isEdicao,
                  controller: TextEditingController()
                    ..text = state.nomePessoa.toString(),
                  style: const TextStyle(color: Colors.black),
                  onChanged: state.nomePessoa.set,
                  decoration: InputDecoration(
                     disabledBorder:  InputBorder.none,
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      labelText: 'Nome${isEdicao ? '*' : ''}'),
                ),
                const SizedBox(height: 1),
                IgnorePointer(
                  ignoring: !isEdicao,
                  child: DropdownButtonFormField<String>(
                    value: state.cargo.value,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 16
                    ),
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
                    decoration:  InputDecoration(
                      border: isEdicao ? const UnderlineInputBorder() : InputBorder.none ,
                      labelText: 'Cargo${isEdicao ? '*' : ''}',
                      labelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TextField(
                  enabled: isEdicao,
                  controller: TextEditingController()
                    ..text = state.telefone.toString(),
                  style: const TextStyle(color: Colors.black),
                  onChanged: state.telefone.set,
                  decoration: InputDecoration(
                      disabledBorder:  InputBorder.none,
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      labelText: 'Telefone${isEdicao ? '*' : ''}'),
                ),
                TextField(
                  enabled: isEdicao,
                  controller: TextEditingController()
                    ..text = state.email.toString(),
                  style: const TextStyle(color: Colors.black),
                  onChanged: state.email.set,
                  decoration: InputDecoration(
                      disabledBorder:  InputBorder.none,
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      labelText: 'Email${isEdicao ? '*' : ''}'),
                ),
                isEdicao ?
                TextField(
                  onChanged: state.senhaAntiga.set,
                  obscureText: true,
                  decoration: const InputDecoration(
                      disabledBorder:  InputBorder.none,
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      labelText: 'Senha Antiga'),
                ) : const SizedBox.shrink(),
                isEdicao ?
                TextField(
                  onChanged: state.senha.set,
                  obscureText: true,
                  decoration: const InputDecoration(
                      disabledBorder:  InputBorder.none,
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      labelText: 'Nova Senha'),
                ) : const SizedBox.shrink(),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: excluirUsuario,
                        child: const Icon(Icons.delete_forever)
                    ),
                    TextButton(
                        onPressed: _contralEdicao,
                        child: const Icon(Icons.edit)),
                    const Spacer(flex: 3),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child:  Text(isEdicao ? 'Cancelar' : 'Voltar'),
                    ),
                    const Spacer(flex: 1,),
                    isEdicao ?
                    ElevatedButton(
                      onPressed: realizaAtualizacao,
                      child: const Text('Atualizar'),
                    ) : const SizedBox.shrink() ,
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
