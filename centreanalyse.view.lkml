view: centreanalyse {
  sql_table_name: public.centreanalyse ;;

  dimension: enseigne {
    type: string
    sql: ${TABLE}.enseigne ;;
  }

  dimension: exclu {
    type: string
    sql: ${TABLE}.exclu ;;
  }

  dimension: id_centreana {
    type: string
    sql: ${TABLE}.id_centreana ;;
  }

  dimension: id_dep {
    type: string
    sql: ${TABLE}.id_dep ;;
  }

  dimension: id_master {
    type: string
    sql: ${TABLE}.id_master ;;
  }

  dimension: lib_centreana {
    type: string
    sql: ${TABLE}.lib_centreana ;;
  }

  dimension: lib_master {
    type: string
    sql: ${TABLE}.lib_master ;;
  }

  dimension: offre {
    type: string
    sql: ${TABLE}.offre ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
