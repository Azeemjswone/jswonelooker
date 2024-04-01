
view: out_data_business_dashboard {
  derived_table: {
    sql: select * from `jswone-data-prod.ds_report_blocks.business_overview_direct_and_mfg_table_v2` ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # measure: Avg_order_value {
  #   type: number
  #   sql: ${GMV} * 10000000 /  count_distinct(${num_of_order_PT_CN_DN}) ;;
  # }


  measure: Avg_order_value2 {
    type: number
    sql: sum(${TABLE}.total_invoiced_value_gmv) / sum(SELECT COUNT(DISTINCT ${num_of_order_PT_CN_DN}) FROM ${TABLE}) ;;
  }


  measure: nmv_in_cr {
    type: sum
    sql: (
        CASE
          WHEN ${TABLE}.data = 'sap_plant' AND NOT(REGEXP_CONTAINS(${TABLE}.parent_order_id, '-CN') OR REGEXP_CONTAINS(${TABLE}.parent_order_id, '-DN')) THEN ROUND(${TABLE}.base_invoiced_value / 10000000, 2)
          WHEN (REGEXP_CONTAINS(LOWER(${TABLE}.sku_description), 'positive') OR REGEXP_CONTAINS(${TABLE}.parent_order_id, '-CN') OR REGEXP_CONTAINS(${TABLE}.parent_order_id, '-DN')) THEN 0
          ELSE ROUND(${TABLE}.base_invoiced_value / 10000000, 2)
        END
      ) ;;
  }



  measure: GMV {
    type: sum
    drill_fields: [total_invoiced_value_gmv]
    sql: ROUND(${TABLE}.total_invoiced_value_gmv / 10000000, 2) ;;
  }

  measure: NMV {
    type: sum
    drill_fields: [base_invoiced_value]
    sql: ROUND(${TABLE}.base_invoiced_value / 10000000, 2) ;;
  }


  measure: Invoice_qty {
    type: sum
    sql: CASE
         WHEN ${Supplier}  = 'Plant supply' THEN ${TABLE}.total_invoiced_qty
         WHEN LOWER(${uom_2}) = 'mt' THEN ${TABLE}.total_invoiced_qty
         WHEN REGEXP_CONTAINS(LOWER(${uom_2}), 'bag') THEN ${TABLE}.total_invoiced_qty / 20
         WHEN LOWER(${uom_2}) = 'number_of_bags' THEN ${TABLE}.total_invoiced_qty / 20
         WHEN LOWER(${uom_2}) = 'kg' THEN ${TABLE}.total_invoiced_qty / 1000
         ELSE 0
       END ;;
  }

  measure: Invoice_qty_in_CuM {
    type: sum
    sql: CASE WHEN REGEXP_CONTAINS(LOWER(${uom_2}), 'cu') THEN ${TABLE}.total_invoiced_qty ELSE 0 END ;;
  }


  dimension: Supplier {
    type: string
    sql: CASE
         WHEN ${TABLE}.data IN ('amt_utilization', 'plant_order_book_jodl', 'plant_order_book', 'sap_plant')
              OR (${TABLE}.data IN ('order_book', 'distributed') AND ${TABLE}.transaction_type_pid = 'Direct') THEN 'Plant supply'
         WHEN ${TABLE}.data IN ('order_book', 'distributed')
              AND ${TABLE}.transaction_type_pid != 'Direct' AND ${TABLE}.transaction_nature != 'Inventory' THEN 'Distributor'
         WHEN ${TABLE}.data IN ('order_book', 'distributed')
              AND ${TABLE}.transaction_type_pid != 'Direct' AND ${TABLE}.transaction_nature = 'Inventory' THEN 'T1S'
         WHEN ${TABLE}.data = 'ERP' THEN 'ERP'
         WHEN ${TABLE}.data = 'ERP-PS' THEN 'ERP-PS'
         WHEN ${TABLE}.data = 'LU' THEN 'LU'
         ELSE 'Other'
       END ;;
  }



  dimension: num_of_order_PT_CN_DN {
    type: string
    sql: CASE
         WHEN ${TABLE}.data = 'sap_plant' AND NOT(REGEXP_CONTAINS(IFNULL(${TABLE}.parent_order_id,'No data'),'-CN') OR REGEXP_CONTAINS(IFNULL(${TABLE}.parent_order_id,'No data'),'-DN') OR REGEXP_CONTAINS(IFNULL(${TABLE}.sku_id,'No data'),'-DN') OR REGEXP_CONTAINS(IFNULL(${TABLE}.sku_id,'No data'),'-CN') ) THEN ${TABLE}.parent_order_id
         WHEN NOT (REGEXP_CONTAINS(${TABLE}.material_code, '^9') OR REGEXP_CONTAINS(IFNULL(${TABLE}.parent_order_id,'No data'),'-CN') OR REGEXP_CONTAINS(IFNULL(${TABLE}.parent_order_id,'No data'),'-DN') OR REGEXP_CONTAINS(IFNULL(${TABLE}.sku_id,'No data'),'-DN') OR REGEXP_CONTAINS(IFNULL(${TABLE}.sku_id,'No data'),'-CN') ) THEN ${TABLE}.parent_order_id
         ELSE NULL
       END ;;
  }

  dimension: num_of_customer_billed {
    type: string
    sql: CASE
          WHEN NOT(REGEXP_CONTAINS(IFNULL(${TABLE}.material_code, '0'), '^9') OR REGEXP_CONTAINS(${TABLE}.sku_id, '-CN') OR REGEXP_CONTAINS(${TABLE}.sku_id, '-DN') OR REGEXP_CONTAINS(${TABLE}.parent_order_id, '-CN') OR REGEXP_CONTAINS(${TABLE}.parent_order_id, '-DN')) THEN ${TABLE}.buyer_id
       END ;;
  }

  dimension: uom_2 {
    type: string
    sql: CASE
         WHEN REGEXP_CONTAINS(${TABLE}.data, 'ERP') THEN ${TABLE}.erp_uom
         WHEN ${TABLE}.erp_uom IS NOT NULL THEN ${TABLE}.erp_uom
         ELSE ${TABLE}.uom
       END ;;
  }





  dimension: o1_o2_segmentation {
    type: string
    sql: ${TABLE}.o1_o2_segmentation ;;
  }

  dimension: active_buying_month {
    type: number
    sql: ${TABLE}.active_buying_month ;;
  }

  dimension: num_of_month_after_1st_order {
    type: number
    sql: ${TABLE}.num_of_month_after_1st_order ;;
  }

  dimension: cross_category_distinct_count {
    type: number
    sql: ${TABLE}.cross_category_distinct_count ;;
  }

  dimension: cross_category_dit_mtd {
    type: number
    sql: ${TABLE}.cross_category_dit_mtd ;;
  }

  dimension: max_normal_row_count {
    type: number
    sql: ${TABLE}.max_normal_row_count ;;
  }

  dimension: max_normal_row_count_ctype {
    type: number
    sql: ${TABLE}.max_normal_row_count_ctype ;;
  }

  dimension: num_of_unique_monthly_order {
    type: number
    sql: ${TABLE}.num_of_unique_monthly_order ;;
  }

  dimension: r_n {
    type: number
    sql: ${TABLE}.r_n ;;
  }

  dimension: repeat_buyer_check {
    type: number
    sql: ${TABLE}.repeat_buyer_check ;;
  }

  dimension: data {
    type: string
    sql: ${TABLE}.data ;;
  }

  dimension: jodl_jopl {
    type: string
    sql: ${TABLE}.jodl_jopl ;;
  }

  dimension: child_order_id {
    type: string
    sql: ${TABLE}.child_order_id ;;
  }

  dimension: sku_id {
    type: string
    sql: ${TABLE}.sku_id ;;
  }

  dimension: ops_poc {
    type: string
    sql: ${TABLE}.ops_poc ;;
  }

  dimension: sku_description {
    type: string
    sql: ${TABLE}.sku_description ;;
  }

  dimension: invoice_no {
    type: string
    sql: ${TABLE}.invoice_no ;;
  }

  dimension: invoice_date {
    type: date
    datatype: date
    sql: ${TABLE}.invoice_date ;;
  }

  dimension: total_cancelled_qty {
    type: number
    sql: ${TABLE}.total_cancelled_qty ;;
  }

  dimension: total_rejected_qty {
    type: number
    sql: ${TABLE}.total_rejected_qty ;;
  }

  dimension: final_invoiced_price_per_unit {
    type: number
    sql: ${TABLE}.final_invoiced_price_per_unit ;;
  }

  dimension: base_invoiced_value {
    type: number
    sql: ${TABLE}.base_invoiced_value ;;
  }

  dimension: total_invoiced_value_gmv {
    type: number
    sql: ${TABLE}.total_invoiced_value_gmv ;;
  }

  dimension: parent_order_id {
    type: string
    sql: ${TABLE}.parent_order_id ;;
  }

  dimension: order_type_pid {
    type: string
    sql: ${TABLE}.order_type_pid ;;
  }

  dimension: transaction_at_cid {
    type: string
    sql: ${TABLE}.transaction_at_cid ;;
  }

  dimension: transaction_via_pid {
    type: string
    sql: ${TABLE}.transaction_via_pid ;;
  }

  dimension: transaction_type_pid {
    type: string
    sql: ${TABLE}.transaction_type_pid ;;
  }

  dimension: payment_type {
    type: string
    sql: ${TABLE}.payment_type ;;
  }

  dimension: buyer_id {
    type: string
    sql: ${TABLE}.buyer_id ;;
  }

  dimension: buyer_name {
    type: string
    sql: ${TABLE}.buyer_name ;;
  }

  dimension: actual_seller_id {
    type: string
    sql: ${TABLE}.actual_seller_id ;;
  }

  dimension: actual_seller_name {
    type: string
    sql: ${TABLE}.actual_seller_name ;;
  }

  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.opportunity_id ;;
  }

  dimension: sales_spoc {
    type: string
    sql: ${TABLE}.sales_spoc ;;
  }

  dimension: total_short_closed_qty {
    type: number
    sql: ${TABLE}.total_short_closed_qty ;;
  }

  dimension: invoiced_price_per_unit_rate {
    type: number
    sql: ${TABLE}.invoiced_price_per_unit_rate ;;
  }

  dimension: upfront_discount_value_per_unit {
    type: number
    sql: ${TABLE}.upfront_discount_value_per_unit ;;
  }

  dimension: gst {
    type: number
    sql: ${TABLE}.gst ;;
  }

  dimension: final_execution_on_oms {
    type: string
    sql: ${TABLE}.final_execution_on_oms ;;
  }

  dimension: order_date {
    type: string
    sql: ${TABLE}.order_date ;;
  }

  dimension: sf_opportunity_id {
    type: string
    sql: ${TABLE}.sf_opportunity_id ;;
  }

  dimension: sf_sales_channel {
    type: string
    sql: ${TABLE}.sf_sales_channel ;;
  }

  dimension: oms_order_id {
    type: string
    sql: ${TABLE}.oms_order_id ;;
  }

  dimension: sf_gstin {
    type: string
    sql: ${TABLE}.sf_gstin ;;
  }

  dimension: transaction_nature {
    type: string
    sql: ${TABLE}.transaction_nature ;;
  }

  dimension: payment_sheet_gst {
    type: number
    sql: ${TABLE}.payment_sheet_gst ;;
  }

  dimension: cgst {
    type: number
    sql: ${TABLE}.cgst ;;
  }

  dimension: sgst {
    type: number
    sql: ${TABLE}.sgst ;;
  }

  dimension: igst {
    type: number
    sql: ${TABLE}.igst ;;
  }

  dimension: purchase_order_id {
    type: string
    sql: ${TABLE}.purchase_order_id ;;
  }

  dimension: cashback {
    type: string
    sql: ${TABLE}.cashback ;;
  }

  dimension: purchase_value {
    type: string
    sql: ${TABLE}.purchase_value ;;
  }

  dimension: received_po_doc_no {
    type: string
    sql: ${TABLE}.received_po_doc_no ;;
  }

  dimension: received_po_doc_date {
    type: string
    sql: ${TABLE}.received_po_doc_date ;;
  }

  dimension: credit_days {
    type: number
    sql: ${TABLE}.credit_days ;;
  }

  dimension: seller_invoice_number {
    type: string
    sql: ${TABLE}.seller_invoice_number ;;
  }

  dimension: seller_invoice_date {
    type: date
    datatype: date
    sql: ${TABLE}.seller_invoice_date ;;
  }

  dimension: sf_opp_owner_name {
    type: string
    sql: ${TABLE}.sf_opp_owner_name ;;
  }

  dimension: nodal_non_nodal {
    type: string
    sql: ${TABLE}.nodal_non_nodal ;;
  }

  dimension: internal_doc_no {
    type: string
    sql: ${TABLE}.internal_doc_no ;;
  }

  dimension: linked_purchase_sku_id {
    type: string
    sql: ${TABLE}.linked_purchase_sku_id ;;
  }

  dimension: credit_limit_reference_id {
    type: string
    sql: ${TABLE}.credit_limit_reference_id ;;
  }

  dimension: actual_vendor_code {
    type: string
    sql: ${TABLE}.actual_vendor_code ;;
  }

  dimension: seller_id {
    type: string
    sql: ${TABLE}.seller_id ;;
  }

  dimension: seller_name {
    type: string
    sql: ${TABLE}.seller_name ;;
  }

  dimension: erp_uom {
    type: string
    sql: ${TABLE}.erp_uom ;;
  }

  dimension: material_code {
    type: string
    sql: ${TABLE}.material_code ;;
  }

  dimension: total_invoiced_qty {
    type: number
    sql: ${TABLE}.total_invoiced_qty ;;
  }

  dimension: master_data {
    type: string
    sql: ${TABLE}.master_data ;;
  }

  dimension: mm_description_concatenated {
    type: string
    sql: ${TABLE}.MM_Description_concatenated ;;
  }

  dimension: master_category {
    type: string
    sql: ${TABLE}.master_category ;;
  }

  dimension: sub_category {
    type: string
    sql: ${TABLE}.sub_category ;;
  }

  dimension: child_category {
    type: string
    sql: ${TABLE}.child_category ;;
  }

  dimension: leaf_category {
    type: string
    sql: ${TABLE}.leaf_category ;;
  }

  dimension: form {
    type: string
    sql: ${TABLE}.form ;;
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
  }

  dimension: category_key {
    type: string
    sql: ${TABLE}.category_key ;;
  }

  dimension: grade {
    type: string
    sql: ${TABLE}.grade ;;
  }

  dimension: sub_grade {
    type: string
    sql: ${TABLE}.sub_grade ;;
  }

  dimension: type_of_cement {
    type: string
    sql: ${TABLE}.type_of_cement ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: sub_brand {
    type: string
    sql: ${TABLE}.sub_brand ;;
  }

  dimension: aws_code {
    type: string
    sql: ${TABLE}.aws_code ;;
  }

  dimension: product_key {
    type: string
    sql: ${TABLE}.product_key ;;
  }

  dimension: diameter {
    type: string
    sql: ${TABLE}.diameter ;;
  }

  dimension: thickness {
    type: string
    sql: ${TABLE}.thickness ;;
  }

  dimension: width {
    type: string
    sql: ${TABLE}.width ;;
  }

  dimension: length {
    type: string
    sql: ${TABLE}.length ;;
  }

  dimension: cut_length {
    type: string
    sql: ${TABLE}.cut_length ;;
  }

  dimension: coating_grade_gsm {
    type: string
    sql: ${TABLE}.coating_grade_gsm ;;
  }

  dimension: spangle_type {
    type: string
    sql: ${TABLE}.spangle_type ;;
  }

  dimension: colour {
    type: string
    sql: ${TABLE}.colour ;;
  }

  dimension: finish {
    type: string
    sql: ${TABLE}.finish ;;
  }

  dimension: uom {
    type: string
    sql: ${TABLE}.uom ;;
  }

  dimension: packaging_type {
    type: string
    sql: ${TABLE}.packaging_type ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: web_structural_steel {
    type: string
    sql: ${TABLE}.web_structural_steel ;;
  }

  dimension: flange_structural_steel {
    type: string
    sql: ${TABLE}.flange_structural_steel ;;
  }

  dimension: leg_structural_steel {
    type: string
    sql: ${TABLE}.leg_structural_steel ;;
  }

  dimension: sectional_weight_structural_steel {
    type: string
    sql: ${TABLE}.sectional_weight_structural_steel ;;
  }

  dimension: tmt_form {
    type: string
    sql: ${TABLE}.tmt_form ;;
  }

  dimension: hsn {
    type: string
    sql: ${TABLE}.hsn ;;
  }

  dimension: tax {
    type: string
    sql: ${TABLE}.tax ;;
  }

  dimension: variant_key {
    type: string
    sql: ${TABLE}.variant_key ;;
  }

  dimension: created_at {
    type: string
    sql: ${TABLE}.created_at ;;
  }

  dimension: outside_diameter {
    type: string
    sql: ${TABLE}.outside_diameter ;;
  }

  dimension: weight_in_kg_per_mtr {
    type: number
    sql: ${TABLE}.weight_in_kg_per_mtr ;;
  }

  dimension: category2 {
    type: string
    sql: ${TABLE}.category2 ;;
  }

  dimension: buyer_gstin {
    type: string
    sql: ${TABLE}.buyer_gstin ;;
  }

  dimension: gst_verified_company_name {
    type: string
    sql: ${TABLE}.gst_verified_company_name ;;
  }

  dimension: billing_address {
    type: string
    sql: ${TABLE}.billing_address ;;
  }

  dimension: billing_pincode {
    type: string
    sql: ${TABLE}.billing_pincode ;;
  }

  dimension: billing_city {
    type: string
    sql: ${TABLE}.billing_city ;;
  }

  dimension: biiling_state {
    type: string
    sql: ${TABLE}.biiling_state ;;
  }

  dimension: billing_region {
    type: string
    sql: ${TABLE}.billing_region ;;
  }

  dimension: shipping_address {
    type: string
    sql: ${TABLE}.shipping_address ;;
  }

  dimension: shipping_pincode {
    type: string
    sql: ${TABLE}.shipping_pincode ;;
  }

  dimension: shipping_city {
    type: string
    sql: ${TABLE}.shipping_city ;;
  }

  dimension: shipping_state {
    type: string
    sql: ${TABLE}.shipping_state ;;
  }

  dimension: customer_category {
    type: string
    sql: ${TABLE}.customer_category ;;
  }

  dimension: buyer_master_datasource {
    type: string
    sql: ${TABLE}.buyer_master_datasource ;;
  }

  dimension: count_parent_id {
    type: number
    sql: ${TABLE}.count_parent_id ;;
  }

  dimension: month_total_gmv {
    type: number
    sql: ${TABLE}.month_total_gmv ;;
  }

  dimension: month_total_gmv_seller {
    type: number
    sql: ${TABLE}.month_total_gmv_seller ;;
  }

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.opportunity_name ;;
  }

  dimension: sf_business_segment {
    type: string
    sql: ${TABLE}.sf_business_segment ;;
  }

  dimension: is_plant_supply_c {
    type: yesno
    sql: ${TABLE}.is_plant_supply_c ;;
  }

  dimension: dp_owner_name {
    type: string
    sql: ${TABLE}.dp_owner_name ;;
  }

  dimension: created_date {
    type: date
    datatype: date
    sql: ${TABLE}.Created_Date ;;
  }

  dimension: account_owner_role {
    type: string
    sql: ${TABLE}.account_owner_role ;;
  }

  dimension: last_opp_created_date {
    type: date
    datatype: date
    sql: ${TABLE}.last_opp_created_date ;;
  }

  dimension: last_invoice_date {
    type: date
    datatype: date
    sql: ${TABLE}.last_invoice_date ;;
  }

  dimension: first_invoice_date {
    type: date
    datatype: date
    sql: ${TABLE}.first_invoice_date ;;
  }

  dimension: first_billing_customer {
    type: string
    sql: ${TABLE}.first_billing_customer ;;
  }

  dimension: account_source {
    type: string
    sql: ${TABLE}.account_source ;;
  }

  dimension: account_record_type {
    type: string
    sql: ${TABLE}.account_record_type ;;
  }

  dimension: utm_campaign_c {
    type: string
    sql: ${TABLE}.utm_campaign_c ;;
  }

  dimension: registered_by_role {
    type: string
    sql: ${TABLE}.registered_by_role ;;
  }

  dimension: direct_customer_category_c {
    type: string
    sql: ${TABLE}.direct_customer_category_c ;;
  }

  dimension: utm_source_c {
    type: string
    sql: ${TABLE}.utm_source_c ;;
  }

  dimension: utm_medium_c {
    type: string
    sql: ${TABLE}.utm_medium_c ;;
  }

  dimension: utm_element_c {
    type: string
    sql: ${TABLE}.utm_element_c ;;
  }

  dimension: utm_content_c {
    type: string
    sql: ${TABLE}.utm_content_c ;;
  }

  dimension: first_account_owner_c {
    type: string
    sql: ${TABLE}.first_account_owner_c ;;
  }

  dimension: denserank_base_on_gmv {
    type: number
    sql: ${TABLE}.denserank_base_on_gmv ;;
  }

  dimension: denserank_base_on_gmv_seller {
    type: number
    sql: ${TABLE}.denserank_base_on_gmv_seller ;;
  }

  dimension: fy_invoice_quarter {
    type: string
    sql: ${TABLE}.fy_invoice_quarter ;;
  }

  dimension: fy_first_invoice_quarter {
    type: string
    sql: ${TABLE}.fy_first_invoice_quarter ;;
  }

  dimension: cf_dp_state {
    type: string
    sql: ${TABLE}.cf_dp_state ;;
  }

  dimension: dp_district {
    type: string
    sql: ${TABLE}.dp_district ;;
  }

  dimension: cf_role {
    type: string
    sql: ${TABLE}.cf_role ;;
  }

  dimension: customer_type_account_c {
    type: string
    sql: ${TABLE}.customer_type_account_c ;;
  }

  dimension: business_unit {
    type: string
    sql: ${TABLE}.business_unit ;;
  }

  dimension: business_unit_2 {
    type: string
    sql: ${TABLE}.business_unit_2 ;;
  }

  dimension: agg_customer_type_2 {
    type: string
    sql: ${TABLE}.agg_customer_type_2 ;;
  }

  dimension: total_monthly_order {
    type: number
    sql: ${TABLE}.total_monthly_order ;;
  }

  dimension: max_gmv_lifetime_last_12m {
    type: number
    sql: ${TABLE}.max_gmv_lifetime_last_12m ;;
  }

  dimension: max_gmv_lifetime_last_3m {
    type: number
    sql: ${TABLE}.max_gmv_lifetime_last_3m ;;
  }

  dimension: max_gmv_lifetime_last_12m_ctype {
    type: number
    sql: ${TABLE}.max_gmv_lifetime_last_12m_ctype ;;
  }

  dimension: max_gmv_lifetime_last_3m_ctype {
    type: number
    sql: ${TABLE}.max_gmv_lifetime_last_3m_ctype ;;
  }

  set: detail {
    fields: [
        o1_o2_segmentation,
  active_buying_month,
  num_of_month_after_1st_order,
  cross_category_distinct_count,
  cross_category_dit_mtd,
  max_normal_row_count,
  max_normal_row_count_ctype,
  num_of_unique_monthly_order,
  r_n,
  repeat_buyer_check,
  data,
  jodl_jopl,
  child_order_id,
  sku_id,
  ops_poc,
  sku_description,
  invoice_no,
  invoice_date,
  total_cancelled_qty,
  total_rejected_qty,
  final_invoiced_price_per_unit,
  base_invoiced_value,
  total_invoiced_value_gmv,
  parent_order_id,
  order_type_pid,
  transaction_at_cid,
  transaction_via_pid,
  transaction_type_pid,
  payment_type,
  buyer_id,
  buyer_name,
  actual_seller_id,
  actual_seller_name,
  opportunity_id,
  sales_spoc,
  total_short_closed_qty,
  invoiced_price_per_unit_rate,
  upfront_discount_value_per_unit,
  gst,
  final_execution_on_oms,
  order_date,
  sf_opportunity_id,
  sf_sales_channel,
  oms_order_id,
  sf_gstin,
  transaction_nature,
  payment_sheet_gst,
  cgst,
  sgst,
  igst,
  purchase_order_id,
  cashback,
  purchase_value,
  received_po_doc_no,
  received_po_doc_date,
  credit_days,
  seller_invoice_number,
  seller_invoice_date,
  sf_opp_owner_name,
  nodal_non_nodal,
  internal_doc_no,
  linked_purchase_sku_id,
  credit_limit_reference_id,
  actual_vendor_code,
  seller_id,
  seller_name,
  erp_uom,
  material_code,
  total_invoiced_qty,
  master_data,
  mm_description_concatenated,
  master_category,
  sub_category,
  child_category,
  leaf_category,
  form,
  product_type,
  category_key,
  grade,
  sub_grade,
  type_of_cement,
  brand,
  sub_brand,
  aws_code,
  product_key,
  diameter,
  thickness,
  width,
  length,
  cut_length,
  coating_grade_gsm,
  spangle_type,
  colour,
  finish,
  uom,
  packaging_type,
  description,
  web_structural_steel,
  flange_structural_steel,
  leg_structural_steel,
  sectional_weight_structural_steel,
  tmt_form,
  hsn,
  tax,
  variant_key,
  created_at,
  outside_diameter,
  weight_in_kg_per_mtr,
  category2,
  buyer_gstin,
  gst_verified_company_name,
  billing_address,
  billing_pincode,
  billing_city,
  biiling_state,
  billing_region,
  shipping_address,
  shipping_pincode,
  shipping_city,
  shipping_state,
  customer_category,
  buyer_master_datasource,
  count_parent_id,
  month_total_gmv,
  month_total_gmv_seller,
  account_id,
  opportunity_name,
  sf_business_segment,
  is_plant_supply_c,
  dp_owner_name,
  created_date,
  account_owner_role,
  last_opp_created_date,
  last_invoice_date,
  first_invoice_date,
  first_billing_customer,
  account_source,
  account_record_type,
  utm_campaign_c,
  registered_by_role,
  direct_customer_category_c,
  utm_source_c,
  utm_medium_c,
  utm_element_c,
  utm_content_c,
  first_account_owner_c,
  denserank_base_on_gmv,
  denserank_base_on_gmv_seller,
  fy_invoice_quarter,
  fy_first_invoice_quarter,
  cf_dp_state,
  dp_district,
  cf_role,
  customer_type_account_c,
  business_unit,
  business_unit_2,
  agg_customer_type_2,
  total_monthly_order,
  max_gmv_lifetime_last_12m,
  max_gmv_lifetime_last_3m,
  max_gmv_lifetime_last_12m_ctype,
  max_gmv_lifetime_last_3m_ctype
    ]
  }
}
