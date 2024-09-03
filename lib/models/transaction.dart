class Transaction {
  int? userId;
  int? kiosqueId;
  DateTime? date;
  double? montant;
  String? numeroDeCompteExpediteur;
  String? numeroDeCompteDestinataire;
  String? statut;
  String? codeRetrait;
  String? type;

  Transaction({
    this.userId,
    this.kiosqueId,
    this.date,
    this.montant,
    this.numeroDeCompteExpediteur,
    this.numeroDeCompteDestinataire,
    this.statut,
    this.codeRetrait,
    this.type,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      userId: json['user_id'],
      kiosqueId: json['kiosque_id'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      montant: json['montant']?.toDouble(),
      numeroDeCompteExpediteur: json['numeroDeCompteExpediteur'],
      numeroDeCompteDestinataire: json['numeroDeCompteDestinataire'],
      statut: json['statut'],
      codeRetrait: json['code_retrait'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'kiosque_id': kiosqueId,
      'date': date?.toIso8601String(),
      'montant': montant,
      'numeroDeCompteExpediteur': numeroDeCompteExpediteur,
      'numeroDeCompteDestinataire': numeroDeCompteDestinataire,
      'statut': statut,
      'code_retrait': codeRetrait,
      'type': type,
    };
  }
}