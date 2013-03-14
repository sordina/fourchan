{-# LANGUAGE OverloadedStrings #-}


-- | Celebrating the release of the 4chan API at https://github.com/4chan/4chan-API
--   One bug in the API documentation is that 'tim' is optional.

module FourChan
  ( thread
  , threadT
  , threadV
  , threadP
  , Post(..)
  )
  where


-- Imports:

import Data.Aeson as A
import Network.HTTP.Conduit
import Control.Exception as X
import Data.ByteString.Lazy hiding (putStrLn, map)
import Control.Applicative
import Control.Monad


-- Exported Functions:

thread :: (ByteString -> Maybe a) -> Board -> Thread -> IO (Maybe a)
thread f board threadid = flip X.catch errorCase $ fmap f $ simpleHttp ("http://api.4chan.org/" ++ board ++ "/res/" ++ threadid ++ ".json")
  where
    errorCase :: HttpException -> IO (Maybe a)
    errorCase = return $ return Nothing

threadT :: Board -> Thread -> IO (Maybe ByteString)
threadT b t = thread Just b t

threadV :: Board -> Thread -> IO (Maybe Value)
threadV b t = thread decode b t

threadP :: Board -> Thread -> IO (Maybe [Post])
threadP b t = fmap (fmap unTop) $ thread decode b t


-- Type Synonyms:

type Board  = String
type Thread = String


-- Instances:

instance FromJSON Top where
  parseJSON (Object t) = Top <$> t .: "posts"
  parseJSON _          = mzero

instance FromJSON Post where
  parseJSON (Object p) = parsePost p
  parseJSON _          = mzero


-- Data Types:

data Top  = Top { unTop :: [ Post ] } deriving Show

data Post = Post { post_no           :: Integer
                 , post_resto        :: Integer
                 , post_sticky       :: Maybe Integer
                 , post_closed       :: Maybe Integer
                 , post_now          :: String
                 , post_time         :: Integer
                 , post_name         :: String
                 , post_trip         :: Maybe String
                 , post_id           :: Maybe String
                 , post_capcode      :: Maybe String
                 , post_country      :: Maybe String
                 , post_country_name :: Maybe String
                 , post_email        :: Maybe String
                 , post_sub          :: Maybe String
                 , post_com          :: String
                 , post_tim          :: Maybe Integer
                 , post_filename     :: Maybe String
                 , post_ext          :: Maybe String
                 , post_fsize        :: Maybe Integer
                 , post_md5          :: Maybe String
                 , post_w            :: Maybe Integer
                 , post_h            :: Maybe Integer
                 , post_tn_w         :: Maybe Integer
                 , post_tn_h         :: Maybe Integer
                 , post_filedeleted  :: Maybe Integer
                 , post_spoiler      :: Maybe Integer
                 }
                 deriving Show


-- Helpers:

parsePost p = Post <$> p .:  "no"
                   <*> p .:  "resto"
                   <*> p .:? "sticky"
                   <*> p .:? "closed"
                   <*> p .:  "now"
                   <*> p .:  "time"
                   <*> p .:  "name"
                   <*> p .:? "trip"
                   <*> p .:? "id"
                   <*> p .:? "capcode"
                   <*> p .:? "country"
                   <*> p .:? "country_name"
                   <*> p .:? "email"
                   <*> p .:? "sub"
                   <*> p .:  "com"
                   <*> p .:? "tim"
                   <*> p .:? "filename"
                   <*> p .:? "ext"
                   <*> p .:? "fsize"
                   <*> p .:? "md5"
                   <*> p .:? "w"
                   <*> p .:? "h"
                   <*> p .:? "tn_w"
                   <*> p .:? "tn_h"
                   <*> p .:? "filedeleted"
                   <*> p .:? "spoiler"
