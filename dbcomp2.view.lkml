view: dbcomp2 {
  sql_table_name: public.dbcomp2 ;;

  dimension: banq_an {
    type: string
    sql: ${TABLE}.banq_an ;;
  }

  dimension: base {
    type: string
    sql: ${TABLE}.base ;;
  }

  dimension: cd_bureau {
    type: string
    sql: ${TABLE}.cd_bureau ;;
  }

  dimension: cd_nat {
    type: string
    sql: ${TABLE}.cd_nat ;;
  }

  dimension: cd_neiertz {
    type: string
    sql: ${TABLE}.cd_neiertz ;;
  }

  dimension_group: dt_forclusion {
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
    sql: ${TABLE}.dt_forclusion ;;
  }

  dimension: emp_an {
    type: string
    sql: ${TABLE}.emp_an ;;
  }

  dimension: empcjt_an {
    type: string
    sql: ${TABLE}.empcjt_an ;;
  }

  dimension: id_deb {
    type: string
    sql: ${TABLE}.id_deb ;;
  }

  dimension: nbenf {
    type: string
    sql: ${TABLE}.nbenf ;;
  }

  dimension_group: ouvcpt_dt {
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
    sql: ${TABLE}.ouvcpt_dt ;;
  }

  dimension: resprinc_an {
    type: string
    sql: ${TABLE}.resprinc_an ;;
  }

  dimension: ressource {
    type: string
    sql: ${TABLE}.ressource ;;
  }

  dimension: ressourcecjt {
    type: string
    sql: ${TABLE}.ressourcecjt ;;
  }

  dimension: resssec_ind {
    type: string
    sql: ${TABLE}.resssec_ind ;;
  }

  dimension: sitfam {
    type: string
    sql: ${TABLE}.sitfam ;;
  }

  dimension: socpro {
    type: string
    sql: ${TABLE}.socpro ;;
  }

  dimension: socprocjt {
    type: string
    sql: ${TABLE}.socprocjt ;;
  }

  dimension: typ_hab {
    type: string
    sql: ${TABLE}.typ_hab ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
