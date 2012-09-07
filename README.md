# Haskell 4chan API / Image URL Dumper

Celebrating the release of the 4chan JSON API (published at https://github.com/4chan/4chan-API)
I have released a Haskell interface.

This package acts as an executable and a library.

## Executable

```text
Usage: 4chan_dump_image_urls <board> <thread>
```

```bash
4chan_dump_image_urls a 123456
```

## Library

```haskell
import FourChan

comments_example :: IO ()
comments_example = threadP "b" "423596740" >>= return . maybe [] (map post_com) >>= mapM_ putStrLn
```

There are four functions that are available for scraping threads:

* thread
* threadT
* threadV
* threadP

`thread` takes a bytestring processing function.

`threadT` returns the JSON text for each post.

`threadV` returns the parsed Aeson Value of each post.

`threadP` returns a list of `Post`s.

The following `Post` data-type is exported:

```haskell
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
                 , post_email        :: String
                 , post_sub          :: String
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
```
