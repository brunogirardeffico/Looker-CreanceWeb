view: echeancier {
  sql_table_name: public.echeancier ;;

  dimension: echeancier_id {
    type: string
    sql: ${TABLE}.echeancier_id ;;
  }

  dimension: base {
    type: string
    sql: ${TABLE}.base ;;
  }

  dimension_group: date_echeance {
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
    sql: ${TABLE}.ech_dt ;;
  }

  dimension: montant_echeance {
    type: number
    sql: ${TABLE}.ech_mtt ;;
  }

  dimension: ech_num {
    type: number
    sql: ${TABLE}.ech_num ;;
  }

  dimension_group: echea_creat_dt {
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
    sql: ${TABLE}.echea_creat_dt ;;
  }

  dimension: echea_typ {
    type: string
    sql: ${TABLE}.echea_typ ;;
  }

  dimension: echeance_id {
    type: string
    sql: ${TABLE}.echeance_id ;;
    primary_key: yes
  }

  dimension: id_cli {
    type: string
    sql: ${TABLE}.id_cli ;;
  }

  dimension: identifiant_debiteur {
    type: string
    sql: ${TABLE}.id_deb ;;
  }

  dimension: id_enc {
    type: string
    sql: ${TABLE}.id_enc ;;
  }

  dimension: mod_rglt {
    type: string
    sql: ${TABLE}.mod_rglt ;;
  }

  dimension: profilech {
    type: string
    sql: ${TABLE}.profilech ;;
  }

  dimension: statut {
    type: string
    sql: ${TABLE}.statut ;;
  }

  measure: count {
    type: count
    drill_fields: [echeancier_id]
  }

  dimension: top_a_venir {
    type :  number
    sql:  case when ${echeancier.date_echeance_raw}>=CURRENT_DATE and ${echeancier.statut} not in ('SUPP','ANN','IMP','ENC') then 1 else 0 end;;
  }

  measure:  montant_echeance_plan_total_a_venir{
    type: sum
    sql: ${echeancier.montant_echeance}*${echeancier.top_a_venir} ;;
    value_format_name: eur_0
  }
}
