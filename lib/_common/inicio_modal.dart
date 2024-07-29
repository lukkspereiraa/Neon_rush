import 'package:flutter/material.dart';
import 'package:flutter_lista_com_descricao_app/_common/minhas_cores.dart';
import 'package:flutter_lista_com_descricao_app/components/decoration_text_form_fild.dart';
import 'package:flutter_lista_com_descricao_app/mods/exercicio_modl.dart';
import 'package:flutter_lista_com_descricao_app/mods/caracteristicas_do_trino_modelo.dart';
import 'package:flutter_lista_com_descricao_app/services/exercicio_servico.dart';
import 'package:uuid/uuid.dart';

mostarModalInicio(BuildContext context, {ExercicioModelo? exercicio}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: MinhasCores.padraoTopGradiente,
    isDismissible: false,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
    builder: (context) {
      return ExercicioModal(
        exercicioModelo: exercicio,
      );
    },
  );
}

class ExercicioModal extends StatefulWidget {
  final ExercicioModelo? exercicioModelo;
  const ExercicioModal({super.key, this.exercicioModelo});

  @override
  State<ExercicioModal> createState() => _ExercicioState();
}

class _ExercicioState extends State<ExercicioModal> {
  final TextEditingController _nomeCtrl = TextEditingController();
  final TextEditingController _treinoCtrl = TextEditingController();
  final TextEditingController _anotacoesCtrl = TextEditingController();

  final TextEditingController _seriesCtrl = TextEditingController();
  final TextEditingController _repeticesCtrl = TextEditingController();
  final TextEditingController _cargaCtrl = TextEditingController();

  bool isCarregando = false;

  final ExercicioServico _exercicioServico = ExercicioServico();

  @override
  void initState() {
    if (widget.exercicioModelo != null) {
      _nomeCtrl.text = widget.exercicioModelo!.nome;
      _treinoCtrl.text = widget.exercicioModelo!.treino;
      _anotacoesCtrl.text = widget.exercicioModelo!.comoFazer;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      height: MediaQuery.of(context).size.height * 0.9,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        (widget.exercicioModelo != null)
                            ? "Editar ${widget.exercicioModelo!.nome}"
                            : "Adicinar exercicio",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                      color: Colors.white,
                    )
                  ],
                ),
                const Divider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nomeCtrl,
                      decoration: getAuthenticationInputDecoration(
                        "Nome do exercicio",
                        icon: const Icon(
                          Icons.directions_run_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _treinoCtrl,
                      decoration: getAuthenticationInputDecoration(
                        "Categoria de trino",
                        icon: const Icon(
                          Icons.abc,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _anotacoesCtrl,
                      decoration: getAuthenticationInputDecoration(
                        "Anotaçao que possa lhe ajudar",
                        icon: const Icon(
                          Icons.note_add_sharp,
                          color: Colors.white,
                        ),
                      ),
                      maxLines: null,
                    ),
                    Visibility(
                      visible: (widget.exercicioModelo == null),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _seriesCtrl,
                            decoration: getAuthenticationInputDecoration(
                              "Series",
                              icon: const Icon(
                                Icons.format_list_numbered_sharp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _repeticesCtrl,
                            decoration: getAuthenticationInputDecoration(
                              "Repetices",
                              icon: const Icon(
                                Icons.airline_stops_sharp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _cargaCtrl,
                            decoration: getAuthenticationInputDecoration(
                              "Carga total",
                              icon: const Icon(
                                Icons.line_weight,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                enviarClicado();
              },
              child: (isCarregando)
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        color: MinhasCores.escuraPadrao,
                      ),
                    )
                  : Text((widget.exercicioModelo != null)
                      ? "Editar exercicio"
                      : "Criar exercicio"),
            )
          ],
        ),
      ),
    );
  }

  enviarClicado() {
    setState(
      () {
        isCarregando = true;
      },
    );
    String nome = _nomeCtrl.text;
    String treino = _treinoCtrl.text;
    String anotacao = _anotacoesCtrl.text;
    String series = _seriesCtrl.text;
    String repeticao = _repeticesCtrl.text;
    String carga = _cargaCtrl.text;

    ExercicioModelo exercico = ExercicioModelo(
      id: const Uuid().v1(),
      nome: nome,
      treino: treino,
      comoFazer: anotacao,
    );

    if (widget.exercicioModelo != null) {
      exercico.id = widget.exercicioModelo!.id;
    }

    _exercicioServico.adicinarExercicio(exercico).then((value) {
      if (series  != "" || repeticao != "" || carga != "") {
        CaracteristicasDoTreinoModelo sentimento =
            CaracteristicasDoTreinoModelo(
                id: const Uuid().v1(),
                data: DateTime.now().toString(),
                carga: carga,
                series: series,
                repeticao: repeticao);
        _exercicioServico
            .adicinarCaracteristaDoTreino(exercico.id, sentimento)
            .then((value) {
          setState(() {
            isCarregando = false;
          });
          Navigator.pop(context);
        });
      } else {
        Navigator.pop(context);
      }
      setState(() {
        isCarregando = false;
      });
    });
  }
}
