view: objectif_enc {
  sql_table_name: public.objectif_enc ;;

  dimension: id_dep {
    type: string
    sql: ${TABLE}.id_dep ;;
  }

  dimension: id_master {
    type: string
    sql: ${TABLE}.id_master ;;
  }

  dimension: lib_master {
    type: string
    sql: ${TABLE}.lib_master ;;
  }

  dimension: lib_rubrique_cdg {
    type: string
    sql: ${TABLE}.lib_rubrique_cdg ;;
  }

  dimension: offre {
    type: string
    sql: ${TABLE}.offre ;;
  }

  dimension: periode {
    type: number
    sql: ${TABLE}.periode ;;
  }

  dimension: rep_periode {
    type: string
    sql: ${TABLE}.rep_periode ;;
  }

  dimension: rubrique_cdg {
    type: string
    sql: ${TABLE}.rubrique_cdg ;;
  }

  dimension: site {
    type: string
    sql: ${TABLE}.site ;;
  }

  dimension: valeur {
    type: number
    sql: ${TABLE}.valeur ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
