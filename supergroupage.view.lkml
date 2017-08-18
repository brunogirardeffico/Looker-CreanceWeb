view: supergroupage {
  sql_table_name: public.supergroupage ;;

  dimension: base {
    type: string
    sql: ${TABLE}.base ;;
  }

  dimension: cd_groupage {
    type: string
    sql: ${TABLE}.cd_groupage ;;
  }

  dimension: cd_supgroupage {
    type: string
    sql: ${TABLE}.cd_supgroupage ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
