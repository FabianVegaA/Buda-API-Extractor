module Lib
  ( nameMarkets,
    getMarkets,
  )
where

import Control.Applicative (empty)
import Data.Aeson (FromJSON, Value (Object), (.:))
import qualified Data.Aeson as Aeson
import Data.Aeson.Key (fromString)
import qualified Data.ByteString.Char8 as S8
import Data.Text (Text)
import qualified Data.Text
import GHC.Generics (Generic)
import Network.HTTP.Conduit (simpleHttp)
import Types (Market (name), Markets (Markets))


getMarkets :: IO (Maybe Markets)
getMarkets = Aeson.decode <$> simpleHttp "https://www.buda.com/api/v2/markets"

nameMarkets :: Markets -> [Text]
nameMarkets (Markets ms) = name <$> ms
