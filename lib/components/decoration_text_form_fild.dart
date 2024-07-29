import 'package:flutter/material.dart';
import 'package:flutter_lista_com_descricao_app/_common/minhas_cores.dart';

InputDecoration getAuthenticationInputDecoration(String label, {Icon? icon}) {
  const double borda = 64;
  return InputDecoration(
    icon: icon,
    hintText: label,
    fillColor: Colors.white,
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borda),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borda),
      borderSide: const BorderSide(color: Colors.black, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borda),
      borderSide: const BorderSide(color: MinhasCores.escuraPadrao, width: 3),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borda),
      borderSide: const BorderSide(color: Colors.red, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borda),
      borderSide: const BorderSide(color: Colors.red, width: 3),
    ),
  );
}
