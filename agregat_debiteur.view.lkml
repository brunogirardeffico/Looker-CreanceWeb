# Création d'une vue avec tous les aggrégats du débiteur

#- Calcul de l'encours non bloqué actif à date
#- Calcul dde l'encours principal des dossiers actif
#- Calcul Top dossier actif
#- Calcul Montant restant dû actif

view: aggregat_debiteur {
  derived_table: {
    sql:
          select  a.id_deb,
               (case when a.cd_clot is null and Enc_non_bloque is not null then Enc_non_bloque
                    when a.cd_clot is null and Enc_non_bloque is  null then 0
                    else null end) Enc_non_bloque_actif_a_date,
                (case when a.cd_clot is null and  Mtt_princ_a_date is not null then Mtt_princ_a_date
                      when a.cd_clot is null and  Mtt_princ_a_date is  null then 0
                      else null end) as Mtt_princ_actif_a_date,
                (case when a.cd_clot is null then 1 else 0 end) as top_dossier_actif,
                (case when a.cd_clot is null and Enc_non_bloque is not null then Mtt_princ_a_date-Enc_non_bloque
                      when a.cd_clot is null and Enc_non_bloque is null then Mtt_princ_a_date
                      else null end) as mtt_restant_du_actif,
                  b.Enc_non_bloque,
                  c.Mtt_princ_a_date


          from debiteur as a
          left join (
            select id_deb, sum( enc1_mtt
                  *(case when encaissement.no_fact='9999999' then 0 else 1 end)
                  *(case when encaissement.id_enc_imp='V0000000000' then 1 else -1 end)
                ) as Enc_non_bloque
            from encaissement
            group by id_deb) as b
          on a.id_deb=b.id_deb
          left join (
            select id_deb,sum(  MTT_PIECE_DEV
                  * case when substring(CD_PIECE,1,1)='1' then 1 else 0 end ) as Mtt_princ_a_date
            from piece
            group by id_deb ) as c
          on a.id_deb=c.id_deb;;
  }

  dimension: identifiant_debiteur {
    type: string
    sql: ${TABLE}.id_deb ;;
    primary_key: yes
  }

  dimension: Mtt_princ_actif_a_date {
    type: number
    sql: ${TABLE}.Mtt_princ_actif_a_date ;;
  }

  dimension:  Enc_non_bloque_actif_a_date {
    type: number
    sql: ${TABLE}.Enc_non_bloque_actif_a_date ;;
  }

  #dimension:  top_dossier_actif{
  #  type:  number
  #  sql: ${TABLE}.top_dossier_actif ;;
  #}

  dimension: mtt_restant_du_actif{
    type:  number
    sql: ${TABLE}.mtt_restant_du_actif ;;
    value_format: "eur"
  }

  dimension: encaissement_non_bloque{
    type:  number
    sql: ${TABLE}.Enc_non_bloque ;;
    value_format: "eur"
  }

  dimension: montant_principal_a_date{
    type:  number
    sql: ${TABLE}.Mtt_princ_a_date ;;
    value_format: "eur"
  }

# Chronique encaissement : Montant total restant dû sur dossier actif (non clôturé)
  measure: Montant_total_restant_du {
    type: sum
    sql: ${mtt_restant_du_actif} ;;
    value_format_name: eur_0
    drill_fields: [identifiant_debiteur,Montant_total_restant_du]
  }
  # Chronique encaissement : Montant moyen restant dû sur dossier actif(non clôturé)
  measure: Montant_moyen_restant_du_a_date {
    type: average
    sql: ${mtt_restant_du_actif} ;;
    value_format_name: eur_0
    drill_fields: [identifiant_debiteur,Montant_moyen_restant_du_a_date]
  }

# Chronique encaissement : Encaissement non bloqué à date
  measure: Montant_encaissement_non_bloque_a_date_sur_actif {
    type: sum
    sql: ${Enc_non_bloque_actif_a_date} ;;
    value_format_name: eur_0
    drill_fields: [identifiant_debiteur,Montant_encaissement_non_bloque_a_date_sur_actif]
  }

# Chronique encaissement : Montant total principal actif à date (non clôturé)
  measure: Montant_total_principal_actif_a_date {
    type: sum
    sql: ${Mtt_princ_actif_a_date} ;;
    value_format_name: eur_0
    drill_fields: [identifiant_debiteur,Montant_total_principal_actif_a_date]
  }
# Chronique encaissement : Part du restant dû sur le principal actif
  measure: pourcent_restant_du_sur_principal_actif_a_date {
    label: "% restant dû sur principal actif à date"
    type: number
    sql: ${aggregat_debiteur.Montant_total_restant_du}/NULLIF(${aggregat_debiteur.Montant_total_principal_actif_a_date},0) ;;
    value_format_name: percent_1
    drill_fields: [identifiant_debiteur,pourcent_restant_du_sur_principal_actif_a_date]
  }
  # Chronique encaissement : Encaissement total hors bloqué en facturaton  / Principal total à date
  measure: Efficacite_sur_principal {
    label: "Efficacité sur principal"
    type: number
    sql: ${encaissement.montant_total_encaissements_hors_bloque_en_facturation}/NULLIF(${piece.montant_total_principal_a_date},0) ;;
    value_format_name: percent_1
    drill_fields: [identifiant_debiteur,Efficacite_sur_principal]
  }
  # Chronique encaissement : Encaissement total hors bloqué en facturaton  / Principal + frais + IR à date
  measure: Efficacite_sur_total {
    label: "Efficacité sur total"
    type: number
    sql: ${encaissement.montant_total_encaissements_hors_bloque_en_facturation}/NULLIF(${piece.montant_principal_et_frais_et_interet},0) ;;
    value_format_name: percent_1
    drill_fields: [identifiant_debiteur,Efficacite_sur_total]
  }
  # Chronique encaissement : Plan à venir + Encaissement total hors bloqué en facturaton  / Principal  à date
  measure: Part_encaissement_potentiel_sur_principal_a_date {
    type: number
    sql: (${echeancier.montant_echeance_plan_total_a_venir}+ ${encaissement.montant_total_encaissements_hors_bloque_en_facturation})/NULLIF(${piece.montant_total_principal_a_date},0) ;;
    value_format_name: percent_1
    drill_fields: [identifiant_debiteur,Part_encaissement_potentiel_sur_principal_a_date]
  }

  # Chronique encaissement : Plan à venir  / Principal  à date
  measure: Part_echeance_plan_a_venir_sur_principal_a_date {
    type: number
    sql: (${echeancier.montant_echeance_plan_total_a_venir})/NULLIF(${piece.montant_total_principal_a_date},0) ;;
    value_format_name: percent_1
    drill_fields: [identifiant_debiteur,Part_echeance_plan_a_venir_sur_principal_a_date]
  }

# Chronique encaissement : Plan à venir + Encaissement total hors bloqué en facturaton  / Principal +frais + IR à date
  measure: Part_encaissement_potentiel_sur_total_a_date {
    type: number
    sql: (${echeancier.montant_echeance_plan_total_a_venir}+ ${encaissement.montant_total_encaissements_hors_bloque_en_facturation})/NULLIF(${piece.montant_principal_et_frais_et_interet},0) ;;
    value_format_name: percent_1
    drill_fields: [identifiant_debiteur,Part_encaissement_potentiel_sur_total_a_date]
  }
# Chronique encaissement : Plan à venir / Principal +frais + IR à date
  measure: Part_echeance_plan_a_venir_sur_total_a_date {
    type: number
    sql: (${echeancier.montant_echeance_plan_total_a_venir})/NULLIF(${piece.montant_principal_et_frais_et_interet},0) ;;
    value_format_name: percent_1
    drill_fields: [identifiant_debiteur,]
  }
}
