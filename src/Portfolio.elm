module Portfolio exposing (Model, Msg(..), containerDiv, init, toSession, update, view)

import Browser
import Browser.Dom as BD
import Browser.Navigation as Nav
import Html exposing (Html, a, button, div, h1, h2, h3, header, img, nav, p, text)
import Html.Attributes exposing (class, classList, href, src, style)
import Html.Events exposing (onClick)
import Nav exposing (NavLink, viewHeader)
import Tachyons exposing (classes)
import Tachyons.Classes as T
import Utils exposing (Session)



---- MODEL ----


type alias Model =
    { session : Session
    , zoom : Bool
    , current : Int
    }


toSession : Model -> Session
toSession model =
    model.session


init : Session -> ( Model, Cmd Msg )
init session =
    ( Model session False 0, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp
    | Focus Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Focus id ->
            ( { model | current = id, zoom = True }, Cmd.none )

        _ ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> List (Html Msg)
view model =
    [ viewHeader links
    , mainContainer
        [ h1 [] [ text "Portfolio" ]
        , p [] [ text "Under Construction" ]
        , projects projectsList
        ]
    ]


mainContainer : List (Html Msg) -> Html Msg
mainContainer elements =
    Html.main_
        [ classes
            [ T.fl
            , T.w_100
            , T.tc
            ]
        ]
        elements


links : List NavLink
links =
    [ NavLink "Artist" "/art" False
    , NavLink "Explorer" "/blog" False
    , NavLink "Developer" "" True
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


projects : List Project -> Html Msg
projects projectList =
    div []
        (List.map projectCard projectList)


projectCard : Project -> Html Msg
projectCard project =
    div [ classes [ T.mb5 ] ]
        [ projectTitle project.name
        , preview project.img
        , projectDescription project.description
        , badgeRow project.badges project.repoUrl
        ]


preview : String -> Html Msg
preview imgUrl =
    div
        [ classes
            [ T.w_75
            , T.pa1
            , T.ml_auto
            ]
        ]
        [ img [ classes [ T.mw_100, T.br2, T.shadow_5 ], src imgUrl ] [] ]


projectTitle : String -> Html Msg
projectTitle titleText =
    h2
        [ classes
            [ T.code
            , T.w_100
            , T.f2
            , T.black
            , T.tl
            ]
        ]
        [ text titleText ]


projectDescription : String -> Html Msg
projectDescription descriptionText =
    p
        [ classes
            [ T.w_100
            , T.f4
            , T.black
            , T.tl
            ]
        ]
        [ text descriptionText ]


badgeRow : List String -> String -> Html Msg
badgeRow icons repoUrl =
    let
        elements =
            List.map (\l -> badge l) icons ++ [ badgeLink repoUrl ]
    in
    div [ classes [ T.pa0, T.w_100, T.h_auto, T.flex ] ] elements


badge : String -> Html Msg
badge location =
    div
        [ classes
            [ T.w_20
            , T.h_100
            , T.pa1
            , T.dib
            , T.br2
            , T.bw2
            , T.mh1
            , T.shadow_hover
            , T.shadow_5
            ]
        ]
        [ img [ classes [ T.h2 ], src location ] [] ]


badgeLink : String -> Html Msg
badgeLink url =
    a
        [ classes
            [ T.w_40
            , T.h_auto
            , T.pa0
            , T.dib
            , T.br2

            -- , T.ba
            -- , T.bw2
            , T.mh1
            , T.bg_light_purple
            , T.black
            , T.no_underline
            , T.grow
            , T.code
            , T.shadow_5
            , T.flex
            , T.items_center
            ]
        , href url
        ]
        [ h1 [ classes [ T.w_100, T.f2_l, T.f3 ] ] [ text "source" ] ]



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


loremText =
    "Labore nisi mollit esse qui deserunt reprehenderit reprehenderit ad. Ad ea proident labore ullamco cillum. Amet exercitation sunt elit incididunt amet do cupidatat anim. Ipsum tempor ad mollit laboris ullamco minim Lorem deserunt deserunt tempor ipsum ea sunt"


type alias Project =
    { name : String
    , description : String
    , liveUrl : String
    , repoUrl : String
    , img : String
    , badges : List String
    }


projectsList : List Project
projectsList =
    [ projectOne
    , projectTwo
    , projectThree
    , projectFour
    ]


projectOne : Project
projectOne =
    { name = "Just Smash Bricks"
    , description = "Breakout style game created with Kontra.js"
    , liveUrl = "https://parkercouch.github.io/brick-smashing-game/"
    , repoUrl = "https://github.com/parkercouch/brick-smashing-game"
    , img = "assets/square.png"
    , badges = [ deviceIcon, pokeIcon, infoIcon ]
    }


projectTwo : Project
projectTwo =
    { name = "hikr"
    , description = "Social media to find hiking partners"
    , liveUrl = "https://hikr-app.herokuapp.com/"
    , repoUrl = "https://github.com/parkercouch/hikr"
    , img = "assets/square.png"
    , badges = [ deviceIcon, pokeIcon, infoIcon ]
    }


projectThree : Project
projectThree =
    { name = "Syllaboard"
    , description = "Dashboard for instructors and students to keep track of assignments."
    , liveUrl = "http://syllaboard.herokuapp.com/"
    , repoUrl = "https://github.com/parkercouch/syllaboard-client"
    , img = "assets/square.png"
    , badges = [ deviceIcon, pokeIcon, infoIcon ]
    }


projectFour : Project
projectFour =
    { name = "Siam Online"
    , description = "Multiplayer game made with Elm, Elixir, and Phoenix"
    , liveUrl = ""
    , repoUrl = ""
    , img = "assets/square.png"
    , badges = [ deviceIcon, pokeIcon, infoIcon ]
    }
