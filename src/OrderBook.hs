{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module OrderBook (OrderBook (..)) where

import Data.Aeson (FromJSON (parseJSON), Value (Object), (.:))
import Data.Text (Text)
import GHC.Generics (Generic)

type Order = [Text]

data OrderBook = OrderBook
  { bids :: [Order],
    asks :: [Order]
  }
  deriving (Show, Generic)

instance FromJSON OrderBook where
  parseJSON (Object v) =
    OrderBook <$> v .: "bids" <*> v .: "asks"
  parseJSON _ = error "Error: OrderBook, expected an object"
