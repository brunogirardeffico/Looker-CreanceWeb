view: debiteur {
  sql_table_name: public.debiteur ;;

  dimension: identifiant_debiteur {
    type: string
    sql: ${TABLE}.id_deb ;;
    primary_key: yes
  }

  dimension: frais_article_700 {
    type: number
    sql: ${TABLE}.art700_mtt ;;
  }

  dimension: base {
    type: string
    sql: ${TABLE}.base ;;
  }

  dimension: code_cloture {
    type: string
    sql: ${TABLE}.cd_clot ;;
  }

  dimension: frais_clause_penale {
    type: number
    sql: ${TABLE}.claupen_mtt ;;
  }

  dimension_group: date_de_cloture {
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
    sql: ${TABLE}.clo_dt ;;
  }

  dimension: code_postal_brut {
    type: string
    sql: ${TABLE}.cp ;;
  }

  dimension: type_de_creance {
    label: "Type de Créance"
    type: string
    sql: ${TABLE}.creance_typ ;;
  }

  dimension: frais_contentieux {
    type: number
    sql: ${TABLE}.ctx_mtt ;;
  }

  dimension_group: date_dernier_encaissement_direct {
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
    sql: ${TABLE}.dern_enc_dir_dt ;;
  }

  dimension_group: date_dernier_encaissement_indirect {
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
    sql: ${TABLE}.dern_enc_indir_dt ;;
  }

  dimension: montant_dernier_encaissement_direct {
    type: number
    sql: ${TABLE}.dern_encdir_mtt ;;
  }

  dimension: montant_dernier_encaissement_indirect {
    type: number
    sql: ${TABLE}.dern_encindir_mtt ;;
  }

  dimension: frais_divers {
    type: number
    sql: ${TABLE}.divers_mtt ;;
  }

# Neutralisation de l'utilisation des variable d'encaissement de la table débiteur. Préféré recalcul sur la table encaissement
  #dimension: montant_encaissement_direct {
  #  type: number
  #  sql: ${TABLE}.enc_mtt ;;
  #  value_format_name: eur
  #}

  #dimension: montant_encaissement_indirect {
  #  type: number
  #  sql: ${TABLE}.encind_mtt ;;
  #  value_format_name: eur
  #}

  #dimension: montant_des_encaissements {
  #  type: number
  #  sql: ${montant_encaissement_direct} + ${montant_encaissement_indirect}} ;;
  #  value_format_name: eur
  #}

  dimension: frais_de_greffe {
    type: number
    sql: ${TABLE}.greffe_mtt ;;
  }

  dimension: frais_huissier {
    type: number
    sql: ${TABLE}.huiss_mtt ;;
  }

  dimension: identifiant_client {
    type: string
    sql: ${TABLE}.id_cli ;;
  }

  dimension: reference_debiteur_chez_client {
    type: string
    sql: ${TABLE}.id_refcli ;;
  }

  dimension: frais_impaye {
    type: number
    sql: ${TABLE}.imp_mtt ;;
  }

  dimension: frais_interet_de_retard {
    type: number
    sql: ${TABLE}.intret_mtt ;;
  }

  dimension: montant_irrecouvrable {
    type: number
    sql: ${TABLE}.irrec_mtt ;;
  }

  dimension: frais_lettre_recommandee {
    type: number
    sql: ${TABLE}.letrec_mtt ;;
  }

  dimension: motif_dette_1 {
    type: string
    sql: ${TABLE}.motdet1 ;;
  }

  dimension: motif_dette_2 {
    type: string
    sql: ${TABLE}.motdet2 ;;
  }

  dimension_group: date_ouverture {
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
    sql: ${TABLE}.ouv_dt ;;
  }

  dimension: montant_principal_de_dette {
    type: number
    sql: ${TABLE}.princ_mtt ;;
  }

  dimension: reference2_chez_client {
    type: string
    sql: ${TABLE}.ref2cli ;;
  }

  dimension: ville {
    type: string
    sql: ${TABLE}.ville ;;
  }

  dimension: nombre_de_jours_dossier_ouvert {
    type:  number
    sql: datediff(day,${debiteur.date_ouverture_raw},CURRENT_DATE) ;;
  }

  dimension: is_dossier_clos{
    label: "Dossier Clos ?"
    type: yesno
    sql: ${code_cloture} is not null ;;
  }

  dimension: top_dossier_clos {
    type: number
    sql:  case when ${debiteur.code_cloture} is not null then 1 else 0 end;;
    # CAST((${TABLE}.cd_clot is not null) as integer)*1.000 ;;
  }
  dimension: top_dossier_actif {
    type: number
    sql:  case when ${debiteur.code_cloture} is null then 1 else 0 end;;
    #sql:  CAST((${TABLE}.cd_clot is null) as integer)*1.000 ;;
  }
  dimension: top_dossier_clos_suite_reglement {
    type: number
    sql:  case when ${debiteur.code_cloture} ='RG' then 1 else 0 end;;
    #sql:  CAST((${TABLE}.cd_clot ='RG') as integer)*1.000 ;;
  }

  dimension: top_dossier_clos_abandon {
    type: number
    sql:  case when ${debiteur.code_cloture} in ('08','16','71') then 1 else 0 end;;
    #sql:  CAST((${TABLE}.cd_clot IN ('08','16','71')) as integer)*1.000 ;;

  }
  dimension: top_dossier_clos_npai {
    type: number
    sql:  case when ${debiteur.code_cloture} in ('01','50') then 1 else 0 end;;
    #sql:  CAST((${TABLE}.cd_clot IN ('01','50')) as integer)*1.000 ;;
  }
  dimension: top_dossier_clos_autre {
    type: number
    sql:  case when ${debiteur.code_cloture} not in ('01','50','08','16','71','RG') and ${debiteur.code_cloture} is not null then 1 else 0 end;;
    #sql:  CAST((${TABLE}.cd_clot IN ('01','50')) as integer)*1.000 ;;
  }


  dimension: code_postal {
    type: string
    sql: lpad(CP,5,'0') ;;
  }

  dimension: departement {
    sql: SUBSTRING(lpad(CP,5,'0'),1,2) ;;
    map_layer_name: France_departements
    drill_fields: [Detail_des_dossiers*]
  }

  measure: nombre_de_dossiers {
    type: count
    drill_fields: [Detail_des_dossiers*]
  }


  measure: taux_dossiers_actifs {
    group_label: "Taux Dossiers actif"
    type: average_distinct
    sql: ${debiteur.top_dossier_actif} ;;
    value_format_name: percent_1
    drill_fields: [Detail_des_dossiers*]
  }

  measure: taux_dossiers_clos {
    group_label: "Taux Dossiers clos"
    type: average_distinct
    sql: ${debiteur.top_dossier_clos} ;;
    value_format_name: percent_1
    drill_fields: [Detail_des_dossiers*]
  }
  measure: taux_dossiers_clos_suite_reglement {
    group_label: "Taux Dossiers clos suite règlement"
    type: average_distinct
    sql: ${debiteur.top_dossier_clos_suite_reglement} ;;
    value_format_name: percent_1
    drill_fields: [Detail_des_dossiers*]
  }

  measure: taux_dossiers_clos_suite_abandon {
    group_label: "Taux Dossiers clos suite abandon"
    type: average_distinct
    sql: ${debiteur.top_dossier_clos_abandon} ;;
    value_format_name: percent_1
    drill_fields: [Detail_des_dossiers*]
  }

  measure: taux_dossiers_clos_suite_npai {
    group_label: "Taux Dossiers clos suite"
    type: average_distinct
    sql: ${debiteur.top_dossier_clos_npai} ;;
    value_format_name: percent_1
    drill_fields: [Detail_des_dossiers*]
  }

  measure: taux_dossiers_clos_autre {
    group_label: "Taux Dossiers clos autre"
    type: average_distinct
    sql: ${debiteur.top_dossier_clos_autre} ;;
    value_format_name: percent_1
    drill_fields: [Detail_des_dossiers*]
  }


  measure: nombre_de_dossiers_actifs {
    type: sum
    sql: ${debiteur.top_dossier_actif}  ;;
    drill_fields: [Detail_des_dossiers*]
  }

  measure: nombre_de_dossiers_clos {
    type: sum
    sql: ${debiteur.top_dossier_clos}  ;;
  }

  measure: montant_principal_dette_total {
    group_label: "Montant Principal Dette"
    type: sum_distinct
    sql_distinct_key: ${identifiant_debiteur};;
    sql: ${montant_principal_de_dette} ;;
    value_format_name: eur
    drill_fields: [Detail_des_dossiers*,montant_principal_dette_total]
  }

  measure: montant_principal_dette_a_30_jours_plus {
    group_label: "Montant Principal Dette"
    type: sum_distinct
    sql_distinct_key: ${identifiant_debiteur};;
    sql: ${montant_principal_de_dette} ;;
    filters: {
      field: nombre_de_jours_dossier_ouvert
      value: ">=30"
    }
    value_format_name: eur_0
  }

  measure: montant_principal_dette_a_60_jours_plus {
    group_label: "Montant Principal Dette"
    type: sum_distinct
    sql_distinct_key: ${identifiant_debiteur};;
    sql: ${montant_principal_de_dette} ;;
    filters: {
      field: nombre_de_jours_dossier_ouvert
      value: ">=60"
    }
    value_format_name: eur
  }

  measure: montant_principal_dette_a_90_jours_plus {
    group_label: "Montant Principal Dette"
    type: sum_distinct
    sql_distinct_key: ${identifiant_debiteur};;
    sql: ${montant_principal_de_dette} ;;
    filters: {
      field: nombre_de_jours_dossier_ouvert
      value: ">=90"
    }
    value_format_name: eur
  }

  measure: montant_principal_dette_a_120_jours_plus {
    group_label: "Montant Principal Dette"
    type: sum_distinct
    sql_distinct_key: ${identifiant_debiteur};;
    sql: ${montant_principal_de_dette} ;;
    filters: {
      field: nombre_de_jours_dossier_ouvert
      value: ">=120"
    }
    value_format_name: eur
  }

  measure: montant_principal_dette_a_150_jours_plus {
    group_label: "Montant Principal Dette"
    type: sum_distinct
    sql_distinct_key: ${identifiant_debiteur};;
    sql: ${montant_principal_de_dette} ;;
    filters: {
      field: nombre_de_jours_dossier_ouvert
      value: ">=150"
    }
    value_format_name: eur
  }

  measure: montant_principal_dette_a_180_jours_plus {
    group_label: "Montant Principal Dette"
    type: sum_distinct
    sql_distinct_key: ${identifiant_debiteur};;
    sql: ${montant_principal_de_dette} ;;
    filters: {
      field: nombre_de_jours_dossier_ouvert
      value: ">=180"
    }
    value_format_name: eur
  }

  measure: montant_principal_dette_a_210_jours_plus {
    group_label: "Montant Principal Dette"
    type: sum_distinct
    sql_distinct_key: ${identifiant_debiteur};;
    sql: ${montant_principal_de_dette} ;;
    filters: {
      field: nombre_de_jours_dossier_ouvert
      value: ">=210"
    }
    value_format_name: eur
  }

  measure: montant_principal_dette_a_240_jours_plus {
    group_label: "Montant Principal Dette"
    type: sum_distinct
    sql_distinct_key: ${identifiant_debiteur};;
    sql: ${montant_principal_de_dette} ;;
    filters: {
      field: nombre_de_jours_dossier_ouvert
      value: ">=240"
    }
    value_format_name: eur
  }

  measure: montant_principal_dette_a_270_jours_plus {
    group_label: "Montant Principal Dette"
    type: sum_distinct
    sql_distinct_key: ${identifiant_debiteur};;
    sql: ${montant_principal_de_dette} ;;
    filters: {
      field: nombre_de_jours_dossier_ouvert
      value: ">=270"
    }
    value_format_name: eur
  }


  measure: taux_encaissement_a_30_jours {
    group_label: "Taux Encaissement à 30 jours"
    type: number
    sql: ${encaissement.montant_total_des_encaissements_a_30_jours} / NULLIF(${montant_principal_dette_a_30_jours_plus},0) ;;
    value_format_name: percent_2
    #dans le montant_principal_dette_total compter seulement les dossiers qui ont au moins 30 jours.
  }

  measure: taux_encaissement_a_60_jours {
    group_label: "Taux Encaissements à 60 jours"
    type: number
    sql: ${encaissement.montant_total_des_encaissements_a_60_jours} / NULLIF(${montant_principal_dette_a_60_jours_plus},0) ;;
    value_format_name: percent_2
  }

  measure: taux_encaissement_a_90_jours {
    group_label: "Taux Encaissements à 90 jours"
    type: number
    sql: ${encaissement.montant_total_des_encaissements_a_90_jours} / NULLIF(${montant_principal_dette_a_90_jours_plus},0) ;;
    value_format_name: percent_2
  }

  measure: taux_encaissement_a_120_jours {
    group_label: "Taux Encaissements à 120 jours"
    type: number
    sql: ${encaissement.montant_total_des_encaissements_a_120_jours} / NULLIF(${montant_principal_dette_a_120_jours_plus},0) ;;
    value_format_name: percent_2
  }

  measure: taux_encaissement_a_150_jours {
    group_label: "Taux Encaissements à 150 jours"
    type: number
    sql: ${encaissement.montant_total_des_encaissements_a_150_jours} / NULLIF(${montant_principal_dette_a_150_jours_plus},0)  ;;
    value_format_name: percent_2
  }

  measure: taux_encaissement_a_180_jours {
    group_label: "Taux Encaissements à 180 jours"
    type: number
    sql: ${encaissement.montant_total_des_encaissements_a_180_jours} / NULLIF(${montant_principal_dette_a_180_jours_plus},0)  ;;
    value_format_name: percent_2
  }

  measure: taux_encaissement_a_210_jours {
    group_label: "Taux Encaissements à 210 jours"
    type: number
    sql: ${encaissement.montant_total_des_encaissements_a_210_jours} / NULLIF(${montant_principal_dette_a_210_jours_plus},0)  ;;
    value_format_name: percent_2
  }

  measure: taux_encaissement_a_240_jours {
    group_label: "Taux Encaissements à 240 jours"
    type: number
    sql: ${encaissement.montant_total_des_encaissements_a_240_jours} / NULLIF(${montant_principal_dette_a_240_jours_plus},0)  ;;
    value_format_name: percent_2
  }

  measure: taux_encaissement_a_270_jours {
    group_label: "Taux Encaissements à 270 jours"
    type: number
    sql: ${encaissement.montant_total_des_encaissements_a_270_jours} / NULLIF(${montant_principal_dette_a_270_jours_plus},0)  ;;
    value_format_name: percent_2
  }

  measure: montant_restant_du {
    type: number
    sql: (${piece.montant_principal_a_date}-${encaissement.montant_total_encaissements_hors_bloque_en_facturation}) ;;
  }

  dimension: nombre_de_jours_avant_cloture {
    type:  number
    sql: Case when ${code_cloture} is not null then datediff(day,${debiteur.date_ouverture_raw},${debiteur.date_de_cloture_raw}) else 0 end ;;
  }

  measure:  delai_moyen_avant_cloture {
    type:  average
    sql: (${debiteur.nombre_de_jours_avant_cloture}) ;;
  }

  measure:  Restant_du {
    type: sum
    sql: ${encaissement.montant_encaissement_hors_bloque_en_facturation}/${piece.montant_principal_a_date};;
    value_format_name: eur
    drill_fields: [Detail_des_dossiers*,Restant_du]
  }

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
