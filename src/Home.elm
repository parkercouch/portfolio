module Home exposing (Model, Msg(..), containerDiv, init, subheading, title, toSession, update, view)

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
    [ containerDiv
        [ div
            [ classes
                [ T.fl
                , T.w_100
                , T.pa1
                , T.pa2_ns
                , T.tc
                ]
            ]
            [ title
            , subheading
            ]
        ]
    ]


containerDiv : List (Html Msg) -> Html Msg
containerDiv elements =
    div
        [ classes
            [ T.mw_100
            , T.vh_100
            , T.mw7_ns
            , T.center
            , T.pa1
            , T.ph4_ns
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


subHeadingLink : List String
subHeadingLink =
    [ T.code
    , T.f3
    , T.ma0
    , T.h3
    , T.w5
    , T.pt3
    , T.h_auto_ns
    , T.tl_ns
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
            [ T.mt6_ns
            , T.mb4_ns
            , T.mb1
            , T.flex
            , T.flex_column
            , T.justify_center_ns
            , T.content_center
            , T.items_end
            , T.pa2_ns
            , T.pt6_ns
            , T.ph3
            , T.pt3
            , T.tr
            ]
        ]
        [ a
            [ classes
                (subHeadingLink
                    ++ [ T.black
                       , T.order_0
                       ]
                )
            , href "/art"
            ]
            [ text "Artist" ]
        , a
            [ classes
                (subHeadingLink
                    ++ [ T.black
                       , T.order_1
                       , T.order_2_ns
                       ]
                )
            , href "/blog/1"
            ]
            [ text "Explorer" ]
        , a
            [ classes
                (subHeadingLink
                    ++ [ T.light_purple
                       , T.order_2
                       , T.order_1_ns
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
