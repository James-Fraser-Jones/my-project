module Main where

import Lib

main :: IO ()
main = someFunc

{-
           help menu: stack
            run ghci: stack ghci

create stack project: stack new my-project
                      cd my-project
 get local ghc build: stack setup
       build project: stack build
     execute project: stack exec my-project-exe

Include necessary library packages in "build-depends" section of
"my-project.cabal" file.

You need to rebuild project after including new library packages.

Library packages come from stackage by default in order to prevent dependency hell.

Always search for library package documentation on stackage website and ensure that
the version is the same as the once you're using.
-}
