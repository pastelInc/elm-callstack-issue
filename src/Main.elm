module Main exposing (main)

import Html exposing (Html, div, h1, li, text, ul)
import Html.Events exposing (onClick)
import Navigation exposing (Location)
import Route exposing (Route)
import Translations.Record as Translations


type Msg
    = Navigation Route
    | UrlChange (Maybe Route)


type Model
    = Home
    | RecordTranslations
    | DictTranslations
    | Blank


init : Location -> ( Model, Cmd Msg )
init location =
    setRoute (Route.fromLocation location)
        Blank


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute route model =
    case route of
        Just Route.Home ->
            Home ! []

        Just Route.RecordTranslations ->
            RecordTranslations ! []

        Just Route.DictTranslations ->
            DictTranslations ! []

        Nothing ->
            Blank ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange route ->
            setRoute route model

        Navigation route ->
            model ! [ Route.newUrl route ]


view : Model -> Html Msg
view model =
    case model of
        Blank ->
            text ""

        Home ->
            div []
                [ h1 [] [ text "Table of contents" ]
                , ul []
                    [ li [ onClick (Navigation Route.RecordTranslations) ] [ text "using record" ]
                    , li [ onClick (Navigation Route.DictTranslations) ] [ text "using dict" ]
                    ]
                ]

        RecordTranslations ->
            div [] [ h1 [] [ text "Record" ] ]

        DictTranslations ->
            div [] [ h1 [] [ text "Dict" ] ]


main : Program Never Model Msg
main =
    Navigation.program (Route.fromLocation >> UrlChange)
        { init = init
        , update = update
        , subscriptions = always Sub.none
        , view = view
        }
