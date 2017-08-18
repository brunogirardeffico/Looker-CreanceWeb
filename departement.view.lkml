view: departement {
  sql_table_name: public.departement ;;

  dimension: class_rh {
    type: string
    sql: ${TABLE}.class_rh ;;
  }

  dimension: depart_resp {
    type: string
    sql: ${TABLE}.depart_resp ;;
  }

  dimension: id_dep {
    type: string
    sql: ${TABLE}.id_dep ;;
  }

  dimension: id_dir {
    type: string
    sql: ${TABLE}.id_dir ;;
  }

  dimension: id_divis {
    type: string
    sql: ${TABLE}.id_divis ;;
  }

  dimension: id_olddep {
    type: string
    sql: ${TABLE}.id_olddep ;;
  }

  dimension: id_pole {
    type: string
    sql: ${TABLE}.id_pole ;;
  }

  dimension: id_serv {
    type: string
    sql: ${TABLE}.id_serv ;;
  }

  dimension: lib_depart {
    type: string
    sql: ${TABLE}.lib_depart ;;
  }

  dimension: lib_dir {
    type: string
    sql: ${TABLE}.lib_dir ;;
  }

  dimension: lib_divis {
    type: string
    sql: ${TABLE}.lib_divis ;;
  }

  dimension: lib_olddepart {
    type: string
    sql: ${TABLE}.lib_olddepart ;;
  }

  dimension: lib_serv {
    type: string
    sql: ${TABLE}.lib_serv ;;
  }

  dimension: lig_metier {
    type: string
    sql: ${TABLE}.lig_metier ;;
  }

  dimension: orga_cdg {
    type: string
    sql: ${TABLE}.orga_cdg ;;
  }

  dimension: resp_dir {
    type: string
    sql: ${TABLE}.resp_dir ;;
  }

  dimension: resp_divis {
    type: string
    sql: ${TABLE}.resp_divis ;;
  }

  dimension: resp_serv {
    type: string
    sql: ${TABLE}.resp_serv ;;
  }

  dimension: site {
    type: string
    sql: ${TABLE}.site ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
