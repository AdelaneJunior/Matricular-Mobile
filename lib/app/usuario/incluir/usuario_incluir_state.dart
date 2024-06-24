
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matricular/matricular.dart';
import 'package:routefly/routefly.dart';
import 'package:signals/signals.dart';

class UsuarioIncluirState {

  final pessoaNome = signal<String>('');
  final pessoaCpf = signal<String>('');
  final pessoaTelefone = signal<String>('');
  final email = signal<String>('');
  final cargo = signal<String>('');
  final senha = signal<String>('');
  final confirmaSenha = signal<String>('');

  final erroPessoaNome = signal<String?>(null);
  final erroPessoaCpf =  signal<String?>(null);
  final erroPessoaTelefone = signal<String?>(null);
  final erroEmail = signal<String?>(null);
  final erroCargo = signal<String?>(null);
  final erroSenha = signal<String?>(null);
  final erroConfirmarSenha = signal<String?>(null);

  late final validaPessoaNome = computed(() => pessoaNome.value != null &&
      pessoaNome.value != '');
  late final validaPessoaCpf = computed(() => pessoaCpf.value != null &&
      pessoaCpf.value != '' );
  late final validaPessoaTelefone = computed(() => pessoaTelefone.value != null &&
      pessoaTelefone.value != '');
  late final validaEmail = computed(() => email.value != null &&
      email.value != '');
  late final validaCargo = computed(() => cargo.value != null &&
      cargo.value != '');
  late final validaSenha = computed(() => senha.value != null &&
      senha.value != '');
  late final validaConfirmaSenha = computed(() => confirmaSenha.value != null &&
      confirmaSenha.value != '');


  incluir(UsuarioControllerApi controller, BuildContext context) async {
    if(validaInclusao()){
      try {
        var response = await controller
            .usuarioControllerIncluir(usuarioDTO: construirUsuarioDTO());
        if(response.statusCode == 200){
          showMessage(context, "Usuário incluido com Sucesso");
          Navigator.pop(context, "Usuario Incluido");
        }else{
          mostrarDialogSimples(context, response.statusMessage.toString(),
              "ERRO");
        }
      }on DioException catch(erro){
        mostrarDialogSimples(context,  (erro.response != null
            ? erro.response?.data["message"] : "erro"), "ERRO");
      }
    }
  }

  validaInclusao(){
    String erro = 'Campo obrigatorio';
    bool ok = true;
    if(!validaPessoaNome.value){
      erroPessoaNome.set(erro);
      ok = false;
    }else{
      erroPessoaNome.set(null);
    }

    if(!validaPessoaCpf.value){
      erroPessoaCpf.set(erro);
      ok = false;
    }else{
      if(!cpfValido()){
        erroPessoaCpf.set('CPF invalido');
        ok = false;
      }else {
        erroPessoaCpf.set(null);
      }
    }

    if(!validaPessoaTelefone.value){
      erroPessoaTelefone.set(erro);
      ok = false;
    }else{
      erroPessoaTelefone.set(null);
    }

    if(!validaEmail.value){
      erroEmail.set(erro);
      ok = false;
    }else{
      if(!emailValido()){
        erroEmail.set("Email invalido");
        ok = false;
      }else {
        erroEmail.set(null);
      }
    }

    if(!validaCargo.value){
      erroCargo.set(erro);
      ok = false;
    }else{
      erroCargo.set(null);
    }

    if(!validaSenha.value){
      erroSenha.set(erro);
      ok = false;
    }else{
      if(senha.toString().length < 8){
        erroSenha.set("Senha deve ter pelo menos 8 caracteres");
        ok = false;
      }else {
        erroSenha.set(null);
      }
    }

    if(!validaConfirmaSenha.value){
      erroConfirmarSenha.set(erro);
      ok = false;
    }else{
      if(senha.value != confirmaSenha.value){
        erroConfirmarSenha.set('senhas diferentes');
        erroSenha.value == null ?
          erroSenha.set('senhas diferentes') : erroSenha ;
        ok = false;
      }else{
        erroConfirmarSenha.set(null);
        erroSenha.value == null ?
         erroSenha.set(null) : erroSenha;
      }
    }

    return ok;
  }

  construirUsuarioDTO(){
    var usuarioDTOBuilder = UsuarioDTOBuilder();

    usuarioDTOBuilder.pessoaNome = pessoaNome.value;
    usuarioDTOBuilder.pessoaTelefone = pessoaTelefone.value;
    usuarioDTOBuilder.pessoaCpf = pessoaCpf.value;
    usuarioDTOBuilder.email = email.value;
    usuarioDTOBuilder.senha = senha.value;
    usuarioDTOBuilder.idUsuarioRequisicao = 1;
    usuarioDTOBuilder.cargo = UsuarioDTOCargoEnum.valueOf(cargo.value);

    return usuarioDTOBuilder.build();
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

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: const TextStyle(fontSize: 22.0)),
    ));
  }

  bool cpfValido() {

    String cpf = pessoaCpf.value;
    cpf = cpf.replaceAll(RegExp(r'[^\d]'), '');

    if (cpf.length != 11) return false;

    if (cpf.split('').toSet().length == 1) return false;

    try {
      List<int> digitos = cpf.split('').map(int.parse).toList();

      int soma = 0;
      for (int i = 0; i < 9; i++) {
        soma += digitos[i] * (10 - i);
      }
      int primeiroDigito = (soma * 10 % 11) % 10;
      if (primeiroDigito != digitos[9]) return false;


      soma = 0;
      for (int i = 0; i < 10; i++) {
        soma += digitos[i] * (11 - i);
      }
      int segundoDigito = (soma * 10 % 11) % 10;
      if (segundoDigito != digitos[10]) return false;

      return true;
    } catch (e) {
      return false;
    }
  }

  bool emailValido() {
   return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email.value);
  }
}