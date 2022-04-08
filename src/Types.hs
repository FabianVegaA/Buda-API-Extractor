{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Types
  ( Market (name),
    Markets (..),
  )
where

import Control.Applicative (empty)
import Data.Aeson (FromJSON, Value (Object), (.:))
import qualified Data.Aeson as Aeson
import Data.Aeson.Key ()
import qualified Data.ByteString.Char8 as S8
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
  deriving (Generic)

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

instance Show Market where
  show (Market _ name _ _ min_order_amount _ _ _ _ _ max_orders_per_minute) =
    Data.Text.unpack name ++ " " ++ show min_order_amount ++ " " ++ show max_orders_per_minute

instance Show Markets where
  show (Markets markets) =
    intercalate "\n" $ map show markets
