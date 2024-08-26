// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum TipoParceiro {
  cnpj,
  cpf
}

class Parceiro {
  String nome;
  TipoParceiro tipo;
  String cpfCnpj;

  Parceiro({
    required this.nome,
    required this.tipo,
    required this.cpfCnpj,
  });

  Parceiro copyWith({
    String? nome,
    TipoParceiro? tipo,
    String? cpfCnpj,
  }) {
    return Parceiro(
      nome: nome ?? this.nome,
      tipo: tipo ?? this.tipo,
      cpfCnpj: cpfCnpj ?? this.cpfCnpj,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'tipo': tipo.name.toUpperCase(),
      'cpfCnpj': cpfCnpj,
    };
  }

  factory Parceiro.fromMap(Map<String, dynamic> map) {
    return Parceiro(
      nome: map['nome'] as String,
      tipo: TipoParceiro.values.byName((map['tipo'] as String).toLowerCase()),
      cpfCnpj: map['cpfCnpj'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Parceiro.fromJson(String source) => Parceiro.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Parceiro(nome: $nome, tipo: $tipo, cpfCnpj: $cpfCnpj)';

  @override
  bool operator ==(covariant Parceiro other) {
    if (identical(this, other)) return true;
  
    return 
      other.nome == nome &&
      other.tipo == tipo &&
      other.cpfCnpj == cpfCnpj;
  }

  @override
  int get hashCode => nome.hashCode ^ tipo.hashCode ^ cpfCnpj.hashCode;
}
