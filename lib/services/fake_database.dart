class FakeDatabase {
  // ======== AUTHENTIFICATION ========
  static String? utilisateurActuel;

  // Comptes avec mot de passe
  static Map<String, String> comptes = {
    "test@example.com": "1234",
    "admin@example.com": "admin",
  };

  // Solde par utilisateur
  static Map<String, int> soldes = {
    "test@example.com": 150000,
    "admin@example.com": 200000,
  };

  // Historique des transactions par utilisateur
  static Map<String, List<Map<String, dynamic>>> historiques = {
    "test@example.com": [],
    "admin@example.com": [],
  };

  // Réclamations par utilisateur
  static Map<String, List<Map<String, dynamic>>> reclamations = {
    "test@example.com": [],
    "admin@example.com": [],
  };

  // ======== AUTH ========
  static bool login(String email, String password) {
    if (comptes.containsKey(email) && comptes[email] == password) {
      utilisateurActuel = email;

      // Crée les structures si elles n'existent pas encore
      soldes.putIfAbsent(email, () => 0);
      historiques.putIfAbsent(email, () => []);
      reclamations.putIfAbsent(email, () => []);

      return true;
    }
    return false;
  }

  static void logout() {
    utilisateurActuel = null;
  }

  // ======== SOLDE ========
  static int getSolde() {
    if (utilisateurActuel != null && soldes.containsKey(utilisateurActuel!)) {
      return soldes[utilisateurActuel!]!;
    }
    return 0;
  }

  static void ajouterSolde(int montant) {
    if (utilisateurActuel != null) {
      soldes[utilisateurActuel!] = getSolde() + montant;
      ajouterTransaction("Dépôt", montant);
    }
  }

  static void retirerSolde(int montant) {
    if (utilisateurActuel != null && getSolde() >= montant) {
      soldes[utilisateurActuel!] = getSolde() - montant;
      ajouterTransaction("Retrait", montant);
    }
  }

  static void envoyer(int montant, String destinataire) {
    if (utilisateurActuel == null) return;
    if (getSolde() < montant) return;

    // Décrément du solde de l'expéditeur
    soldes[utilisateurActuel!] = getSolde() - montant;

    // Incrément du solde du destinataire
    soldes.putIfAbsent(destinataire, () => 0);
    soldes[destinataire] = soldes[destinataire]! + montant;

    // Transaction pour l'expéditeur
    ajouterTransaction("Transfert vers $destinataire", montant);

    // Transaction pour le destinataire
    historiques.putIfAbsent(destinataire, () => []);
    historiques[destinataire]!.add({
      "type": "Reçu de $utilisateurActuel",
      "montant": montant,
      "date": DateTime.now().toString(),
    });
  }

  // ======== HISTORIQUE ========
  static void ajouterTransaction(String type, int montant) {
    if (utilisateurActuel != null) {
      historiques.putIfAbsent(utilisateurActuel!, () => []);
      historiques[utilisateurActuel!]!.add({
        "type": type,
        "montant": montant,
        "date": DateTime.now().toString(),
      });
    }
  }

  static List<Map<String, dynamic>> getHistorique() {
    if (utilisateurActuel != null) {
      return historiques[utilisateurActuel!] ?? [];
    }
    return [];
  }

  // ======== RECLAMATIONS ========
  static void ajouterReclamation(String sujet, String message) {
    if (utilisateurActuel != null) {
      reclamations.putIfAbsent(utilisateurActuel!, () => []);
      reclamations[utilisateurActuel!]!.add({
        "sujet": sujet,
        "message": message,
        "date": DateTime.now().toString(),
      });
    }
  }

  static List<Map<String, dynamic>> getReclamations() {
    if (utilisateurActuel != null) {
      return reclamations[utilisateurActuel!] ?? [];
    }
    return [];
  }

  // ======== PROFIL ========
  static Map<String, dynamic> getProfil() {
    if (utilisateurActuel != null) {
      return {
        "email": utilisateurActuel!,
        "solde": getSolde(),
      };
    }
    return {};
  }

  // ======== MOT DE PASSE ========
  static bool changerMotDePasse(String ancien, String nouveau) {
    if (utilisateurActuel != null &&
        comptes[utilisateurActuel!] == ancien) {
      comptes[utilisateurActuel!] = nouveau;
      return true;
    }
    return false;
  }
}
