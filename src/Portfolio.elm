module Portfolio exposing (Model, Msg(..), init, toSession, update, view)

import Browser
import Browser.Dom as BD
import Browser.Navigation as Nav
import Html exposing (Html, a, button, div, h1, h2, h3, header, img, nav, p, section, text)
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


init : Session -> Int -> ( Model, Cmd Msg )
init session id =
    let
        zoom =
            if id /= 0 then
                True

            else
                False
    in
    ( Model session zoom id, Cmd.none )



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
        [ subheading
        , h1 [ classes [ T.mw7, T.center, T.tl, T.ph2, T.f1 ] ] [ text "Projects" ]
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


subHeadingLinkStyles : List String
subHeadingLinkStyles =
    [ T.f5
    , T.ma0
    , T.h2
    , T.w4
    , T.pt2
    , T.no_underline
    , T.mv2
    , T.pr3
    , T.shadow_5
    , T.shadow_hover
    , T.br1
    , T.dark_gray
    ]


subHeadingDownloadLink : String -> String -> Html Msg
subHeadingDownloadLink url label =
    a
        [ classes subHeadingLinkStyles
        , href url
        , Html.Attributes.download ""
        ]
        [ text label ]


subHeadingLink : String -> String -> Html Msg
subHeadingLink url label =
    a
        [ classes subHeadingLinkStyles
        , href url
        , Html.Attributes.target "_blank"
        ]
        [ text label ]


subheading : Html Msg
subheading =
    div
        [ classes
            [ T.mw7
            , T.center
            , T.mb4_ns
            , T.mb1
            , T.flex
            , T.flex_column
            , T.content_center
            , T.items_end
            , T.ph3
            , T.ph4_ns
            , T.pt1
            , T.tr
            ]
        ]
        [ subHeadingLink "https://github.com/parkercouch" "Github"
        , subHeadingLink "https://www.linkedin.com/in/parkercouch/" "LinkedIn"
        , subHeadingDownloadLink "/assets/Parker_Couch_Resume.pdf" "Resume"
        ]


links : List NavLink
links =
    [ NavLink "Artist" "/art" False
    , NavLink "Explorer" "/blog" False
    , NavLink "Developer" "" True
    ]


projects : List Project -> Html Msg
projects projectList =
    div []
        (List.map projectCard projectList)


projectCard : Project -> Html Msg
projectCard project =
    section [ classes [ T.pb4, T.mt4, T.ph2_ns ] ]
        [ bannerTitle project.name
        , projectDetails project
        ]


bannerTitle : String -> Html Msg
bannerTitle title =
    div
        [ classes
            [ T.flex
            , T.items_center
            , T.justify_end
            , T.mw7
            , T.center
            , T.h3
            , T.h4_ns
            , T.ph2
            ]
        ]
        [ h2 [ classes [ T.f3, T.f2_ns ] ] [ text title ]
        ]


projectDetails : Project -> Html Msg
projectDetails project =
    div [ classes [ T.mw7, T.center ] ]
        [ img [ src project.img, classes [ T.shadow_5, T.br1, "art-img" ] ] []
        , p [] [ text project.description ]
        , badgeRow project.badges project.repoUrl
        ]


badgeRow : List String -> String -> Html Msg
badgeRow icons repoUrl =
    let
        elements =
            List.map (\l -> badge l) icons ++ [ badgeLink repoUrl ]
    in
    div [ classes [ T.pa0, T.mw6, T.center, T.h_auto, T.flex ] ] elements


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
            , T.bg_washed_blue
            , "default-cursor"
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
        , Html.Attributes.target "_blank"
        ]
        [ h1 [ classes [ T.w_100, T.f3_l, T.f3 ] ] [ text "source" ] ]


nodeIcon =
    "/assets/icons/nodejs-icon.png"


htmlIcon =
    "/assets/icons/html-5-icon.png"


jsIcon =
    "/assets/icons/javascript-icon.png"


postgresIcon =
    "/assets/icons/postgres-icon.png"


reactIcon =
    "/assets/icons/react-icon.png"


reduxIcon =
    "/assets/icons/redux-icon.png"


socketIoIcon =
    "/assets/icons/socketio-icon.gif"


mongoDbIcon =
    "/assets/icons/mongodb-icon.png"


cssIcon =
    "/assets/icons/css-icon.png"


elmIcon =
    "/assets/icons/elm-icon.png"


heartIcon =
    "/assets/icons/heart-icon.png"


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
    [ justSmashBricks
    , hikr
    , syllaboard
    , portfolio
    ]


justSmashBricks : Project
justSmashBricks =
    { name = "Just Smash Bricks"
    , description = "Breakout style game created with Kontra.js"
    , liveUrl = "https://parkercouch.github.io/brick-smashing-game/"
    , repoUrl = "https://github.com/parkercouch/brick-smashing-game"
    , img = "/assets/projects/just_smash_bricks_video.gif"
    , badges = [ htmlIcon, cssIcon, jsIcon ]
    }


hikr : Project
hikr =
    { name = "hikr"
    , description = "Social media to find hiking partners"
    , liveUrl = "https://hikr-app.herokuapp.com/"
    , repoUrl = "https://github.com/parkercouch/hikr"
    , img = "/assets/projects/hikr_video.gif"
    , badges = [ nodeIcon, postgresIcon, socketIoIcon ]
    }


syllaboard : Project
syllaboard =
    { name = "Syllaboard"
    , description = "Dashboard for instructors and students to keep track of assignments."
    , liveUrl = "http://syllaboard.herokuapp.com/"
    , repoUrl = "https://github.com/parkercouch/syllaboard-client"
    , img = "/assets/projects/syllaboard_video.gif"
    , badges = [ reactIcon, reduxIcon, mongoDbIcon ]
    }


siamOnline : Project
siamOnline =
    { name = "Siam Online"
    , description = "Multiplayer game made with Elm, Elixir, and Phoenix"
    , liveUrl = ""
    , repoUrl = ""
    , img = "/assets/square.png"
    , badges = [ htmlIcon, htmlIcon, htmlIcon ]
    }


portfolio : Project
portfolio =
    { name = "Portfolio"
    , description = "Personal portfolio website made in Elm"
    , liveUrl = "https://parkercouch.github.io/"
    , repoUrl = "https://github.com/parkercouch/portfolio"
    , img = "/assets/projects/portfolio_video.gif"
    , badges = [ heartIcon, elmIcon, heartIcon ]
    }
