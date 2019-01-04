module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, a, div, h1, h2, h3, img, text, p)
import Html.Attributes exposing (class, classList, href, src)
import Tachyons exposing (classes)
import Tachyons.Classes as T



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
    containerDiv
        [ div
            [ classes
                [ T.fl
                , T.w_100
                , T.pa2
                , T.tc
                ]
            ]
            [ title
            , floatingNav
            , preview
            , projectTitle "Project 1"
            , projectDescription "This is a description of Project 1! This does a thing."
            ]
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



--- View Elements ---


floatingNav : Html Msg
floatingNav =
    div
        [ classes
            [ T.mw9
            , T.center
            , T.ph3_ns
            , T.purple
            ]
        ]
        [ div
            [ classes [ T.cf, T.ph2_ns ] ]
            [ div
                [ classes (navButtonContainer ++ [T.w_100_m]) ]
                [ a
                    [ classes (navButton ++ grow50m)
                    , href "#"
                    ]
                    [ text "Resume" ]
                ]
            , div
                [ classes (navButtonContainer ++ grow50m) ]
                [ a
                    [ classes navButton
                    , href "#"
                    ]
                    [ text "Linkedin" ]
                ]
            , div
                [ classes (navButtonContainer ++ grow50m) ]
                [ a
                    [ classes navButton
                    , href "#"
                    ]
                    [ text "Github" ]
                ]
            ]
        ]


containerDiv : List (Html Msg) -> Html Msg
containerDiv elements =
    div
        [ classes
            [ T.mw5
            , T.mw7_ns
            , T.center
            , T.pa3
            , T.ph5_ns
            ]
        ]
        elements


title : Html Msg
title =
    div [ classes [ T.mb7_l, T.mb6_m, T.mb5_ns, T.pa4 ] ]
        [ h1 [ classes [ T.code, T.f1 ] ] [ text "Parker" ]
        , h1 [ classes [ T.code, T.f1 ] ] [ text "Couch" ]
        ]

preview : Html Msg
preview =
    div [ classes 
            [ T.w_100
            , T.pa1
            ]
        ] [ img [ classes [ T.mw_100 ], src "assets/evening.png" ] [] ]

projectTitle : String -> Html Msg
projectTitle titleText=
    h3 [ classes
            [ T.w_100 
            , T.f3
            , T.purple
            ]
    ] [ text titleText]

projectDescription : String -> Html Msg
projectDescription descriptionText =
    p [ classes
            [ T.w_100 
            , T.f6
            , T.blue
            ]
    ] [ text descriptionText]

--- CSS Components ---


navButtonContainer : List String
navButtonContainer =
    [ T.fl
    , T.w_third_l
    , T.w_50_m
    , T.w_100
    , T.pa3
    ]


navButton : List String
navButton =
    [ T.f4
    , T.link
    , T.dim
    , T.br2
    , T.w_100
    , T.pv4
    , T.mb2
    , T.dib
    , T.white
    , T.bg_light_purple
    ]


grow100m : List String
grow100m =
    [ T.w_100_m ]


grow50m : List String
grow50m =
    [ T.w_50_m ]
