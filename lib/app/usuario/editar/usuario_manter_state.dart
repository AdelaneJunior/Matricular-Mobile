import 'package:signals/signals.dart';

class UsuarioManterState{

  final nomePessoa = signal('');
  final cargo = signal('');
  final email = signal('');
  final telefone = signal('');
  final senha = signal('');
  final senhaAntiga = signal('');
  late final int idUsuario;
  late final String cpf;

  final nomePessoaErro = signal<String?>(null);
  final cargoErro = signal<String?>(null);
  final emailErro = signal<String?>(null);
  final telefoneErro = signal<String?>(null);
  final senhaErro = signal<String?>(null);
  final senhaAntigaErro = signal<String?>(null);

  late final pessoaNomePreenchido = computed(() => nomePessoa != null &&
      nomePessoa.toString() != '');
  late final emailPreenchido = computed(() => email != null &&
      email.toString() != '');
  late final pessoaTelefonePreenchido = computed(() => telefone != null &&
      telefone.toString() != '');
  late final cargoPreenchido = computed(() => cargo != null &&
      cargo.toString() != '');
  late final senhaPreenchido = computed(() => senha != null &&
      senha.toString() != '');
  late final senhaAntigaPreenchida = computed(() => senhaAntiga != null &&
      senhaAntiga.toString() != '');
  late final cpfPreenchido = computed(() => cpf != null &&
      cpf != '');
  late final idPreenchido = computed(() => idUsuario != null);

  bool validaDados() {
    if(pessoaNomePreenchido.value && emailPreenchido.value &&
        cpfPreenchido.value && cargoPreenchido.value &&
        idPreenchido.value && pessoaTelefonePreenchido.value){

      if((senhaAntigaPreenchida.value && senhaPreenchido.value) ||
          (!senhaAntigaPreenchida.value && !senhaPreenchido.value) ){
        return true;
      }
      return false;
    }
    return false;
  }
}