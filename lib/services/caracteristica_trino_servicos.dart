import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_lista_com_descricao_app/mods/caracteristicas_do_trino_modelo.dart';

class CaracteristicasDeTreinoServico {
  String userId;
  CaracteristicasDeTreinoServico()
      : userId = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String keyColecao = "caracteristicas";

  Future<void> adicinarCaracteristaDoTreino(
      {required String idExercicio,
      required CaracteristicasDoTreinoModelo
          caracteristicaDotrinoModelo}) async {
    return await _firestore
        .collection(userId)
        .doc(idExercicio)
        .collection(keyColecao)
        .doc(caracteristicaDotrinoModelo.id)
        .set(caracteristicaDotrinoModelo.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> conectarSream(
      {required String idExercicio}) {
    return _firestore
        .collection(userId)
        .doc(idExercicio)
        .collection(keyColecao)
        .orderBy("data", descending: true)
        .snapshots();
  }

  Future<void> removerCaracteristicas(
      {required String exercicioId, required String caracteristicasId}) async {
    return _firestore
        .collection(userId)
        .doc(exercicioId)
        .collection(keyColecao)
        .doc(caracteristicasId)
        .delete();
  }
}
