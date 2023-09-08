
class HistoryModel {
  String? uid;
  String? operateur;
  int? montant;
  double? frais;
  double? total;
  String? num_destinataire;
  String? num_destinateur;
  String? date_heure;
  String? status;
  String? text;


  HistoryModel({this.uid, this.operateur, this.montant, this.frais,this.total,this.num_destinataire,this.num_destinateur,this.date_heure,this.status,this.text});

  // receiving data from server
  factory HistoryModel.fromMap(map) {
    return HistoryModel(
      uid: map['uid'],
      operateur: map['operateur'],
      montant: map['montant'],
      frais: map['frais'],
      total: map['total'],
      num_destinateur: map['num_destinateur'],
      num_destinataire: map['num_destinataire'],
      date_heure: map['date_heure'],
      status: map['status'],
      text: map['text'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'operateur': operateur,
      'montant': montant,
      'frais': frais,
      'total': total,
      'num_destinateur':num_destinateur,
      'num_destinataire':num_destinataire,
      'date_heure':date_heure,
      'status':status,
      'text':text,
    };
  }
}