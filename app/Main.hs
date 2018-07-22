module Main where

import Lib
import System.Directory (doesFileExist)
import Database.HDBC.Sqlite3 (connectSqlite3)
import Database.HDBC
import Data.Functor

main :: IO ()
main = someFunc

{-
validation for creating a new database:
1. If string is empty, it's invalid (length == 0)
2. Check for illegal ch
2. If string does not contain ".db" file extension, add it ????
3. If newly modified filename already exists (doesFileExist), it's invalid
-}

auctionTableName :: String
auctionTableName = "auction"

createAuctionTable :: IConnection conn => conn -> IO ()
createAuctionTable = flip runRaw $ "CREATE TABLE " ++ auctionTableName ++ " (Vendor INTEGER, LotNumber INTEGER, Description TEXT, Reserve REAL, PreSaleBids REAL, SalePrice REAL, Purchaser INTEGER, SaleID INTEGER)"

addItem :: IConnection conn => conn -> IO Statement
addItem = flip prepare $ "INSERT INTO " ++ auctionTableName ++ " VALUES (?, ?, ?, ?, ?, ?, ?, ?)"

createDB :: String -> IO ()
createDB name = do
  conn <- connectSqlite3 name --connect to the database
  createAuctionTable conn
  add <- addItem conn
  execute add $ hsToDb ex1
  commit conn --commit changes
  disconnect conn --good to be explicit about disconnecting at the end

-------------------------------------------------------------------------------------------------------
--Converting between Haskell and DB records

data Item = Item {
  vendor :: Int,
  lotNumber :: Int,
  description :: String,
  reserve :: Maybe Double,
  preSaleBids :: Maybe Double,
  salePrice :: Maybe Double,
  purchaser :: Maybe Int,
  saleID :: Maybe Int
}

hsToDb :: Item -> [SqlValue]
hsToDb (Item a b c d e f g h) = [toSql a, toSql b, toSql c, toSql d, toSql e, toSql f, toSql g, toSql h]

dbToHs :: [SqlValue] -> Item
dbToHs [a,b,c,d,e,f,g,h] = Item (fromSql a) (fromSql b) (fromSql c) (fromSql d) (fromSql e) (fromSql f) (fromSql g) (fromSql h)

ex1 :: Item
ex1 = Item 5 4 "Metal Chair" (Just 3.0) Nothing (Just 4.45) (Just 5) (Just 22)

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
