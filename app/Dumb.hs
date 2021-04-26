-- module Main where


newtype Parser a = Parser { runParser :: String -> Maybe (a, String) }

instance Functor Parser where 
  fmap f (Parser { runParser = x }) = Parser (\strInput -> do {
    (thing, remainderString) <- x strInput;
    return (f thing, remainderString)
  })


main :: IO ()
main = do
  -- let dog = Just 1
  -- let cat = Parser (\s -> Just (dog, "dog")) :: Parser (Maybe Integer)
  let someParser = Parser (\s -> Just(1, "dog")) :: Parser Int
  let a = fmap (+1) someParser
  let b = runParser a "dog"
  print b
  print "Done."
