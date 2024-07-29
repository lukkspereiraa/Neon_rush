import 'package:flutter/material.dart';
import 'package:flutter_lista_com_descricao_app/_common/minhas_cores.dart';
import 'package:flutter_lista_com_descricao_app/mods/exercicio_modl.dart';
import 'package:flutter_lista_com_descricao_app/mods/caracteristicas_do_trino_modelo.dart';

class ExercicoTela extends StatelessWidget {
  final ExercicioModelo exercicioModelo;
  ExercicoTela({super.key, required this.exercicioModelo});

  final List<CaracteristicasDoTreinoModelo> listaDeCaracteristicasDosTreinos = [
    CaracteristicasDoTreinoModelo(
        id: '001',
        data: '2024-02-21',
        carga: "20 kg",
        repeticao: "12",
        series: "4"),
    CaracteristicasDoTreinoModelo(
        id: "002",
        data: "2024-03-21",
        series: "4",
        carga: "20 kg",
        repeticao: "12"),
  ];

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
        onPressed: () {},
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
            Column(
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
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        print("Deletear ${treinoDeAtual.data}");
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
