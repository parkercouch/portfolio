module Nav exposing (NavLink, navLink, viewHeader)

import Html exposing (Html, a, button, div, h1, h2, h3, header, img, nav, p, text)
import Html.Attributes exposing (class, classList, href, src, style)
import Html.Events exposing (onClick)
import Tachyons exposing (classes)
import Tachyons.Classes as T


navLink : String -> String -> Bool -> Html msg
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
            , ( T.dark_gray, not selected )
            , ( T.self_end, selected )
            ]
        , href url
        ]
        [ text title ]


type alias NavLink =
    { label : String
    , url : String
    , selected : Bool
    }


viewHeader : List NavLink -> Html msg
viewHeader links =
    let
        parsedLinks =
            List.map (\l -> navLink l.label l.url l.selected) links
    in
    header
        [ classes
            [ T.flex
            , T.justify_between
            , T.mw7
            , T.center
            , T.pa2
            , T.h3
            , T.h4_ns
            , T.pa4_ns
            ]
        ]
        [ a [ href "/", classes [ T.dib, T.f3, T.ma0, T.pa0, T.no_underline, T.pointer, T.dark_gray ] ] [ text "Parker Couch" ]
        , nav [ classes [ T.dib, T.flex, T.flex_row, T.ml2 ] ] parsedLinks
        ]
