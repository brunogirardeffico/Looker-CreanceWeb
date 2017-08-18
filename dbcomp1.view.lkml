view: dbcomp1 {
  sql_table_name: public.dbcomp1 ;;

  dimension: base {
    type: string
    sql: ${TABLE}.base ;;
  }

  dimension: civ {
    type: string
    sql: ${TABLE}.civ ;;
  }

  dimension_group: dtnaiss {
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
    sql: ${TABLE}.dtnaiss ;;
  }

  dimension: id_deb {
    type: string
    sql: ${TABLE}.id_deb ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
