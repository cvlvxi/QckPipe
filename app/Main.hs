module Main where

newtype Parser a = Parser { runParser :: String -> Maybe (a, String) }

instance Functor Parser where
    fmap fn Parser {runParser = runFn } = Parser { runParser = \s -> do
        (output, rest) <- runFn s
        -- Call the function on theoutput
        return (fn output, rest)
    }

instance Applicative Parser where
    pure x = Parser {runParser = \s -> Just(x, s)}

    Parser {runParser = runFn1 } <*> Parser {runParser = runFn2 } = Parser { runParser = \s -> do
        (outputFn, rest1) <- runFn1 s
        (parserOutput, rest2) <- runFn2 rest1
        return (outputFn parserOutput, rest2)
    }

instance Monad Parser where
    (Parser x) >>= fn = Parser { runParser = \s -> do
        (output, rest) <- x s
        -- (fn output) is Parser B so let's run it with the remainder!
        runParser (fn output) rest
    }

class (Applicative f) => Alternative f where
  empty     :: f a
  (<|>)     :: f a -> f a -> f a
  some      :: f a -> f[a]
  some v  = some_v
    where many_v = some_v <|> pure []
          some_v = (:) <$> v <*> many_v
  many      :: f a -> f [a]
  many v  = many_v
    where many_v = some_v <|> pure []
          some_v = (:) <$> v <*> many_v


instance MonadFail Parser where
    fail _ = Parser { runParser = \s -> Nothing }

instance Alternative Parser where
    empty = fail ""
    (Parser x) <|> (Parser y) = Parser { runParser = \s ->
        case x s of
            Just x  -> Just x
            Nothing -> y s
    }

char :: Char -> Parser Char
char c = Parser charP
    where 
        charP []                   = Nothing
        charP (x:xs)  | x == c     = Just (c,xs)
                      | otherwise  = Nothing

main :: IO ()
main = do
    let parseD = char 'd'
    print $ runParser parseD "dddd"
    -- Just ('d',"ddd")
    print "Done."
