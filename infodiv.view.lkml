view: infodiv {
  sql_table_name: public.infodiv ;;

  dimension: auteur {
    type: string
    sql: ${TABLE}.auteur ;;
  }

  dimension: base {
    type: string
    sql: ${TABLE}.base ;;
  }

  dimension: cle {
    type: string
    sql: ${TABLE}.cle ;;
  }

  dimension: cle_des {
    type: string
    sql: ${TABLE}.cle_des ;;
  }

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
  }

  dimension: id_deb {
    type: string
    sql: ${TABLE}.id_deb ;;
  }

  dimension: sequence {
    type: number
    sql: ${TABLE}.sequence ;;
  }

  dimension: valeur {
    type: string
    sql: ${TABLE}.valeur ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
