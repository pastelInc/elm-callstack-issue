module Route exposing (Route(..), fromLocation, newUrl)

import Navigation exposing (Location)
import UrlParser as Url exposing ((</>), Parser, oneOf, parseHash, s, string)


-- ROUTING --


type Route
    = Home
    | RecordTranslations
    | DictTranslations


route : Parser (Route -> a) a
route =
    oneOf
        [ Url.map Home (s "")
        , Url.map RecordTranslations (s "record")
        , Url.map DictTranslations (s "dict")
        ]



-- INTERNAL --


routeToString : Route -> String
routeToString page =
    let
        pieces =
            case page of
                Home ->
                    []

                RecordTranslations ->
                    [ "record" ]

                DictTranslations ->
                    [ "dict" ]
    in
    "/" ++ String.join "/" pieces



-- PUBLIC HELPERS --


newUrl : Route -> Cmd msg
newUrl =
    routeToString >> Navigation.newUrl


fromLocation : Location -> Maybe Route
fromLocation location =
    Url.parsePath route location
