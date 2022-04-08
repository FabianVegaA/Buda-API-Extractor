module Main where

import Lib (nameMarkets, getMarkets)

main :: IO ()
main = do
    (Just ms) <- getMarkets
    print ms

