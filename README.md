# Hashell 4chan API / Image URL Dumper

This package acts as a library and an executable.

## Library

```haskell
import FourChan

comments_example :: IO ()
comments_example = threadP "b" "423596740" >>= return . maybe [] (map post_com) >>= mapM_ putStrLn
```

## Executable

```text
Usage: 4chan_dump_image_urls <board> <thread>
```

```bash
4chan_dump_image_urls a 123456
```
