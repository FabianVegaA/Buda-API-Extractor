{-# LANGUAGE OverloadedStrings #-}

module Lib
  ( getMarket,
    getTradedVolume,
    getTicker,
    getOrderBook,
  )
where

import Data.Aeson (Value, decode, withObject, (.:))
import qualified Data.Aeson as Aeson
import Data.Aeson.Key (fromString)
import Data.Aeson.Types (Parser, parseMaybe)
import Data.Text (Text)
import Markets (Market (name), Markets (Markets))
import Network.HTTP.Conduit (simpleHttp)
import OrderBook (OrderBook)
import Ticker (Ticker)
import Volume (Volume)

baseUrl :: String
baseUrl = "https://www.buda.com/api/v2/markets/"

getMarkets :: IO (Maybe Markets)
getMarkets = Aeson.decode <$> simpleHttp baseUrl

getMarket :: String -> IO (Maybe Market)
getMarket market_id = do
  response <- simpleHttp $ baseUrl <> market_id
  return $ parseMaybe market =<< decode response
  where
    market :: Value -> Parser Market
    market = withObject "Market" (.: "market")

getTradedVolume :: String -> IO (Maybe Volume)
getTradedVolume market = do
  response <- simpleHttp (baseUrl <> market <> "/volume")
  return $ parseMaybe volume =<< decode response
  where
    volume :: Value -> Parser Volume
    volume = withObject "Volumes" (.: "volume")

getTicker :: String -> IO (Maybe Ticker)
getTicker market = do
  response <- simpleHttp (baseUrl <> market <> "/ticker")
  return $ parseMaybe ticker =<< decode response
  where
    ticker :: Value -> Parser Ticker
    ticker = withObject "Ticker" (.: "ticker")

getOrderBook :: String -> IO (Maybe OrderBook)
getOrderBook market = do
  response <- simpleHttp (baseUrl <> market <> "/order_book")
  return $ parseMaybe orderBook =<< decode response
  where
    orderBook :: Value -> Parser OrderBook
    orderBook = withObject "OrderBook" (.: "order_book")

-- getTrades :: String -> IO (Maybe Trades)
-- getTrades market = do
--   response <- simpleHttp (baseUrl <> market <> "/trades")
--   return $ parseMaybe trades =<< decode response
--   where
--     trades :: Value -> Parser Trades
--     trades = withObject "Trades" (.: "trades")

nameMarkets :: Markets -> [Text]
nameMarkets (Markets ms) = name <$> ms
