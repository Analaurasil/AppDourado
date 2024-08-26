// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dealmaster/classes/empresa.dart';

enum TipoUsuario {
  funcionario,
  gerente
}

class Usuario {
  String nome;
  String email;
  TipoUsuario tipo;
  Empresa empresa;
  Usuario({
    required this.nome,
    required this.email,
    required this.tipo,
    required this.empresa,
  });

  Usuario copyWith({
    String? nome,
    String? email,
    TipoUsuario? tipo,
    Empresa? empresa,
  }) {
    return Usuario(
      nome: nome ?? this.nome,
      email: email ?? this.email,
      tipo: tipo ?? this.tipo,
      empresa: empresa ?? this.empresa,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'email': email,
      'tipo': tipo.name.toUpperCase(),
      'empresa': empresa.toMap(),
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      nome: map['nome'] as String,
      email: map['email'] as String,
      tipo: TipoUsuario.values.byName((map['tipo'] as String).toLowerCase()),
      empresa: Empresa.fromMap(map['empresa'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) => Usuario.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Usuario(nome: $nome, email: $email, tipo: $tipo, empresa: $empresa)';
  }

  @override
  bool operator ==(covariant Usuario other) {
    if (identical(this, other)) return true;
  
    return 
      other.nome == nome &&
      other.email == email &&
      other.tipo == tipo &&
      other.empresa == empresa;
  }

  @override
  int get hashCode {
    return nome.hashCode ^
      email.hashCode ^
      tipo.hashCode ^
      empresa.hashCode;
  }
}
