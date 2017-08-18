view: groupage {
  sql_table_name: public.groupage ;;

  dimension: base {
    type: string
    sql: ${TABLE}.base ;;
  }

  dimension: cd_groupage {
    type: string
    sql: ${TABLE}.cd_groupage ;;
  }

  dimension: id_cli {
    type: string
    sql: ${TABLE}.id_cli ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
