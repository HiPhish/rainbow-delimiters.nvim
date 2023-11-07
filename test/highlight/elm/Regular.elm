module Regular exposing (CustomType(..))

import Browser exposing (UrlRequest(..))
import Url.Parser exposing ((</>), (<?>))


type CustomType a
    = CustomType a


type alias NestedRecordOfCustomType a =
    { a : ( Int, List (Maybe ( Int, CustomType a )) )
    , b : ( Int, { c : CustomType a } )
    , d : { f : { g : String } }
    }


nestedTypeExpr : Int -> (Int -> Int) -> (Int -> (Int -> Int))
nestedTypeExpr x y =
    \z -> y


nestedListPatternFunction : List (List ( Int, List ( Int, String ) )) -> List ( String, Int )
nestedListPatternFunction list =
    List.concatMap (\( _, strings ) -> List.map (\( a, b ) -> ( b, a )) strings) (List.concat list)


unwrapCustomType : { b | c : Int } -> CustomType (CustomType { a : Int }) -> Int
unwrapCustomType { c } (CustomType (CustomType ({ a } as b))) =
    (a + (c * 1)) * (a - (a + (b.a * 1)))


patternMatchNestedListOfRecords : List (List (NestedRecordOfCustomType Int)) -> Maybe (List (List (NestedRecordOfCustomType Int)))
patternMatchNestedListOfRecords list =
    case [ list ] of
        [ [ [ { a, b } ] ] ] ->
            case ( a, b ) of
                ( ( 1, [ Just ( 1, ct ) ] ), ( 2, { c } ) ) ->
                    Just
                        [ [ { a = ( 1, [ Just ( 1, c ) ] )
                            , b = ( 2, { c = ct } )
                            , d = { f = { g = "test" } }
                            }
                          ]
                        ]

                _ ->
                    Nothing

        _ ->
            Nothing
