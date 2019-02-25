module Blog exposing (Model, Msg(..), containerDiv, init, toSession, update, view)

import Browser
import Browser.Dom as BD
import Browser.Navigation as Nav
import Html exposing (Html, a, button, div, h1, h2, h3, header, img, nav, p, text)
import Html.Attributes exposing (class, classList, href, src, style)
import Html.Events exposing (onClick)
import Tachyons exposing (classes)
import Tachyons.Classes as T
import Utils exposing (Session)



---- MODEL ----


type alias Model =
    { session : Session
    , blogId : Int
    }


toSession : Model -> Session
toSession model =
    model.session


init : Session -> ( Model, Cmd Msg )
init session =
    ( Model session 0, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp
    | Show Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Show blogId ->
            ( { model | blogId = blogId }, Cmd.none )

        _ ->
            ( model, Cmd.none )



-- view : Model -> Browser.Document Msg


view : Model -> List (Html Msg)
view model =
    [ containerDiv
        [ viewHeader
        , div
            [ classes
                [ T.fl
                , T.w_100
                , T.pa1
                , T.pa2_ns
                , T.tc
                ]
            ]
            [ h1 [] [ text "Blog" ]
            , p [] [ text "Under Construction" ]
            ]
        ]
    ]


containerDiv : List (Html Msg) -> Html Msg
containerDiv elements =
    div
        [ classes
            [ T.mw_100
            , T.mw7_ns
            , T.center
            , T.pa0
            , T.ph4_ns
            , T.code
            ]
        ]
        elements


navLink : String -> String -> Bool -> Html Msg
navLink title url selected =
    a
        [ classes
            [ T.dib
            , T.h2
            , T.no_underline
            , T.dim
            , T.pa1
            , T.br2
            , T.lh_title
            ]
        , classList
            [ ( T.purple, selected )
            , ( T.black, not selected )
            , ( T.self_end, selected )
            ]
        , href url
        ]
        [ text title ]


viewHeader : Html Msg
viewHeader =
    header [ classes [ T.flex, T.justify_between, T.pv2, T.ph1, T.h3, T.shadow_5 ] ]
        [ h1 [ classes [ T.dib, T.f3, T.ma0, T.pa0 ] ] [ text "ParkerCouch" ]
        , nav [ classes [ T.dib, T.flex, T.flex_row, T.ml2 ] ]
            [ navLink "Artist" "/art" False
            , navLink "Explorer" "" True
            , navLink "Developer" "/portfolio" False
            ]
        ]
