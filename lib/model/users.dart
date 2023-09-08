class UserModel {
  String? uid;
  String? email;
  String? nom;
  String? prenom;
  String? matricule;
  String? date_naissance;
  String? telephone;
  String? mdp;

  UserModel({this.uid, this.email, this.nom, this.prenom,this.matricule,this.date_naissance,this.telephone,this.mdp});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      nom: map['nom'],
      prenom: map['prenom'],
      matricule: map['matricule'],
      date_naissance: map['date de naissance'],
      telephone: map['telephone'],
      mdp: map['mot de passe'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'nom': nom,
      'prenom': prenom,
      'date de naissance': date_naissance,
      'telephone':telephone,
      'matricule':matricule,
      'mot de passe':mdp,
    };
  }
}