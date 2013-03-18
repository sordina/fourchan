
-- Imports:

import FourChan
import System.Environment
import Control.Monad
import Data.Monoid
import Data.Maybe
import Data.List.Split
import Safe

-- Main:

main :: IO ()
main = do args <- getArgs
          case args of [u] -> run $ mapMaybe (splitOn "/" u `atMay`) [3, 5]
                       x   -> run x

run :: [String] -> IO ()
run [b,t] = threadP b t >>= return . maybe [] (mapMaybe (image_url b)) >>= mapM_ putStrLn
run _     = putStrLn "Usage: 4chan_dump_image_urls <board> <thread>"

image_url :: String -> Post -> Maybe String
image_url b p = mand [ Just "http://images.4chan.org/"
                     , Just b
                     , Just "/src/"
                     , fmap show $ post_tim p
                     , post_ext p
                     ]

mand :: Monoid a => [Maybe a] -> Maybe a
mand = Prelude.foldl (liftM2 mappend) (Just mempty)
