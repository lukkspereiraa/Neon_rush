import 'package:flutter/material.dart';
import 'package:flutter_lista_com_descricao_app/mods/caracteristicas_do_trino_modelo.dart';
import 'package:flutter_lista_com_descricao_app/services/caracteristica_trino_servicos.dart';
import 'package:uuid/uuid.dart';

Future<dynamic> mostarAdicinarEditarCaracteristicasDoTreinoDialog(
  BuildContext context, {
  required String idExercicio,
  CaracteristicasDoTreinoModelo? volumeDeTreinoModelo,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      TextEditingController seriesController = TextEditingController();
      TextEditingController repeticesController = TextEditingController();
      TextEditingController cargaController = TextEditingController();

      if (volumeDeTreinoModelo != null) {
        seriesController.text = volumeDeTreinoModelo.series;
        repeticesController.text = volumeDeTreinoModelo.repeticao;
        cargaController.text = volumeDeTreinoModelo.carga;
      }

      return AlertDialog(
        title: const Text("Volume do exercicio"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: seriesController,
              decoration: const InputDecoration(
                label: Text("Séries"),
              ),
            ),
            TextFormField(
              controller: repeticesController,
              decoration: const InputDecoration(
                label: Text("Repetições"),
              ),
            ),
            TextFormField(
              controller: cargaController,
              decoration: const InputDecoration(
                label: Text("Carga"),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              CaracteristicasDoTreinoModelo volumeDeTreino =
                  CaracteristicasDoTreinoModelo(
                      repeticao: repeticesController.text,
                      series: seriesController.text,
                      carga: cargaController.text,
                      data: DateTime.now().toString(),
                      id: const Uuid().v1());
              if (volumeDeTreinoModelo != null) {
                volumeDeTreino.id = volumeDeTreinoModelo.id;
              }
              CaracteristicasDeTreinoServico().adicinarCaracteristaDoTreino(
                  idExercicio: idExercicio,
                  caracteristicaDotrinoModelo: volumeDeTreino);

              Navigator.pop(context);
            },
            child: Text(volumeDeTreinoModelo != null ? "Editar" : "Criar"),
          )
        ],
      );
    },
  );
}
