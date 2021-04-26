module Main where


newtype Parser a = Parser { runParser :: String -> Maybe (a, String) }




instance Functor Parser where 
    fmap fn Parser {runParser = runFn } = Parser { runParser = \inputStr -> do
            (output, remainderStr) <- runFn  inputStr
            -- Call the function on theoutput 
            return (fn output, remainderStr)
        }

instance Applicative Parser where
    pure x = Parser {runParser = \inputStr -> Just(x, inputStr)}

    Parser {runParser = runFn1 } <*> Parser {runParser = runFn2 } = Parser { runParser = \inputStr -> do
            (outputFn, remainder1) <- runFn1  inputStr
            (parserOutput, remainderStr2) <- runFn2 remainder1 
            return (outputFn parserOutput, remainderStr2)
        }

instance Monad Parser where
    (Parser x) >>= fn = Parser { runParser = \inputStr -> do
        (output, remainderStr) <- x inputStr
        -- (fn output) is Parser B so let's run it with the remainder!
        runParser (fn output) remainderStr  
    }


main :: IO ()
main = do

  print "Done."
