{{ config(enabled=var('api_source') == 'adwords' and var('ad_reporting__google_ads_enabled')) }}

select *
from {{ var('google_ads__click_performance') }}