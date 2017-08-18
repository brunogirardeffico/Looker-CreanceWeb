view: vue_chonique_encaissement {
  derived_table: {
    sql:
    select distinct deb.id_deb,deb.OUV_DT,1 as nb_jour,
        sum(case
            when datediff(day,ouv_dt,ENCAIS_DT)>1 then 0
            when NO_FACT='9999999' then 0
            when id_enc_imp='V0000000000' then ENC1_MTT
            else ENC1_MTT*(-1) end
            ) as Encaissement_J,
            piece.Mtt_princ_a_date

      from debiteur as deb
      left join encaissement as enc
      on deb.id_deb=enc.id_deb
      left join (
            select id_deb,sum(  MTT_PIECE_DEV
                  * case when substring(CD_PIECE,1,1)='1' then 1 else 0 end ) as Mtt_princ_a_date
            from piece
            group by id_deb ) as piece
      on deb.id_deb=piece.id_deb
      where datediff(day,ouv_dt,CURRENT_DATE) >=1
      group by deb.id_deb,deb.OUV_DT,nb_jour,piece.Mtt_princ_a_date
  union
    select distinct deb.id_deb,deb.OUV_DT,30 as nb_jour,
        sum(case
            when datediff(day,ouv_dt,ENCAIS_DT)>30 then 0
            when NO_FACT='9999999' then 0
            when id_enc_imp='V0000000000' then ENC1_MTT
            else ENC1_MTT*(-1) end
            ) as Encaissement_J,
            piece.Mtt_princ_a_date

      from debiteur as deb
      left join encaissement as enc
      on deb.id_deb=enc.id_deb
      left join (
            select id_deb,sum(  MTT_PIECE_DEV
                  * case when substring(CD_PIECE,1,1)='1' then 1 else 0 end ) as Mtt_princ_a_date
            from piece
            group by id_deb ) as piece
      on deb.id_deb=piece.id_deb
      where datediff(day,ouv_dt,CURRENT_DATE) >=30
      group by deb.id_deb,deb.OUV_DT,nb_jour,piece.Mtt_princ_a_date
  union
 select distinct deb.id_deb,deb.OUV_DT,60 as nb_jour,
        sum(case
            when datediff(day,ouv_dt,ENCAIS_DT)>60 then 0
            when NO_FACT='9999999' then 0
            when id_enc_imp='V0000000000' then ENC1_MTT
            else ENC1_MTT*(-1) end
            ) as Encaissement_J,
            piece.Mtt_princ_a_date

      from debiteur as deb
      left join encaissement as enc
      on deb.id_deb=enc.id_deb
      left join (
            select id_deb,sum(  MTT_PIECE_DEV
                  * case when substring(CD_PIECE,1,1)='1' then 1 else 0 end ) as Mtt_princ_a_date
            from piece
            group by id_deb ) as piece
      on deb.id_deb=piece.id_deb
      where datediff(day,ouv_dt,CURRENT_DATE) >=60
      group by deb.id_deb,deb.OUV_DT,nb_jour,piece.Mtt_princ_a_date
 union
 select distinct deb.id_deb,deb.OUV_DT,90 as nb_jour,
        sum(case
            when datediff(day,ouv_dt,ENCAIS_DT)>90 then 0
            when NO_FACT='9999999' then 0
            when id_enc_imp='V0000000000' then ENC1_MTT
            else ENC1_MTT*(-1) end
            ) as Encaissement_J,
            piece.Mtt_princ_a_date

      from debiteur as deb
      left join encaissement as enc
      on deb.id_deb=enc.id_deb
      left join (
            select id_deb,sum(  MTT_PIECE_DEV
                  * case when substring(CD_PIECE,1,1)='1' then 1 else 0 end ) as Mtt_princ_a_date
            from piece
            group by id_deb ) as piece
      on deb.id_deb=piece.id_deb
      where datediff(day,ouv_dt,CURRENT_DATE) >=90
      group by deb.id_deb,deb.OUV_DT,nb_jour,piece.Mtt_princ_a_date
       union
 select distinct deb.id_deb,deb.OUV_DT,120 as nb_jour,
        sum(case
            when datediff(day,ouv_dt,ENCAIS_DT)>120 then 0
            when NO_FACT='9999999' then 0
            when id_enc_imp='V0000000000' then ENC1_MTT
            else ENC1_MTT*(-1) end
            ) as Encaissement_J,
            piece.Mtt_princ_a_date

      from debiteur as deb
      left join encaissement as enc
      on deb.id_deb=enc.id_deb
      left join (
            select id_deb,sum(  MTT_PIECE_DEV
                  * case when substring(CD_PIECE,1,1)='1' then 1 else 0 end ) as Mtt_princ_a_date
            from piece
            group by id_deb ) as piece
      on deb.id_deb=piece.id_deb
      where datediff(day,ouv_dt,CURRENT_DATE) >=120
      group by deb.id_deb,deb.OUV_DT,nb_jour,piece.Mtt_princ_a_date
 union
 select distinct deb.id_deb,deb.OUV_DT,150 as nb_jour,
        sum(case
            when datediff(day,ouv_dt,ENCAIS_DT)>150 then 0
            when NO_FACT='9999999' then 0
            when id_enc_imp='V0000000000' then ENC1_MTT
            else ENC1_MTT*(-1) end
            ) as Encaissement_J,
            piece.Mtt_princ_a_date

      from debiteur as deb
      left join encaissement as enc
      on deb.id_deb=enc.id_deb
      left join (
            select id_deb,sum(  MTT_PIECE_DEV
                  * case when substring(CD_PIECE,1,1)='1' then 1 else 0 end ) as Mtt_princ_a_date
            from piece
            group by id_deb ) as piece
      on deb.id_deb=piece.id_deb
      where datediff(day,ouv_dt,CURRENT_DATE) >=150
      group by deb.id_deb,deb.OUV_DT,nb_jour,piece.Mtt_princ_a_date
 union
 select distinct deb.id_deb,deb.OUV_DT,180 as nb_jour,
        sum(case
            when datediff(day,ouv_dt,ENCAIS_DT)>180 then 0
            when NO_FACT='9999999' then 0
            when id_enc_imp='V0000000000' then ENC1_MTT
            else ENC1_MTT*(-1) end
            ) as Encaissement_J,
            piece.Mtt_princ_a_date

      from debiteur as deb
      left join encaissement as enc
      on deb.id_deb=enc.id_deb
      left join (
            select id_deb,sum(  MTT_PIECE_DEV
                  * case when substring(CD_PIECE,1,1)='1' then 1 else 0 end ) as Mtt_princ_a_date
            from piece
            group by id_deb ) as piece
      on deb.id_deb=piece.id_deb
      where datediff(day,ouv_dt,CURRENT_DATE) >=180
      group by deb.id_deb,deb.OUV_DT,nb_jour,piece.Mtt_princ_a_date
 union
 select distinct deb.id_deb,deb.OUV_DT,210 as nb_jour,
        sum(case
            when datediff(day,ouv_dt,ENCAIS_DT)>210 then 0
            when NO_FACT='9999999' then 0
            when id_enc_imp='V0000000000' then ENC1_MTT
            else ENC1_MTT*(-1) end
            ) as Encaissement_J,
            piece.Mtt_princ_a_date

      from debiteur as deb
      left join encaissement as enc
      on deb.id_deb=enc.id_deb
      left join (
            select id_deb,sum(  MTT_PIECE_DEV
                  * case when substring(CD_PIECE,1,1)='1' then 1 else 0 end ) as Mtt_princ_a_date
            from piece
            group by id_deb ) as piece
      on deb.id_deb=piece.id_deb
      where datediff(day,ouv_dt,CURRENT_DATE) >=210
      group by deb.id_deb,deb.OUV_DT,nb_jour,piece.Mtt_princ_a_date
 union
 select distinct deb.id_deb,deb.OUV_DT,240 as nb_jour,
        sum(case
            when datediff(day,ouv_dt,ENCAIS_DT)>240 then 0
            when NO_FACT='9999999' then 0
            when id_enc_imp='V0000000000' then ENC1_MTT
            else ENC1_MTT*(-1) end
            ) as Encaissement_J,
            piece.Mtt_princ_a_date

      from debiteur as deb
      left join encaissement as enc
      on deb.id_deb=enc.id_deb
      left join (
            select id_deb,sum(  MTT_PIECE_DEV
                  * case when substring(CD_PIECE,1,1)='1' then 1 else 0 end ) as Mtt_princ_a_date
            from piece
            group by id_deb ) as piece
      on deb.id_deb=piece.id_deb
      where datediff(day,ouv_dt,CURRENT_DATE) >=240
      group by deb.id_deb,deb.OUV_DT,nb_jour,piece.Mtt_princ_a_date
 union
 select distinct deb.id_deb,deb.OUV_DT,270 as nb_jour,
        sum(case
            when datediff(day,ouv_dt,ENCAIS_DT)>270 then 0
            when NO_FACT='9999999' then 0
            when id_enc_imp='V0000000000' then ENC1_MTT
            else ENC1_MTT*(-1) end
            ) as Encaissement_J,
            piece.Mtt_princ_a_date

      from debiteur as deb
      left join encaissement as enc
      on deb.id_deb=enc.id_deb
      left join (
            select id_deb,sum(  MTT_PIECE_DEV
                  * case when substring(CD_PIECE,1,1)='1' then 1 else 0 end ) as Mtt_princ_a_date
            from piece
            group by id_deb ) as piece
      on deb.id_deb=piece.id_deb
      where datediff(day,ouv_dt,CURRENT_DATE) >=270
      group by deb.id_deb,deb.OUV_DT,nb_jour,piece.Mtt_princ_a_date
    ;;
  }

  dimension: identifiant_debiteur {
    type: string
    sql: ${TABLE}.id_deb  ;;
  }

  dimension: Nb_jour_depuis_ouverture {
    type: number
    sql: ${TABLE}.nb_jour ;;
  }
  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT( ${TABLE}.id_deb, ${TABLE}.nb_jour) ;;
  }

  dimension: encaissement_J {
    type: number
    hidden: yes
    sql: ${TABLE}.encaissement_j ;;
  }

  dimension: Mtt_princ_a_date {
    type: number
    sql: ${TABLE}.Mtt_princ_a_date ;;
  }

  measure:encaissement_jour {
    type: sum
    sql: ${vue_chonique_encaissement.encaissement_J} ;;
  }

  measure:Montant_princ_date {
    type: sum
    sql: ${vue_chonique_encaissement.Mtt_princ_a_date} ;;
  }

  measure: taux_encaissement_J {
    type: number
    sql:(${vue_chonique_encaissement.encaissement_jour})/NULLIF(${vue_chonique_encaissement.Montant_princ_date},0)  ;;
    value_format_name: percent_1
  }
}
