
-- Imports:

import FourChan
import System.Environment
import Control.Monad
import Data.Monoid
import Data.Maybe

-- Main:

main :: IO ()
main = do
  args <- getArgs
  case args of [b,t] -> threadP b t >>= return . maybe [] (mapMaybe image_url) >>= mapM_ putStrLn
               _     -> putStrLn "Usage: 4chan_dump_image_urls <board> <thread>"

-- Helpers:

images :: IO [String]
images = threadP "b" "423596740" >>= return . maybe [] (mapMaybe image_url)

image_url :: Post -> Maybe String
image_url p = mand [Just "http://images.4chan.org/b/src/", fmap show $ post_tim p, post_ext p]

mand :: Monoid a => [Maybe a] -> Maybe a
mand = Prelude.foldl (liftM2 mappend) (Just mempty)
