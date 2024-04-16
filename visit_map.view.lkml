
view: visit_map {
  derived_table: {
    sql: select * from `jswone-data-prod.ds_report_blocks.visit_call_sf_lead_table` ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }


  dimension: store_location {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }


  dimension: task_visit_id {
    type: string
    sql: ${TABLE}.task_visit_id ;;
  }

  dimension: dp_owner_name {
    type: string
    sql: ${TABLE}.dp_owner_name ;;
  }

  dimension: dp_role {
    type: string
    sql: ${TABLE}.dp_role ;;
  }

  dimension_group: task_visit_created_date {
    type: time
    sql: ${TABLE}.task_visit_created_date ;;
  }

  dimension: data {
    type: string
    sql: ${TABLE}.data ;;
  }

  dimension: primary_id {
    type: string
    sql: ${TABLE}.primary_id ;;
  }

  dimension: total_hrs {
    type: number
    sql: ${TABLE}.total_hrs ;;
  }

  dimension: distance_in_km {
    type: number
    sql: ${TABLE}.distance_in_km ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: outcome {
    type: string
    sql: ${TABLE}.outcome ;;
  }

  dimension: task_visit_account_id {
    type: string
    sql: ${TABLE}.task_visit_account_id ;;
  }

  dimension: check_in_comments {
    type: string
    sql: ${TABLE}.check_in_comments ;;
  }

  dimension: check_out_comments {
    type: string
    sql: ${TABLE}.check_out_comments ;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: gst_c {
    type: string
    sql: ${TABLE}.gst_c ;;
  }

  dimension: dp_business_segment {
    type: string
    sql: ${TABLE}.dp_business_segment ;;
  }

  dimension: customer_type_account_c {
    type: string
    sql: ${TABLE}.customer_type_account_c ;;
  }

  dimension: account_owner_role {
    type: string
    sql: ${TABLE}.account_owner_role ;;
  }

  dimension: account_owner_name {
    type: string
    sql: ${TABLE}.account_owner_name ;;
  }

  dimension: registered_by_name {
    type: string
    sql: ${TABLE}.registered_by_name ;;
  }

  dimension: registered_by_role {
    type: string
    sql: ${TABLE}.registered_by_role ;;
  }

  dimension: registered_by_c {
    type: string
    sql: ${TABLE}.registered_by_c ;;
  }

  dimension: 2nd_opp_created_date {
    type: date
    datatype: date
    sql: ${TABLE}.`2nd_opp_created_date` ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: email_c {
    type: string
    sql: ${TABLE}.email_c ;;
  }

  dimension: account_status_c {
    type: string
    sql: ${TABLE}.account_status_c ;;
  }

  dimension: lost_reason_c {
    type: string
    sql: ${TABLE}.lost_reason_c ;;
  }

  dimension: account_source {
    type: string
    sql: ${TABLE}.account_source ;;
  }

  dimension: account_sub_source {
    type: string
    sql: ${TABLE}.account_sub_source ;;
  }

  dimension: utm_campaign_c {
    type: string
    sql: ${TABLE}.utm_campaign_c ;;
  }

  dimension: utm_element_c {
    type: string
    sql: ${TABLE}.utm_element_c ;;
  }

  dimension: utm_content_c {
    type: string
    sql: ${TABLE}.utm_content_c ;;
  }

  dimension: utm_medium_c {
    type: string
    sql: ${TABLE}.utm_medium_c ;;
  }

  dimension: utm_source_c {
    type: string
    sql: ${TABLE}.utm_source_c ;;
  }

  dimension: created_by_id {
    type: string
    sql: ${TABLE}.created_by_id ;;
  }

  dimension: create_date {
    type: date
    datatype: date
    sql: ${TABLE}.create_date ;;
  }

  dimension: create_time {
    type: date
    datatype: date
    sql: ${TABLE}.create_time ;;
  }

  dimension: stage_based_contacted {
    type: yesno
    sql: ${TABLE}.stage_based_contacted ;;
  }

  dimension: what_id {
    type: string
    sql: ${TABLE}.what_id ;;
  }

  dimension: calls_attempted {
    type: number
    sql: ${TABLE}.calls_attempted ;;
  }

  dimension: calls_answered {
    type: number
    sql: ${TABLE}.calls_answered ;;
  }

  dimension_group: first_call_time {
    type: time
    sql: ${TABLE}.first_call_time ;;
  }

  dimension_group: first_connect_time {
    type: time
    sql: ${TABLE}.first_connect_time ;;
  }

  dimension: qualified {
    type: yesno
    sql: ${TABLE}.qualified ;;
  }

  dimension: registered_c {
    type: yesno
    sql: ${TABLE}.registered_c ;;
  }

  dimension: registration_date {
    type: date
    datatype: date
    sql: ${TABLE}.registration_date ;;
  }

  dimension_group: registration_time {
    type: time
    sql: ${TABLE}.registration_time ;;
  }

  dimension_group: qualification_time {
    type: time
    sql: ${TABLE}.qualification_time ;;
  }

  dimension: num_of_month_from_reg {
    type: number
    sql: ${TABLE}.num_of_month_from_reg ;;
  }

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: opp_count {
    type: number
    sql: ${TABLE}.opp_count ;;
  }

  dimension: order_count {
    type: number
    sql: ${TABLE}.order_count ;;
  }

  dimension: opp_active_month_count {
    type: number
    sql: ${TABLE}.opp_active_month_count ;;
  }

  dimension: first_opp_time {
    type: date
    datatype: date
    sql: ${TABLE}.first_opp_time ;;
  }

  dimension: last_opp_time {
    type: date
    datatype: date
    sql: ${TABLE}.last_opp_time ;;
  }

  dimension: first_order_time {
    type: date
    datatype: date
    sql: ${TABLE}.first_order_time ;;
  }

  dimension: last_order_time {
    type: date
    datatype: date
    sql: ${TABLE}.last_order_time ;;
  }

  dimension: auto_state_c {
    type: string
    sql: ${TABLE}.auto_state_c ;;
  }

  dimension: auto_district_c {
    type: string
    sql: ${TABLE}.auto_district_c ;;
  }

  dimension: test_account_counter {
    type: number
    sql: ${TABLE}.test_account_counter ;;
  }

  dimension: account_record_type {
    type: string
    sql: ${TABLE}.account_record_type ;;
  }

  dimension: num_of_visit {
    type: number
    sql: ${TABLE}.num_of_visit ;;
  }

  dimension: num_of_current_month_visit {
    type: number
    sql: ${TABLE}.num_of_current_month_visit ;;
  }

  dimension: num_of_last_month_visit {
    type: number
    sql: ${TABLE}.num_of_last_month_visit ;;
  }

  dimension: last_visit_in_days {
    type: number
    sql: ${TABLE}.last_visit_in_days ;;
  }

  dimension: call_by_success_ss_fos_team {
    type: number
    sql: ${TABLE}.call_by_success_ss_fos_team ;;
  }

  dimension: call_by_success_ss_fos_team_current_month {
    type: number
    sql: ${TABLE}.call_by_success_ss_fos_team_current_month ;;
  }

  dimension: call_by_success_ss_fos_team_last_month {
    type: number
    sql: ${TABLE}.call_by_success_ss_fos_team_last_month ;;
  }

  dimension: cohort_account_c {
    type: yesno
    sql: ${TABLE}.cohort_account_c ;;
  }

  dimension: account_cohort_owner_c {
    type: string
    sql: ${TABLE}.account_cohort_owner_c ;;
  }

  dimension: dp_cohort_owner_name {
    type: string
    sql: ${TABLE}.dp_cohort_owner_name ;;
  }

  dimension: dp_cohort_owner_role {
    type: string
    sql: ${TABLE}.dp_cohort_owner_role ;;
  }

  dimension: last_case_type {
    type: string
    sql: ${TABLE}.last_case_type ;;
  }

  dimension: last_case_number {
    type: string
    sql: ${TABLE}.last_case_number ;;
  }

  dimension: first_case_type {
    type: string
    sql: ${TABLE}.first_case_type ;;
  }

  dimension: first_case_number {
    type: string
    sql: ${TABLE}.first_case_number ;;
  }

  dimension: first_case_created_date {
    type: date
    datatype: date
    sql: ${TABLE}.first_case_created_date ;;
  }

  dimension: last_case_created_date {
    type: date
    datatype: date
    sql: ${TABLE}.last_case_created_date ;;
  }

  dimension: target_this_month_c {
    type: number
    sql: ${TABLE}.target_this_month_c ;;
  }

  dimension: ihb_c {
    type: yesno
    sql: ${TABLE}.ihb_c ;;
  }

  dimension: influencer_c {
    type: yesno
    sql: ${TABLE}.influencer_c ;;
  }

  dimension: check_success_invoice {
    type: number
    sql: ${TABLE}.check_success_invoice ;;
  }

  dimension: first_invoice_date {
    type: date
    datatype: date
    sql: ${TABLE}.first_invoice_date ;;
  }

  dimension: last_invoice_date {
    type: date
    datatype: date
    sql: ${TABLE}.last_invoice_date ;;
  }

  dimension: total_monthly_order {
    type: number
    sql: ${TABLE}.total_monthly_order ;;
  }

  dimension: check_repeat_buyer {
    type: number
    sql: ${TABLE}.check_repeat_buyer ;;
  }

  dimension: invoice_qty_by_account {
    type: number
    sql: ${TABLE}.invoice_qty_by_account ;;
  }

  dimension: number_of_orders {
    type: number
    sql: ${TABLE}.number_of_orders ;;
  }

  dimension: number_of_success_opp_invoices {
    type: number
    sql: ${TABLE}.number_of_success_opp_invoices ;;
  }

  dimension: num_of_unique_product_enquiry {
    type: number
    sql: ${TABLE}.num_of_unique_product_enquiry ;;
  }

  dimension: primary_revised_qty_total_gst {
    type: number
    sql: ${TABLE}.primary_revised_qty_total_gst ;;
  }

  dimension: active_months {
    type: number
    sql: ${TABLE}.active_months ;;
  }

  dimension: call_visit_by_all_team {
    type: number
    sql: ${TABLE}.call_visit_by_all_team ;;
  }

  dimension: num_opp_vs_active_month_seg {
    type: string
    sql: ${TABLE}.num_opp_vs_active_month_seg ;;
  }

  dimension_group: first_task_visit_created_date {
    type: time
    sql: ${TABLE}.first_task_visit_created_date ;;
  }

  dimension: location {
    type: location
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
  }
  set: detail {
    fields: [
        task_visit_id,
  dp_owner_name,
  dp_role,
  task_visit_created_date_time,
  data,
  primary_id,
  total_hrs,
  distance_in_km,
  latitude,
  longitude,
  outcome,
  task_visit_account_id,
  check_in_comments,
  check_out_comments,
  id,
  gst_c,
  dp_business_segment,
  customer_type_account_c,
  account_owner_role,
  account_owner_name,
  registered_by_name,
  registered_by_role,
  registered_by_c,
  2nd_opp_created_date,
  name,
  email_c,
  account_status_c,
  lost_reason_c,
  account_source,
  account_sub_source,
  utm_campaign_c,
  utm_element_c,
  utm_content_c,
  utm_medium_c,
  utm_source_c,
  created_by_id,
  create_date,
  create_time,
  stage_based_contacted,
  what_id,
  calls_attempted,
  calls_answered,
  first_call_time_time,
  first_connect_time_time,
  qualified,
  registered_c,
  registration_date,
  registration_time_time,
  qualification_time_time,
  num_of_month_from_reg,
  account_id,
  opp_count,
  order_count,
  opp_active_month_count,
  first_opp_time,
  last_opp_time,
  first_order_time,
  last_order_time,
  auto_state_c,
  auto_district_c,
  test_account_counter,
  account_record_type,
  num_of_visit,
  num_of_current_month_visit,
  num_of_last_month_visit,
  last_visit_in_days,
  call_by_success_ss_fos_team,
  call_by_success_ss_fos_team_current_month,
  call_by_success_ss_fos_team_last_month,
  cohort_account_c,
  account_cohort_owner_c,
  dp_cohort_owner_name,
  dp_cohort_owner_role,
  last_case_type,
  last_case_number,
  first_case_type,
  first_case_number,
  first_case_created_date,
  last_case_created_date,
  target_this_month_c,
  ihb_c,
  influencer_c,
  check_success_invoice,
  first_invoice_date,
  last_invoice_date,
  total_monthly_order,
  check_repeat_buyer,
  invoice_qty_by_account,
  number_of_orders,
  number_of_success_opp_invoices,
  num_of_unique_product_enquiry,
  primary_revised_qty_total_gst,
  active_months,
  call_visit_by_all_team,
  num_opp_vs_active_month_seg,
  first_task_visit_created_date_time,
  location
    ]
  }
}
