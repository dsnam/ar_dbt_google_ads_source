{{ config(enabled=var('api_source') == 'google_ads' and var('ad_reporting__google_ads_enabled')) }}

with base as (
    select *
    from {{ ref('stg_google_ads__campaign_stats_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_ads__campaign_stats_tmp')),
                staging_columns=get_campaign_stats_columns()
            )
        }}
        
    from base
),

final as (
    select
        id as campaign_id,
        customer_id as account_id,
        date as date_day,
        clicks,
        impressions,
        cost_micros / 1000000.0 as spend,
        conversions,
        conversions_value
    from fields
)

select * from final