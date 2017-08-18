view: piece {
  sql_table_name: public.piece ;;

  dimension: base {
    type: string
    sql: ${TABLE}.base ;;
  }

  dimension: code_devise {
    type: string
    sql: ${TABLE}.cd_devise ;;
  }

  dimension: code_etat_de_la_piece {
    type: string
    sql: ${TABLE}.cd_etat_piece ;;
  }

  dimension: code_type_de_piece {
    type: string
    sql: ${TABLE}.cd_piece ;;
  }

  dimension: correspondant {
    type: string
    sql: ${TABLE}.corresp ;;
  }

  dimension: references_du_correspondant {
    type: string
    sql: ${TABLE}.corresp_ref ;;
  }

  dimension: delai_de_forclusion {
    type: number
    sql: ${TABLE}.forclusion_delai ;;
  }

  dimension_group: date_debut_forclusion_de_la_piece {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.forclusion_dt ;;
  }

  dimension: identifiant_client {
    type: string
    sql: ${TABLE}.id_cli ;;
  }

  dimension: referentiel_piece_client {
    type: string
    sql: ${TABLE}.id_clipiece ;;
  }

  dimension: identifiant_debiteur {
    type: string
    sql: ${TABLE}.id_deb ;;
  }

  dimension: identifiant_piece {
    type: string
    primary_key: yes
    sql: ${TABLE}.id_piece ;;
  }

  dimension: libelle_de_la_piece {
    type: string
    sql: ${TABLE}.lib_piece ;;
  }

  dimension: montant_de_la_piece {
    type: number
    sql: ${TABLE}.mtt_piece_dev ;;
  }

  dimension: nature_creance {
    type: string
    sql: ${TABLE}.nat_creance ;;
  }

  dimension: origine_de_la_piece {
    type: string
    sql: ${TABLE}.orig_piece ;;
  }

  dimension_group: date_de_depart_de_la_piece {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.piece_dep_dt ;;
  }

  dimension_group: date_de_la_piece {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.piece_dt ;;
  }

#   dimension: type_de_piece {
#     type: string
#     sql: ${TABLE}.piece_typ ;;
#   }

  dimension: piece_de_principal_de_reference {
    type: string
    sql: ${TABLE}.piecerefprin ;;
  }

  dimension: reference_client_ou_judiciaire {
    type: string
    sql: ${TABLE}.pierefcli ;;
  }

  dimension_group: date_prise_en_charge_dette {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.prisecharg_dt ;;
  }

  dimension: reference_produit_client {
    type: string
    sql: ${TABLE}.produitcli_ref ;;
  }

  dimension: sens_de_la_piece {
    type: string
    sql: ${TABLE}.sens_piece ;;
  }

  dimension: affecte_principal {
    type: string
    sql: ${TABLE}.top_affecte_princ ;;
  }

  dimension: soumission_a_honoraire {
    type: string
    sql: ${TABLE}.top_hono_piece ;;
  }

  dimension: recuperable {
    type: string
    sql: ${TABLE}.top_recup_piece ;;
  }

  dimension: si_calcul_interet {
    type: string
    sql: ${TABLE}.ttrait ;;
  }

  dimension: taux_TVA_sur_dette {
    type: number
    sql: ${TABLE}.tva_piece ;;
  }

  dimension: taux_des_interets {
    type: number
    sql: ${TABLE}.tx_int_piece ;;
  }

  dimension: type_de_piece {
    type: string
    sql: substring(${piece.code_type_de_piece},1,1) ;;
  }

  dimension: delai_piece_depuis_ouverture_dossier {
    type: number
    sql: datediff(day,${debiteur.date_ouverture_raw},${piece.date_prise_en_charge_dette_raw}) ;;
  }

  dimension: top_piece_principal {
    type: number
    sql: case when ${piece.type_de_piece}='1' then 1 else 0 end ;;
  }

  dimension: montant_principal_a_date {
    type: number
    sql: ${piece.montant_de_la_piece}*${piece.top_piece_principal} ;;
  }

  measure: nombre_de_pieces {
    type: count
    drill_fields: []
  }

  measure: montant_total_principal_a_date {
    type: sum
    sql:  ${piece.montant_principal_a_date} ;;
    value_format_name: eur_0
    drill_fields: [Detail_des_dossiers_a_date*]
  }

  measure: montant_moyen_principal_a_date {
    type: average
    sql:  ${piece.montant_principal_a_date} ;;
    value_format_name: eur_0
    drill_fields: [Detail_des_dossiers_a_date*]
  }


  measure: montant_principal_et_frais_et_interet {
    type: sum
    sql:  ${piece.montant_de_la_piece} ;;
    filters:  {
      field:  type_de_piece
      value: "1,2"
    }
    value_format_name: eur_0
    drill_fields: [Detail_des_dossiers_a_date*,montant_principal_et_frais_et_interet]
  }

  measure: montant_principal_origine {
    type: sum
    sql: ${piece.montant_de_la_piece}  ;;
    filters: {
      field: delai_piece_depuis_ouverture_dossier
      value: "0"
    }
    value_format_name: eur_0
    drill_fields: [Detail_des_dossiers_origine*]
  }

  set: Detail_des_dossiers_a_date {
    fields: [debiteur.identifiant_debiteur,
      debiteur.date_ouverture_date,
      debiteur.date_de_cloture_date,
      encaissement.montant_total_encaissements_hors_bloque_en_facturation,
      piece.montant_total_principal_a_date,
      debiteur.code_postal,
      debiteur.ville]
  }
  set: Detail_des_dossiers_origine {
    fields: [debiteur.identifiant_debiteur,
      debiteur.date_ouverture_date,
      debiteur.date_de_cloture_date,
      encaissement.montant_total_encaissements_hors_bloque_en_facturation,
      piece.montant_principal_origine,
      debiteur.code_postal,
      debiteur.ville]
  }
}
