{{
    config(
        schema = 'xchange_ethereum',
        alias = 'base_trades',
        materialized = 'incremental',
        file_format = 'delta',
        incremental_strategy = 'merge',
        unique_key = ['tx_hash', 'evt_index'],
        incremental_predicates = [incremental_predicate('DBT_INTERNAL_DEST.block_time')]
    )
}}

{{
    uniswap_compatible_v2_trades(
        blockchain = 'ethereum',
        project = 'xchange',
        version = '1',
        Pair_evt_Swap = source('xchange_ethereum', 'XchangePair_evt_Swap'),
        Factory_evt_PairCreated = source('xchange_ethereum', 'XchangeFactory_evt_PairCreated')
    )
}}
