import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_lista_com_descricao_app/mods/exercicio_modl.dart';
import 'package:flutter_lista_com_descricao_app/mods/caracteristicas_do_trino_modelo.dart';

class ExercicioServico {
  String userId;
  ExercicioServico() : userId = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> adicinarExercicio(ExercicioModelo exercicioModelo) async {
    await _firestore
        .collection(userId)
        .doc(exercicioModelo.id)
        .set(exercicioModelo.toMap());
  }

  Future<void> adicinarCaracteristaDoTreino(String idExercicio,
      CaracteristicasDoTreinoModelo caracteristicaDotrinoModelo) async {
    return await _firestore
        .collection(userId)
        .doc(idExercicio)
        .collection("caracteristicas")
        .doc(caracteristicaDotrinoModelo.id)
        .set(caracteristicaDotrinoModelo.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> conecatarStreamExercicios(
      bool isDecresent) {
    return _firestore
        .collection(userId)
        .orderBy("treino", descending: isDecresent)
        .snapshots();
  }

  Future<void> removerExercicio({required String idExercicio}) {
    return _firestore.collection(userId).doc(idExercicio).delete();
  }
}
