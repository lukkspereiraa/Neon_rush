import 'package:flutter/material.dart';
import 'package:flutter_lista_com_descricao_app/_common/minhas_cores.dart';
import 'package:flutter_lista_com_descricao_app/_common/my_snackbar.dart';
import 'package:flutter_lista_com_descricao_app/components/decoration_text_form_fild.dart';
import 'package:flutter_lista_com_descricao_app/services/autenticacao_services.dart';

class AutenticacoTela extends StatefulWidget {
  const AutenticacoTela({super.key});

  @override
  State<AutenticacoTela> createState() => _AutenticacoTelaState();
}

class _AutenticacoTelaState extends State<AutenticacoTela> {
  bool queroEntar = true;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _comfirmarSenha = TextEditingController();
  final _nomeController = TextEditingController();

  final AutenticacaoServicos _autenticacaoServicos = AutenticacaoServicos();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MinhasCores.escuraPadrao,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  MinhasCores.padraoTopGradiente,
                  MinhasCores.padraoBaixoGradiente
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        height: 225,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: getAuthenticationInputDecoration("E-mail"),
                        validator: (String? value) {
                          if (value == null) {
                            return "E-mail não pode ser vazio";
                          }
                          if (value.length < 5) {
                            return "E-mail muito curto";
                          }
                          if (!value.contains("@")) {
                            return "E-mail não valido";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _senhaController,
                        decoration: getAuthenticationInputDecoration("Senha"),
                        validator: (String? value) {
                          if (value == null) {
                            return "Senha vazia";
                          }
                          if (value.length < 8) {
                            return "Senha muito curta";
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      const SizedBox(height: 8),
                      Visibility(
                        visible: !queroEntar,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _comfirmarSenha,
                              decoration: getAuthenticationInputDecoration(
                                  "Comfirme a senha"),
                              obscureText: true,
                              validator: (String? value) {
                                if (value == null) {
                                  return "Senha nula";
                                }
                                if (value.length < 8) {
                                  return "Senha muito curta";
                                }
                                if (_comfirmarSenha.value !=
                                    _senhaController.value) {
                                  return "Sua senha não esta correta";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _nomeController,
                              decoration: getAuthenticationInputDecoration(
                                  "Nome de usuario"),
                              validator: (String? value) {
                                if (value == null) {
                                  return "Nome não valido";
                                }
                                if (value.length < 3) {
                                  return "Nome muito curto";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => MinhasCores.escuraPadrao)),
                        onPressed: () => botaoPrincipalCLicado(),
                        child: Text(
                          (queroEntar) ? "Entrar" : "Cadastar",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            queroEntar = !queroEntar;
                          });
                        },
                        child: Text(
                          (queroEntar)
                              ? "Ainda nao tem uma conta? Cadastre-se"
                              : "Já tem uma conta? Entar",
                          style:
                              const TextStyle(color: MinhasCores.escuraPadrao),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  botaoPrincipalCLicado() {
    String email = _emailController.text;
    String nome = _nomeController.text;
    String senha = _senhaController.text;
    if (_formKey.currentState!.validate()) {
      if (queroEntar) {
        print("Entrada validada");
        _autenticacaoServicos
            .logarUsuarios(email: email, senha: senha)
            .then((String? erro) {
          if (erro != null) {
            mostarSnackbar(context: context, texto: erro);
          }
        });
      } else {
        print("Cadatro validado");
        print(
            "${_emailController.text}, ${_senhaController.text}, ${_comfirmarSenha.text} ${_nomeController.text}");
        _autenticacaoServicos
            .cadastarUsuario(nome: nome, email: email, senha: senha)
            .then((String? erro) {
          //erro recebido
          if (erro != null) {
            mostarSnackbar(context: context, texto: erro);
          } else {
            //retorno sem erro
            mostarSnackbar(
                context: context, texto: "Cadastro efetuado", isErro: false);
          }
        });
      }
    } else
      print("form invalido");
  }
}
