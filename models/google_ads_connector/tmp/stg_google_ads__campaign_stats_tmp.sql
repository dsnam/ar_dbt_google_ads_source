{{ config(enabled=var('api_source') == 'google_ads' and var('ad_reporting__google_ads_enabled')) }}

select * from {{ var('google_ads__campaign_stats') }}
