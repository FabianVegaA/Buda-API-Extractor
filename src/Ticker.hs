{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Ticker
  ( Ticker (..),
  )
where

import Data.Aeson (FromJSON (parseJSON), Value (Object), (.:))
import Data.Text (Text)
import GHC.Generics (Generic)

data Ticker = Ticker
  { market_id :: Text,
    last_price :: [Text],
    max_bid :: [Text],
    min_ask :: [Text],
    price_variation_24h :: Text,
    price_variation_7d :: Text,
    volume :: [Text]
  }
  deriving (Show, Generic)

instance FromJSON Ticker where
  parseJSON (Object v) =
    Ticker <$> v .: "market_id"
      <*> v .: "last_price"
      <*> v .: "max_bid"
      <*> v .: "min_ask"
      <*> v .: "price_variation_24h"
      <*> v .: "price_variation_7d"
      <*> v .: "volume"
  parseJSON _ = error "Error: Ticker, expected an object"