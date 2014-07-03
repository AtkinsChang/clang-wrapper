import System.Environment
import System.Process
import Data.List (isInfixOf)

clang = "/usr/bin/clang" 

flags = [ "-Wno-invalid-pp-token" 
        , "-Wno-unicode"
        , "-Wno-trigraphs"
        ]

check args
        | and (map (`elem` args) ["-E","-undef","-traditional"]) = replace args
        | otherwise = args

replace ("-x":"c":xs) = "-x":"assembler-with-cpp":replace xs
replace (x:xs) = x:replace xs
replace [] = []

main = do
        args <- getArgs
        rawSystem clang $ flags ++ (check args)
