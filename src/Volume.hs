{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Volume
  ( Volume (..),
  )
where

import Data.Aeson (FromJSON (parseJSON), Value (Object), (.:))
import GHC.Generics (Generic)
import Data.Text (Text)

data Volume = Volume
  { ask_volume_24h :: [Text],
    ask_volume_7d :: [Text],
    bid_volume_24h :: [Text],
    bid_volume_7d :: [Text],
    market_id :: Text
  }
  deriving (Generic, Show)

instance FromJSON Volume where
  parseJSON (Object v) =
    Volume <$> v .: "ask_volume_24h"
      <*> v .: "ask_volume_7d"
      <*> v .: "bid_volume_24h"
      <*> v .: "bid_volume_7d"
      <*> v .: "market_id"
  parseJSON _ = error "Volume: parseJSON"
