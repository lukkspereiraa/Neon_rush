class CaracteristicasDoTreinoModelo {
  String id;
  String data;
  String repeticao;
  String carga;
  String series;

  CaracteristicasDoTreinoModelo(
      {required this.id,
      required this.data,
      required this.carga,
      required this.repeticao,
      required this.series});
  CaracteristicasDoTreinoModelo.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        data = map["data"],
        repeticao = map["repeticao"],
        carga = map["carga"],
        series = map["series"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "data": data,
      carga: "carga",
      repeticao: "repeticao",
      series: "series"
    };
  }
}
