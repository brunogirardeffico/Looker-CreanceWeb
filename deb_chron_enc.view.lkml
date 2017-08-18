view: deb_chron_enc {
  sql_table_name: public.deb_chron_enc ;;

  dimension: id_cli {
    type: string
    sql: ${TABLE}.id_cli ;;
  }

  dimension: id_deb {
    type: string
    sql: ${TABLE}.id_deb ;;
  }

  dimension: mtt_princ_frimp_ir {
    type: number
    sql: ${TABLE}.mtt_princ_frimp_ir ;;
  }

  dimension_group: ouv_dt {
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
    datatype: date
    sql: ${TABLE}.ouv_dt ;;
  }

  dimension: princ_mtt {
    type: number
    sql: ${TABLE}.princ_mtt ;;
  }

  dimension: top_clo {
    type: number
    sql: ${TABLE}.top_clo ;;
  }

  dimension: tt_enc {
    type: number
    sql: ${TABLE}.tt_enc ;;
  }

  dimension: tt_enc_1080j {
    type: number
    sql: ${TABLE}.tt_enc_1080j ;;
  }

  dimension: tt_enc_120j {
    type: number
    sql: ${TABLE}.tt_enc_120j ;;
  }

  dimension: tt_enc_150j {
    type: number
    sql: ${TABLE}.tt_enc_150j ;;
  }

  dimension: tt_enc_180j {
    type: number
    sql: ${TABLE}.tt_enc_180j ;;
  }

  dimension: tt_enc_210j {
    type: number
    sql: ${TABLE}.tt_enc_210j ;;
  }

  dimension: tt_enc_240j {
    type: number
    sql: ${TABLE}.tt_enc_240j ;;
  }

  dimension: tt_enc_270j {
    type: number
    sql: ${TABLE}.tt_enc_270j ;;
  }

  dimension: tt_enc_300j {
    type: number
    sql: ${TABLE}.tt_enc_300j ;;
  }

  dimension: tt_enc_30j {
    type: number
    sql: ${TABLE}.tt_enc_30j ;;
  }

  dimension: tt_enc_330j {
    type: number
    sql: ${TABLE}.tt_enc_330j ;;
  }

  dimension: tt_enc_360j {
    type: number
    sql: ${TABLE}.tt_enc_360j ;;
  }

  dimension: tt_enc_540j {
    type: number
    sql: ${TABLE}.tt_enc_540j ;;
  }

  dimension: tt_enc_60j {
    type: number
    sql: ${TABLE}.tt_enc_60j ;;
  }

  dimension: tt_enc_720j {
    type: number
    sql: ${TABLE}.tt_enc_720j ;;
  }

  dimension: tt_enc_90j {
    type: number
    sql: ${TABLE}.tt_enc_90j ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
