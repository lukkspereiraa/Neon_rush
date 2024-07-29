import 'package:flutter/material.dart';
import 'package:flutter_lista_com_descricao_app/_common/minhas_cores.dart';

import 'package:flutter_lista_com_descricao_app/mods/exercicio_modl.dart';
import 'package:flutter_lista_com_descricao_app/services/exercicio_servico.dart';

import '../_common/inicio_modal.dart';
import '../screens/exercicio.dart';

class InicioItemLista extends StatelessWidget {
  final ExercicioModelo exercicioModelo;
  final ExercicioServico servico;
  const InicioItemLista(
      {super.key, required this.exercicioModelo, required this.servico});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExercicoTela(
              exercicioModelo: exercicioModelo,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.black.withAlpha(100),
              spreadRadius: 1,
              offset: const Offset(2, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: const BoxDecoration(
                  color: MinhasCores.padraoTopGradiente,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                ),
                height: 40,
                width: 150,
                child: Center(
                  child: Text(
                    exercicioModelo.treino,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          exercicioModelo.nome,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: MinhasCores.padraoTopGradiente,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => mostarModalInicio(context,
                                  exercicio: exercicioModelo)),
                          IconButton(
                            onPressed: () {
                              SnackBar snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                    "Deseja apagar? ${exercicioModelo.nome}"),
                                action: SnackBarAction(
                                  label: "REMOVER",
                                  textColor: Colors.white,
                                  onPressed: () {
                                    servico.removerExercicio(
                                        idExercicio: exercicioModelo.id);
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 150,
                          child: Text(
                            exercicioModelo.comoFazer,
                            overflow: TextOverflow.ellipsis,
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
