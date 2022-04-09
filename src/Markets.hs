{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Markets
  ( Market (name),
    Markets (..),
  )
where

import Control.Applicative (empty)
import Data.Aeson (FromJSON, Value (Object), (.:))
import qualified Data.Aeson as Aeson
import Data.List (intercalate)
import Data.Text (Text)
import qualified Data.Text
import GHC.Generics (Generic)
import Network.HTTP.Conduit (simpleHttp)

data Market = Market
  { identifier :: Text,
    name :: Text,
    base_currency :: Text,
    quote_currency :: Text,
    minimum_order_amount :: [Text],
    taker_fee :: Text,
    maker_fee :: Text,
    disabled :: Bool,
    illiquid :: Bool,
    rpo_disabled :: Maybe Bool,
    max_orders_per_minute :: Int
  }
  deriving (Generic, Show)

instance FromJSON Market where
  parseJSON (Object v) =
    Market <$> v .: "id"
      <*> v .: "name"
      <*> v .: "base_currency"
      <*> v .: "quote_currency"
      <*> v .: "minimum_order_amount"
      <*> v .: "taker_fee"
      <*> v .: "maker_fee"
      <*> v .: "disabled"
      <*> v .: "illiquid"
      <*> v .: "rpo_disabled"
      <*> v .: "max_orders_per_minute"
  parseJSON _ = empty

newtype Markets = Markets {markets :: [Market]}

instance FromJSON Markets where
  parseJSON (Object v) =
    Markets <$> v .: "markets"
  parseJSON _ = empty

