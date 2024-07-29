import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lista_com_descricao_app/_common/inicio_modal.dart';
import 'package:flutter_lista_com_descricao_app/_common/minhas_cores.dart';
import 'package:flutter_lista_com_descricao_app/components/inicio_lista_widget.dart';
import 'package:flutter_lista_com_descricao_app/mods/exercicio_modl.dart';
import 'package:flutter_lista_com_descricao_app/services/autenticacao_services.dart';
import 'package:flutter_lista_com_descricao_app/services/exercicio_servico.dart';

class InicioTela extends StatefulWidget {
  final User user;
  const InicioTela({super.key, required this.user});

  @override
  State<InicioTela> createState() => _InicioTelaState();
}

class _InicioTelaState extends State<InicioTela> {
  final ExercicioServico servico = ExercicioServico();

  bool isDecrecente = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MinhasCores.padraoBaixoGradiente,
        appBar: AppBar(
          title: const Text("Exercícios"),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isDecrecente = !isDecrecente;
                });
              },
              icon: const Icon(Icons.sort_by_alpha_rounded),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage("assets/fotoDeperfil.jpg"),
                ),
                accountName: Text((widget.user.displayName != null)
                    ? widget.user.displayName!
                    : ""),
                accountEmail: Text(widget.user.email!),
              ),
              ListTile(
                leading: const Icon(Icons.logout_rounded),
                title: const Text("Sair"),
                onTap: () {
                  AutenticacaoServicos().deslogar();
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: MinhasCores.padraoTopGradiente,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100))),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            mostarModalInicio(context);
          },
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: StreamBuilder(
              stream: servico.conecatarStreamExercicios(isDecrecente),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.docs.isNotEmpty) {
                    List<ExercicioModelo> listaExercicio = [];
                    for (var doc in snapshot.data!.docs) {
                      listaExercicio.add(ExercicioModelo.fromMap(doc.data()));
                    }

                    return ListView(
                      children: List.generate(
                        listaExercicio.length,
                        (index) {
                          ExercicioModelo exercicioModelo =
                              listaExercicio[index];
                          return InicioItemLista(
                              exercicioModelo: exercicioModelo,
                              servico: servico);
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("Ainda nemhum exercicio foi adicinado."),
                    );
                  }
                }
              }),
        ));
  }
}
