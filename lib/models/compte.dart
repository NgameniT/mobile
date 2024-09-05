class Compte {
  String? numeroDeCompte;
  double? solde;
  int? userId;

  Compte({
    this.numeroDeCompte,
    this.solde,
    this.userId,
  });

  factory Compte.fromJson(Map<String, dynamic> json) {
    return Compte(
      numeroDeCompte: json['numero_de_compte'],
      solde: json['solde'] != null ? double.tryParse(json['solde']) : null, // Utilisation de double.tryParse
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numero_de_compte': numeroDeCompte,
      'solde': solde,
      'user_id': userId,
    };
  }
}
