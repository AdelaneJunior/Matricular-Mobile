import 'package:dio/dio.dart';
import 'package:first/app/api/matricular_api.dart';
import 'package:first/routes.dart';
import 'package:flutter/material.dart';
import 'package:matricular/matricular.dart';
import 'package:provider/provider.dart';
import 'package:routefly/routefly.dart';
import 'package:signals/signals_flutter.dart';


import '../utils/config_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
              child: const LoginPage(),
            ));
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final cpf = signal('');
  final senha = signal('');
  late final isValid = computed(() => cpf().isNotEmpty && senha().isNotEmpty);

  AppAPI? appAPI;
  late Matricular matricularApi;

  final erroSenha = signal<String?>(null);
  final erroCpf = signal<String?>(null);
  final erroLogin = signal<String?>(null);

  validaCpf() {
    return true;
  }

  validaSenha() {
    return senha().length > 2;
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: const TextStyle(fontSize: 22.0)),
    ));
  }

  validaLogin() async {
    var okSenha = false;
    var okCpf = false;

    if (!validaSenha()) {
      erroSenha.value = 'Erro! Mínimo de 6 caracteres';
    } else {
      erroSenha.set(null);
      okSenha = true;
    }

    if (!validaCpf()) {
      erroCpf.set('Erro! Cpf inválido');
    } else {
      erroCpf.set(null);
      okCpf = true;
    }

    if (okCpf && okSenha) {
      try {
        final authController = matricularApi.getAuthAPIApi();
        var auth = AuthDTOBuilder();
        auth.login = cpf.toString();
        auth.senha = senha.toString();
        final response = await authController.login(authDTO: auth.build());
        if (response.statusCode == 200) {
          appAPI?.config.token.set(response.data!.accessToken!);
          Routefly.navigate(routePaths.matriculas);
        } else {
          showMessage(context, "Login falhou");
        }
      } on DioException catch (erro) {
        showMessage(
            context,
            (erro.response != null
                ? erro.response?.data["message"]
                : erro.message));
      }
    }
  }

  forgetPassword() {
    debugPrint("ok dsa");
  }

  @override
  Widget build(BuildContext context) {
    appAPI = context.read<AppAPI>();
    matricularApi = appAPI!.api;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Tela de login'),
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
                      padding: EdgeInsets.all(0),
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
                    onChanged: cpf.set,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: const Text("CPF"),
                        errorText: erroCpf.watch(context)),
                  )),
              const Spacer(
                flex: 1,
              ),
              Flexible(
                  flex: 3,
                  child: TextField(
                    onChanged: senha.set,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: const Text("Senha"),
                        errorText: erroSenha.watch(context)),
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                  )),
              const Spacer(
                flex: 1,
              ),
              Flexible(
                flex: 3,
                child: FractionallySizedBox(
                  widthFactor: 0.4,
                  heightFactor: 0.4,
                  child: FilledButton(
                    onPressed: isValid.watch(context) ? validaLogin : null,
                    child: const Text('Entrar'),
                  ),
                ),
              ),
              // const Spacer(
              //   flex: 0,
              // ),
              Flexible(
                  flex: 3,
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    heightFactor: 0.4,
                    child: TextButton(
                      onPressed: () {
                        Routefly.pushNavigate(routePaths.recuperarSenha);
                      },
                      child: const Text('Esqueceu a senha'),
                    ),
                  )),
              Flexible(
                  flex: 3,
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    heightFactor: 0.4,
                    child: TextButton(
                      onPressed: () {
                        Routefly.pushNavigate(routePaths.prefs);
                      },
                      child: const Text('Prefs url'),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
