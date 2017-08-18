view: action {
  sql_table_name: public.action ;;

  dimension: actf01 {
    type: string
    sql: ${TABLE}.actf01 ;;
  }

  dimension: actf02 {
    type: string
    sql: ${TABLE}.actf02 ;;
  }

  dimension_group: action_dt {
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
    sql: ${TABLE}.action_dt ;;
  }

  dimension: action_lib {
    type: string
    sql: ${TABLE}.action_lib ;;
  }

  dimension: action_mtt {
    type: number
    sql: ${TABLE}.action_mtt ;;
  }

  dimension: base {
    type: string
    sql: ${TABLE}.base ;;
  }

  dimension: cd_act {
    type: string
    sql: ${TABLE}.cd_act ;;
  }

  dimension: cd_actsec {
    type: string
    sql: ${TABLE}.cd_actsec ;;
  }

  dimension: cd_fact {
    type: string
    sql: ${TABLE}.cd_fact ;;
  }

  dimension: cd_trait2 {
    type: string
    sql: ${TABLE}.cd_trait2 ;;
  }

  dimension_group: dt_maj {
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
    sql: ${TABLE}.dt_maj ;;
  }

  dimension_group: exec_dt {
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
    sql: ${TABLE}.exec_dt ;;
  }

  dimension: id_act {
    type: string
    sql: ${TABLE}.id_act ;;
  }

  dimension: id_cli {
    type: string
    sql: ${TABLE}.id_cli ;;
  }

  dimension: id_deb {
    type: string
    sql: ${TABLE}.id_deb ;;
  }

  dimension: interv_id {
    type: string
    sql: ${TABLE}.interv_id ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
