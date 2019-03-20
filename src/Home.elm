module Home exposing (Model, Msg(..), init, subheading, title, toSession, update, view)

import Browser
import Browser.Dom as BD
import Browser.Navigation as Nav
import Html exposing (Html, a, div, h1, h2, h3, img, p, text)
import Html.Attributes exposing (class, classList, href, src, style)
import Html.Events exposing (onClick)
import Tachyons exposing (classes)
import Tachyons.Classes as T
import Utils exposing (Session)



---- MODEL ----


type alias Model =
    { session : Session
    }


init : Session -> ( Model, Cmd Msg )
init session =
    ( Model session, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


view : Model -> List (Html Msg)
view model =
    [ mainContainer
        [ title
        , subheading
        ]
    ]


mainContainer : List (Html Msg) -> Html Msg
mainContainer elements =
    Html.main_
        [ classes
            [ T.fl
            , T.w_100
            , T.tc
            , T.vh_100
            ]
        ]
        elements


title : Html Msg
title =
    div
        [ classes
            [ T.vh_50
            , T.mb1
            , T.flex_ns
            , T.justify_center_ns
            , T.pa4
            ]
        ]
        [ h1
            [ classes
                [ T.code
                , T.f1
                , T.absolute
                , T.static_ns
                , T.mh2_ns
                , "first-name"
                ]
            ]
            [ text "Parker" ]
        , h1
            [ classes
                [ T.code
                , T.f1
                , T.absolute
                , T.static_ns
                , T.mh2_ns
                , "last-name"
                ]
            ]
            [ text "Couch" ]
        ]



-- code f3 ma0 h3 w5 pt3 tc-ns order-0 no-underline mv2 pr3 shadow-5 shadow-hover br1 black order-0 self-start-ns


subHeadingLink : List String
subHeadingLink =
    [ T.code
    , T.f3
    , T.ma0
    , T.h3
    , T.w5
    , T.pt3
    , T.tc_ns
    , T.order_0
    , T.no_underline
    , T.mv2
    , T.pr3
    , T.shadow_5
    , T.shadow_hover
    , T.br1
    ]


subheading : Html Msg
subheading =
    div
        [ classes
            [ T.mw6
            , T.center
            , T.mb4_ns
            , T.mb1
            , T.flex
            , T.flex_column
            , T.justify_center_ns
            , T.content_center
            , T.items_end
            , T.pa2_ns
            , T.ph3
            , T.pt3
            , T.tr
            ]
        ]
        [ a
            [ classes
                (subHeadingLink
                    ++ [ T.black
                       , T.self_start_ns
                       ]
                )
            , href "/art"
            ]
            [ text "Artist" ]
        , a
            [ classes
                (subHeadingLink
                    ++ [ T.black
                       , T.self_center_ns
                       ]
                )
            , href "/blog/1"
            ]
            [ text "Explorer" ]
        , a
            [ classes
                (subHeadingLink
                    ++ [ T.light_purple
                       , T.self_end_ns
                       ]
                )
            , href "/portfolio"
            ]
            [ text "Developer" ]
        ]



---- UTILS ----


toSession : Model -> Session
toSession model =
    model.session
