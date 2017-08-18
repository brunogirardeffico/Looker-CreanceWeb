view: encaissement {
  sql_table_name: public.encaissement ;;

  dimension: base {
    type: string
    sql: ${TABLE}.base ;;
  }

  dimension: cd_enc {
    type: string
    sql: ${TABLE}.cd_enc ;;
  }

  dimension :  numero_facture {
    type: string
    sql: ${TABLE}.no_fact ;;
  }

  dimension: cd_reglt {
    type: string
    sql: ${TABLE}.cd_reglt ;;
  }

  dimension: complt {
    type: string
    sql: ${TABLE}.complt ;;
  }

  dimension_group: dossier {
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
    sql: ${TABLE}.dossier_dt ;;
  }

  dimension: dossier_solde {
    type: string
    sql: ${TABLE}.dossier_solde ;;
  }

  dimension_group: echeance {
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
    sql: ${TABLE}.echea_dt ;;
  }

  dimension: encaissement_hors_bloque {
    hidden: yes
    type: number
    sql: CASE WHEN (${numero_facture} <> '9999999' OR ${numero_facture} IS NULL) THEN ${enc1_montant} ELSE NULL END ;;
  }

  dimension: enc1_montant {
    hidden: yes
    type: number
    sql: ${TABLE}.enc1_mtt ;;
  }

  dimension: enc2_montant {
    hidden: yes
    type: number
    sql: ${TABLE}.enc2_mtt ;;
  }

  dimension: enc3_montant {
    hidden: yes
    type: string
    sql: ${TABLE}.enc3_mtt ;;
  }

  dimension: enc4_montant {
    hidden: yes
    type: string
    sql: ${TABLE}.enc4_mtt ;;
  }

  dimension: enc5_montant {
    hidden: yes
    type: string
    sql: ${TABLE}.enc5_mtt ;;
  }

  dimension: encaissement_type {
    type: string
    sql: ${TABLE}.enc_typ ;;
  }

  dimension_group: encaissement {
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
    sql: ${TABLE}.encais_dt ;;
  }

  dimension_group: facture {
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
    sql: ${TABLE}.factur_dt ;;
  }

  dimension: hon_ht {
    type: number
    sql: ${TABLE}.hon_ht ;;
  }

  dimension: hon_ttc {
    type: number
    sql: ${TABLE}.hon_ttc ;;
  }

  dimension: identifiant_debiteur {
    type: string
    sql: ${TABLE}.id_deb ;;
  }

  dimension: id_enc {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.id_enc ;;
  }

  dimension: id_enc_imp {
    hidden: yes
    type: string
    sql: ${TABLE}.id_enc_imp ;;
  }

  dimension: lib_enc {
    type: string
    sql: ${TABLE}.lib_enc ;;
  }

  dimension_group: lot_client {
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
    sql: ${TABLE}.lotcli_dt ;;
  }

  dimension: nu_compt {
    type: string
    sql: ${TABLE}.nu_compt ;;
  }

  dimension: paiement_type {
    type: string
    sql: ${TABLE}.paiement_typ ;;
  }

  dimension: regroup_ligne {
    type: string
    sql: ${TABLE}.regroup_ligne ;;
  }

  dimension_group: remise {
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
    sql: ${TABLE}.remise_dt ;;
  }

  dimension: resx {
    type: string
    sql: ${TABLE}.resx ;;
  }

  dimension: taux_tva {
    type: number
    sql: ${TABLE}.tx_tva ;;
  }

  dimension_group: valeur {
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
    sql: ${TABLE}.valeur_dt ;;
  }

  # Calcul du nombre de jour écoulé entre l'encaissement et la date d'ouverture du dossier
  dimension: nombre_de_jours_pour_encaissement {
    type:  number
    sql: datediff(day,${debiteur.date_ouverture_raw},${encaissement.encaissement_raw}) ;;
  }

  # Si ID_ENC_IMP='V0000000000', c'est un encaissement créditeur.
  # Sinon, c'est un avoir (encaissement débiteur) ID_ENC_IMP correspond à l'encaissement annulé donc signe -1
  dimension:  signe_encaissement {
    type: number
    sql: case when ${encaissement.id_enc_imp}='V0000000000' then 1 else -1 end;;
  }

  # Lorsque le numéro de facture est 9999999 l'encaissement est bloqué en facturation
  dimension:  top_encaissement_bloque_en_facturation {
    type: number
    sql: case when ${encaissement.numero_facture}='9999999' then 0 else 1 end;;
  }

  # Dimension montant encaissement brut
  dimension:  montant_encaissement {
    type: number
    sql: ${encaissement.enc1_montant}*${encaissement.signe_encaissement} ;;
    value_format_name: eur_0
    drill_fields: [Detail_des_dossiers*,montant_encaissement]
  }

  # Dimension montant encaissement sans les encaissements non soumis à facturation (bloqué en facturation)
  dimension:  montant_encaissement_hors_bloque_en_facturation {
    type: number
    sql: ${encaissement.enc1_montant}*${encaissement.signe_encaissement}*${encaissement.top_encaissement_bloque_en_facturation} ;;
    value_format_name: eur_0
    drill_fields: [Detail_des_dossiers*,montant_encaissement_hors_bloque_en_facturation]
  }

  # Mesure Encaissement hors bloqué en facturation
  measure: montant_total_encaissements_hors_bloque_en_facturation {
    group_label: "Montant Encaissements hors bloqué en facturation"
    type: sum
    sql: ${encaissement.montant_encaissement_hors_bloque_en_facturation} ;;
    value_format_name: eur_0
    drill_fields: [Detail_des_dossiers*]
  }

  # Mesure du total encaissement dont bloqué en facturation
  measure: montant_total_encaissements {
    group_label: "Montant Encaissements total"
    type: sum
    sql: ${encaissement.montant_encaissement} ;;
    value_format_name: eur_0
    drill_fields: [Detail_des_dossiers*,montant_total_encaissements]
  }

  # Moyenne des encaissements hors bloqué en facturation
  measure: montant_moyen_des_encaissements_hors_bloque_en_facturation {
    group_label: "Montant moyen des encaissements hors bloqués en facturation"
    type: average
    sql: ${encaissement.montant_encaissement_hors_bloque_en_facturation} ;;
    value_format_name: eur_0
    drill_fields: [Detail_des_dossiers*,montant_moyen_des_encaissements_hors_bloque_en_facturation]
  }

  measure: montant_total_des_encaissements_a_30_jours {
    group_label: "Montant Encaissements"
    type: sum
    sql: ${encaissement.montant_encaissement_hors_bloque_en_facturation} ;;

    filters: {
      field: nombre_de_jours_pour_encaissement
      value: "<=30"
    }
    value_format_name: eur_0
  }

  measure: montant_total_des_encaissements_a_60_jours {
    group_label: "Montant Encaissements"
    type: sum
    sql: ${encaissement.montant_encaissement_hors_bloque_en_facturation} ;;
    filters: {
      field: nombre_de_jours_pour_encaissement
      value: "<=60"
    }
    value_format_name: eur_0
  }

  measure: montant_total_des_encaissements_a_90_jours {
    group_label: "Montant Encaissements"
    type: sum
    sql: ${encaissement.montant_encaissement_hors_bloque_en_facturation};;
    filters: {
      field: nombre_de_jours_pour_encaissement
      value: "<=90"
    }
    value_format_name: eur_0
  }

  measure: montant_total_des_encaissements_a_120_jours {
    group_label: "Montant Encaissements"
    type: sum
    sql: ${encaissement.montant_encaissement_hors_bloque_en_facturation};;
    filters: {
      field: nombre_de_jours_pour_encaissement
      value: "<=120"
    }
    value_format_name: eur_0
  }

  measure: montant_total_des_encaissements_a_150_jours {
    group_label: "Montant Encaissements"
    type: sum
    sql: ${encaissement.montant_encaissement_hors_bloque_en_facturation};;
    filters: {
      field: nombre_de_jours_pour_encaissement
      value: "<=150"
    }
    value_format_name: eur_0
  }

  measure: montant_total_des_encaissements_a_180_jours {
    group_label: "Montant Encaissements"
    type: sum
    sql: ${encaissement.montant_encaissement_hors_bloque_en_facturation} ;;
    filters: {
      field: nombre_de_jours_pour_encaissement
      value: "<=180"
    }
    value_format_name: eur_0
  }

  measure: montant_total_des_encaissements_a_210_jours {
    group_label: "Montant Encaissements"
    type: sum
    sql: ${encaissement.montant_encaissement_hors_bloque_en_facturation} ;;
    filters: {
      field: nombre_de_jours_pour_encaissement
      value: "<=210"
    }
    value_format_name: eur_0
  }

  measure: montant_total_des_encaissements_a_240_jours {
    group_label: "Montant Encaissements"
    type: sum
    sql: ${encaissement.montant_encaissement_hors_bloque_en_facturation} ;;
    filters: {
      field: nombre_de_jours_pour_encaissement
      value: "<=240"
    }
    value_format_name: eur_0
  }

  measure: montant_total_des_encaissements_a_270_jours {
    group_label: "Montant Encaissements"
    type: sum
    sql: ${encaissement.montant_encaissement_hors_bloque_en_facturation} ;;
    filters: {
      field: nombre_de_jours_pour_encaissement
      value: "<=270"
    }
    value_format_name: eur_0
  }

  measure: count {
    type: count
    drill_fields: [Detail_des_dossiers*]
  }

#   measure: tt_enc_30j {
#     type: sum
#     sql: ${encaissement.enc1_montant} ;;
#     filters: {
#       field: nombre_de_jour_pour_encaissement
#       value: "<=30"
#     }
#     value_format_name: eur
#   }
#
#   measure: recouvrement_30j {
#     type: number
#     sql: ${tt_enc_30j}/NULLIF(${debiteur.montant_total_des_encaissements},0) ;;
#     value_format_name: percent_2
#   }

  set: Detail_des_dossiers {
    fields: [debiteur.identifiant_debiteur,
      debiteur.date_ouverture_date,
      debiteur.date_de_cloture_date,
      encaissement.montant_total_encaissements_hors_bloque_en_facturation,
      piece.montant_total_principal_a_date,
      debiteur.code_postal,
      debiteur.ville]
  }

}
