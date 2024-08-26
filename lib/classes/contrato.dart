// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dealmaster/classes/parceiro.dart';
import 'package:dealmaster/classes/usuario.dart';

class Contrato {
  Usuario usuario;
  Parceiro parceiro;
  String texto;
  DateTime dataVencimento;

  Contrato({
    required this.usuario,
    required this.parceiro,
    required this.texto,
    required this.dataVencimento,
  });

  Contrato copyWith({
    Usuario? usuario,
    Parceiro? parceiro,
    String? texto,
    DateTime? dataVencimento,
  }) {
    return Contrato(
      usuario: usuario ?? this.usuario,
      parceiro: parceiro ?? this.parceiro,
      texto: texto ?? this.texto,
      dataVencimento: dataVencimento ?? this.dataVencimento,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'usuario': usuario.toMap(),
      'parceiro': parceiro.toMap(),
      'texto': texto,
      'dataVencimento': dataVencimento.millisecondsSinceEpoch,
    };
  }

  factory Contrato.fromMap(Map<String, dynamic> map) {
    return Contrato(
      usuario: Usuario.fromMap(map['usuario'] as Map<String,dynamic>),
      parceiro: Parceiro.fromMap(map['parceiro'] as Map<String,dynamic>),
      texto: map['texto'] as String,
      dataVencimento: DateTime.parse(map['dataVencimento'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Contrato.fromJson(String source) => Contrato.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contrato(usuario: $usuario, parceiro: $parceiro, texto: $texto, dataVencimento: $dataVencimento)';
  }

  @override
  bool operator ==(covariant Contrato other) {
    if (identical(this, other)) return true;
  
    return 
      other.usuario == usuario &&
      other.parceiro == parceiro &&
      other.texto == texto &&
      other.dataVencimento == dataVencimento;
  }

  @override
  int get hashCode {
    return usuario.hashCode ^
      parceiro.hashCode ^
      texto.hashCode ^
      dataVencimento.hashCode;
  }
}
