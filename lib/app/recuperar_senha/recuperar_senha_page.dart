import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class RecuperarSenha extends StatefulWidget {
  const RecuperarSenha({super.key});

  @override
  State<RecuperarSenha> createState() => _RecuperarSenha();
}

class _RecuperarSenha extends State<RecuperarSenha> {
  final email = signal('');
  late final emailPreenchido = computed(() => email().isNotEmpty );

  final erroEmail = signal<String?>(null);

  validaRecuperarSenha() {
    bool emailValido = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email());

    if (emailValido) {
      erroEmail.set(null);
      debugPrint(email());
      enviaEmail();
      return;
    }
    erroEmail.set('Email inválido');
  }

  enviaEmail(){}

  @override
  Widget build(BuildContext context) {
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
                child: FractionallySizedBox(
                  widthFactor: 0.4,
                  heightFactor: 0.4,
                  child: FilledButton(
                    onPressed: emailPreenchido.watch(context)
                        ? validaRecuperarSenha
                        : null,
                    child: const Text('Enviar email'),
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
