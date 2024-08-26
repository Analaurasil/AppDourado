// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Empresa {
  String cnpj;
  String nome;
  
  Empresa({
    required this.cnpj,
    required this.nome,
  });

  Empresa copyWith({
    String? cnpj,
    String? nome,
  }) {
    return Empresa(
      cnpj: cnpj ?? this.cnpj,
      nome: nome ?? this.nome,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cnpj': cnpj,
      'nome': nome,
    };
  }

  factory Empresa.fromMap(Map<String, dynamic> map) {
    return Empresa(
      cnpj: map['cnpj'] as String,
      nome: map['nome'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Empresa.fromJson(String source) => Empresa.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Empresa(cnpj: $cnpj, nome: $nome)';

  @override
  bool operator ==(covariant Empresa other) {
    if (identical(this, other)) return true;
  
    return 
      other.cnpj == cnpj &&
      other.nome == nome;
  }

  @override
  int get hashCode => cnpj.hashCode ^ nome.hashCode;
}
