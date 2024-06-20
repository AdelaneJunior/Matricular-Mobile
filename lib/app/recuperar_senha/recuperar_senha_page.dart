import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matricular/matricular.dart';
import 'package:provider/provider.dart';
import 'package:signals/signals_flutter.dart';

import '../api/matricular_api.dart';
import '../utils/config_state.dart';

class RecuperarSenha extends StatefulWidget {
  const RecuperarSenha({super.key});

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
          child: const RecuperarSenha(),
        ));
  }

  @override
  State<RecuperarSenha> createState() => _RecuperarSenha();
}

class _RecuperarSenha extends State<RecuperarSenha> {

  late UsuarioControllerApi controllerApi;
  final email = signal('');
  final cpf = signal('');
  late final cpfPreenchido = computed(() => cpf().isNotEmpty);
  late final emailPreenchido = computed(() => email().isNotEmpty );

  final erroEmail = signal<String?>(null);
  final cpfErro = signal<String?>(null);

  validaRecuperarSenha() {
    bool emailValido = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email());

    if (!emailValido) {
      erroEmail.set('Email inválido');
    }
    erroEmail.set(null);
    
    if(cpf.get().length != 11){
      cpfErro.set('CPF inválido');
    }
    cpfErro.set(null);

    if(cpfErro.get() == null && erroEmail.get() == null){
      enviaEmail();
    }
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: const TextStyle(fontSize: 22.0)),
    ));
  }

  enviaEmail() async{
    var redefinirSenha = RedefinirSenhaDTOBuilder();
    redefinirSenha.cpf = cpf.get().toString();
    redefinirSenha.email = email.get().toString();
    try{
    var response  = await controllerApi.usuarioControllerRedefinirSenha(redefinirSenhaDTO: redefinirSenha.build());

    if(response.statusCode == 200){
      showMessage(context, "Email enviado com sucesso");
    }else{
      showMessage(context, response.statusMessage.toString());
    }
    }on DioException catch(erro){
      showMessage(context, erro.response?.data["message"]);
    }

  }

  @override
  Widget build(BuildContext context) {
    controllerApi =
        context.read<AppAPI>().api.getUsuarioControllerApi();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Recuperar Senha'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          height: MediaQuery.of(context).size.height - 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Flexible(
                flex: 6,
                child: FractionallySizedBox(
                  widthFactor: 0.6,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage('assets/images/imagem4_logo.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              Flexible(
                  flex: 3,
                  child: TextField(
                    onChanged: email.set,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: const Text("Email da conta"),
                         errorText: erroEmail.watch(context)),
                  )),
              const Spacer(
                flex: 1,
              ),
              Flexible(
                  flex: 3,
                  child: TextField(
                    onChanged: cpf.set,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: const Text("Cpf do usuario"),
                        errorText: cpfErro.watch(context)),
                  )),
              const Spacer(
                flex: 1,),
              Flexible(
                flex: 3,
                child: FractionallySizedBox(
                  widthFactor: 0.6,
                  heightFactor: 0.4,
                  child: FilledButton(
                    onPressed: emailPreenchido.watch(context) && cpfPreenchido.watch(context)
                        ? validaRecuperarSenha
                        : null,
                    child: const Text('Enviar nova senha'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
