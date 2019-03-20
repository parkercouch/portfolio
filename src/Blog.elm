module Blog exposing (Model, Msg(..), init, toSession, update, view)

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
    , blogId : Int
    }


toSession : Model -> Session
toSession model =
    model.session


init : Session -> Int -> ( Model, Cmd Msg )
init session id =
    ( Model session id, Cmd.none )



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



---- VIEW ----


view : Model -> List (Html Msg)
view model =
    [ viewHeader links
    , mainContainer
        [ h1 [] [ text "Adventure Log" ]
        , p [] [ text "Under Construction" ]
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
    , NavLink "Explorer" "" True
    , NavLink "Developer" "/portfolio" False
    ]
