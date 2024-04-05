
view: business_dashboard_pervious {

  parameter: c_start_date {
    type: date
    }

  parameter: c_end_date {
    type: date
  }

  parameter: p_start_date {
    type: date
  }


  parameter: p_end_date {
    type: date
  }



  derived_table: {
    sql: select * from
      (Select
       'azeem' as key,round(sum(total_invoiced_value_gmv )/10000000,2) as current_gmv

       from   `jswone-data-prod.ds_report_blocks.business_overview_direct_and_mfg_table_v2`

       where invoice_date between date({% parameter c_start_date %}) and date({% parameter c_end_date %})) as a

      left join
       (Select
       'azeem' as key,round(sum(total_invoiced_value_gmv )/10000000,2) as pervious_gmv

       from   `jswone-data-prod.ds_report_blocks.business_overview_direct_and_mfg_table_v2`

       where invoice_date between date({% parameter p_start_date %}) and date({% parameter p_end_date %})) as b  using(key) ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: key {
    type: string
    sql: ${TABLE}.key ;;
  }

  dimension: current_gmv {
    type: number
    sql: ${TABLE}.current_gmv ;;
  }

  dimension: pervious_gmv {
    type: number
    sql: ${TABLE}.pervious_gmv ;;
  }

  set: detail {
    fields: [
        key,
  current_gmv,
  pervious_gmv
    ]
  }
}
