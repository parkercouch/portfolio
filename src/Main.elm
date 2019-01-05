module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, a, div, h1, h2, h3, img, text, p)
import Html.Attributes exposing (class, classList, href, src, style)
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
                , T.pa1
                , T.pa2_ns
                , T.tc
                ]
            ]
            [ title
            , floatingNav
            , preview
            , projectTitle "Project 1"
            , projectDescription loremText
            , projectDescription loremText
            , badgeRow [ deviceIcon, detailIcon, editIcon, projectOneUrl ]
            , p [] [text loremText]
            , p [] [text loremText]
            , p [] [text loremText]
            , p [] [text loremText]
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
            [ T.mw_100
            , T.mw7_ns
            , T.center
            , T.pa1
            , T.ph4_ns
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
        ] [ img [ classes [ T.mw_100, T.br2, T.grow, T.shadow_1 ], src "assets/evening.png" ] [] ]

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

badgeRow : List String -> Html Msg
badgeRow locations =
    let
        repoUrl = Maybe.withDefault "#" (List.head (List.reverse locations))
        icons = Maybe.withDefault [] (List.tail (List.reverse locations))
        elements = List.map (\l -> badge l) icons ++ [ badgeLink repoUrl ] 
    in
        div [ classes [ T.pa0, T.w_100, T.h_auto, T.flex ] ] elements

badge : String -> Html Msg
badge location =
    div [ classes
            [ T.w_20
            , T.h_100
            , T.pa1
            , T.dib
            , T.br2
            , T.ba
            , T.bw2
            , T.mh1
            , T.grow
            , T.shadow_2
            ]
        ] [ img [ classes [T.w_90], src location] [] ]

badgeLink : String -> Html Msg
badgeLink url =
    a [ classes
            [ T.w_40
            , T.h_auto
            , T.pa0
            , T.dib
            , T.br2
            , T.ba
            , T.bw2
            , T.mh1
            , T.bg_light_purple
            , T.black
            , T.no_underline
            , T.grow_large
            , T.code
            , T.shadow_5
            ]
        , href url
        ] [ h1 [ classes [T.w_100]] [ text "source" ] ]

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


deviceImg =
    "badge-device"

deviceIcon =
    "assets/device.png"

pokeIcon =
    "assets/pokeball.png"

editIcon =
    "assets/edit.png"

detailIcon =
    "assets/details.png"

clearIcon =
    "assets/clear.png"

infoIcon =
    "assets/info.png"

projectOneUrl =
    "https://parkercouch.github.io/brick-smashing-game/"

loremText =
    "Labore nisi mollit esse qui deserunt reprehenderit reprehenderit ad. Ad ea proident labore ullamco cillum. Amet exercitation sunt elit incididunt amet do cupidatat anim. Ipsum tempor ad mollit laboris ullamco minim Lorem deserunt deserunt tempor ipsum ea sunt"