module Main where

import Lib

main :: IO ()
main = someFunc

-------------------------------------------------------------------------------------------------------

{-
Stack tutorial:

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

Adding language extensions to stack ghci:
"stack ghci --ghci-options "-XOverloadedStrings"
-}

{-
HDBC and SQLite3 Set up:

I installed sqlite3 and the dev library that goes with it into linux with this:
sudo apt-get install sqlite3 libsqlite3-dev

I then added the following dependencies to my executable "build-depends" in the cabal file:
HDBC, HDBC-sqlite3

I then added the following dependency to my extra dependencies section in the stack.yaml file:
extra-deps: [HDBC-sqlite3-2.3.3.1]

I then added the following imports to this main file:
import Database.HDBC.Sqlite3 (connectSqlite3)
import Database.HDBC
-}
