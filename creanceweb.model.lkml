connection: "redshift_cluster_creanceweb"

# include all the views

include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: debiteur {
  join: encaissement {
    sql_on: ${debiteur.identifiant_debiteur} = ${encaissement.identifiant_debiteur} ;;
    relationship: one_to_many
  }
  join: piece {
    sql_on: ${debiteur.identifiant_debiteur} = ${piece.identifiant_debiteur} ;;
    relationship: one_to_many
  }
  join: aggregat_debiteur {
    sql_on: ${debiteur.identifiant_debiteur} = ${aggregat_debiteur.identifiant_debiteur} ;;
    relationship: one_to_one
  }
  join:  echeancier {
    sql_on: ${debiteur.identifiant_debiteur}=${echeancier.identifiant_debiteur} ;;
    relationship: one_to_many
  }
  join: vue_chonique_encaissement {
    sql_on: ${debiteur.identifiant_debiteur}=${vue_chonique_encaissement.identifiant_debiteur} ;;
    relationship: one_to_many
  }
}

map_layer: France_departements {
  file: "france_departements.json"
  property_key: "code"
}
