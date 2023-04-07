{-# LANGUAGE RecordWildCards #-}

module ExampleModule 
    ( ExampleRecord (..) 
    , someRecord
    , mkRec
    , mkRec2
    , mkRec3
    , mkRec4
    ) where

import Data.Maybe hiding (fromJust)
import Data.Functor ((<$>))

data ExampleRecord
    = ExampleRecord
    { name :: String
    , mmUnit :: Maybe (Maybe ())
    } 
    deriving (Eq, Show)

getName :: ExampleRecord -> String
getName ExampleRecord {..} = name

someRecord :: ExampleRecord
someRecord = anotherRecord { name = "xyz" }
    where anotherRecord = mkRec "" Nothing

mkRec :: String -> Maybe (Maybe a) -> ExampleRecord
mkRec name (Just (Just _)) = ExampleRecord {..}
    where mmUnit = Just $ Just ()
mkRec name (Just _) = ExampleRecord {..}
    where mmUnit = Just Nothing
mkRec name _ = ExampleRecord {..}
    where mmUnit = Nothing

mkRec2 :: String -> String -> ExampleRecord
mkRec2 first last = mkRec (first <> " " <> last) Nothing

mkRec3 :: [Char] -> ExampleRecord
mkRec3 (a:b:c:_) = mkRec [a, b, c] Nothing
mkRec3 _ = mkRec "" Nothing

mkRec4 :: (String, String) -> ExampleRecord
mkRec4 (a, b) = mkRec (a <> b) Nothing
