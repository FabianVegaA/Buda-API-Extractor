module Main where

import Lib
  ( getMarket,
    getOrderBook,
    getTicker,
    getTradedVolume,
  )

main :: IO ()
main = do
  let market = "btc-clp"
  market' <- getMarket market
  print market'
  tradedVolume <- getTradedVolume market
  print tradedVolume
  ticker <- getTicker market
  print ticker
  orderBook <- getOrderBook market
  print orderBook
