import 'package:flutter/material.dart';
import 'package:flutter_lista_com_descricao_app/_common/minhas_cores.dart';
import 'package:flutter_lista_com_descricao_app/components/adincar_editar_caracteristicas_de_trino_modal.dart';
import 'package:flutter_lista_com_descricao_app/mods/exercicio_modl.dart';
import 'package:flutter_lista_com_descricao_app/mods/caracteristicas_do_trino_modelo.dart';
import 'package:flutter_lista_com_descricao_app/services/caracteristica_trino_servicos.dart';

class ExercicoTela extends StatelessWidget {
  final ExercicioModelo exercicioModelo;
  ExercicoTela({super.key, required this.exercicioModelo});

  CaracteristicasDeTreinoServico _caracteristicasDeTreinoServico =
      CaracteristicasDeTreinoServico();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MinhasCores.escuraPadrao,
      appBar: AppBar(
        toolbarHeight: 72,
        centerTitle: true,
        backgroundColor: MinhasCores.padraoTopGradiente,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(32))),
        elevation: 0,
        title: Column(
          children: [
            Text(
              exercicioModelo.nome,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white),
            ),
            Text(
              "Treino ${exercicioModelo.treino}",
              style: const TextStyle(fontSize: 15, color: Colors.white),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100))),
        backgroundColor: MinhasCores.escuraPadrao,
        onPressed: () {
          mostarAdicinarEditarCaracteristicasDoTreinoDialog(context,
              idExercicio: exercicioModelo.id);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: ListView(
          children: [
            SizedBox(
              height: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>((states) {
                          return MinhasCores.escuraPadrao;
                        }),
                        shape: MaterialStateProperty.resolveWith((states) =>
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)))),
                    onPressed: () {},
                    child: const Text(
                      'Enviar foto',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>((states) {
                          return MinhasCores.escuraPadrao;
                        }),
                        shape: MaterialStateProperty.resolveWith((states) =>
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)))),
                    onPressed: () => {},
                    child: const Text(
                      "Tirar foto",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Como fazer?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(exercicioModelo.comoFazer),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(color: Colors.black),
            ),
            const Text(
              "Historico nesse exercicio",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            StreamBuilder(
              stream: _caracteristicasDeTreinoServico.conectarSream(
                  idExercicio: exercicioModelo.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.docs.isNotEmpty) {
                    final List<CaracteristicasDoTreinoModelo>
                        listaDeCaracteristicasDosTreinos = [];

                    for (var doc in snapshot.data!.docs) {
                      listaDeCaracteristicasDosTreinos.add(
                          CaracteristicasDoTreinoModelo.fromMap(doc.data()));
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        listaDeCaracteristicasDosTreinos.length,
                        (index) {
                          CaracteristicasDoTreinoModelo treinoDeAtual =
                              listaDeCaracteristicasDosTreinos[index];
                          return ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                                "${treinoDeAtual.series} de ${treinoDeAtual.repeticao}"),
                            subtitle: Text(
                                "${treinoDeAtual.carga} carga da data ${treinoDeAtual.data}"),
                            leading: const Icon(Icons.double_arrow_rounded),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _caracteristicasDeTreinoServico
                                        .removerCaracteristicas(
                                            exercicioId: exercicioModelo.id,
                                            caracteristicasId: treinoDeAtual.id);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Text(
                        "Nenhuma anotcao do seu volume de treino");
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
