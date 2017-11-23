import System.Exit

main :: IO ()
main = fallOverAndDie "Intentional Fail!"

fallOverAndDie :: String -> IO a
fallOverAndDie err = do putStrLn err
                        exitWith (ExitFailure 1)
