pigLatin :: String -> String
pigLatin [] = ""
pigLatin str = tail(tail str) ++ [head str] ++ [head(tail str)] ++ "ay"

isVowel :: Char -> Bool
isVowel v = v `elem`['a','e','i','o','u']

main = do
  word1 <- getLine
  word2 <- getLine
  putStrLn (pigLatin word1)
  putStrLn (pigLatin word2)
