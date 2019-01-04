module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, div, h1, h2, h3, img, text)
import Html.Attributes exposing (class, classList, src)



---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div
        [ classList
            [ ( "fl", True )
            , ( "w-100", True )
            , ( "pa2", True )
            , ( "tc", True )
            ]
        ]
        [ img [ src "/logo.svg", class "small-img" ] []
        , h1 [ class "red-text" ] [ text "Portfolio" ]
        , h3 [ class "purple" ]
            [ text "Under construction (with Elm!)" ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
