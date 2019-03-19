module Art exposing (Model, Msg(..), init, toSession, update, view)

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


init : Session -> ( Model, Cmd Msg )
init session =
    ( Model session False 0, Cmd.none )



---- TYPES ----


type alias Gallery =
    { title : String
    , artwork : List Artwork
    }


type alias Artwork =
    { title : String
    , url : String
    }



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
        [ artGallery handGallery
        , artGallery sketchGallery
        , artGallery blackAndWhiteGallery
        , artGallery moonAndShroomGallery
        , artGallery energyGallery
        , artGallery pastelGallery
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


artGallery : Gallery -> Html Msg
artGallery gallery =
    let
        artwork =
            List.map artPiece gallery.artwork

        banner =
            [ bannerTitle gallery.title ]
    in
    section [ classes [ T.pb4, T.mt4, T.ph2_ns ] ]
        (banner ++ artwork)


artPiece : Artwork -> Html Msg
artPiece art =
    div [ classes [ T.mw7, T.center ] ]
        [ h3 [ classes [ T.f3, T.tl, T.pa2, T.mb0 ] ] [ text art.title ]
        , img [ src art.url, classes [ T.shadow_5, T.br1, "art-img" ] ] []
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
        [ h2 [ classes [ T.f2 ] ] [ text title ]
        ]


links : List NavLink
links =
    [ NavLink "Artist" "" True
    , NavLink "Explorer" "/blog" False
    , NavLink "Developer" "/portfolio" False
    ]


handGallery : Gallery
handGallery =
    { title = "Hands"
    , artwork =
        [ Artwork "Reaching" "assets/art_portfolio/hand_1.jpg"
        , Artwork "Holding" "assets/art_portfolio/hand_2.jpg"
        , Artwork "Uncovering" "assets/art_portfolio/hand_3.jpg"
        ]
    }


sketchGallery : Gallery
sketchGallery =
    { title = "Sketches"
    , artwork =
        [ Artwork "Coffee Shop 1" "assets/art_portfolio/sketch_1.jpg"
        , Artwork "Coffee Shop 2" "assets/art_portfolio/sketch_2.jpg"
        , Artwork "I like your hat" "assets/art_portfolio/sketch_3.jpg"
        , Artwork "Studying" "assets/art_portfolio/sketch_4.jpg"
        , Artwork "Look Up" "assets/art_portfolio/sketch_5.jpg"
        , Artwork "Tiny Tree" "assets/art_portfolio/sketch_6.jpg"
        ]
    }


blackAndWhiteGallery : Gallery
blackAndWhiteGallery =
    { title = "Black and White"
    , artwork =
        [ Artwork "I" "assets/art_portfolio/b_and_w_1.jpg"
        , Artwork "II" "assets/art_portfolio/b_and_w_2.jpg"
        , Artwork "III" "assets/art_portfolio/b_and_w_3.jpg"
        , Artwork "IV" "assets/art_portfolio/b_and_w_4.jpg"
        , Artwork "V" "assets/art_portfolio/b_and_w_5.jpg"
        , Artwork "VI" "assets/art_portfolio/b_and_w_6.jpg"
        ]
    }


moonAndShroomGallery : Gallery
moonAndShroomGallery =
    { title = "Moon and Shrooms"
    , artwork =
        [ Artwork "Moon" "assets/art_portfolio/moon_and_shrooms_1.jpg"
        , Artwork "Shrooms" "assets/art_portfolio/moon_and_shrooms_2.jpg"
        ]
    }


energyGallery : Gallery
energyGallery =
    { title = "Energy"
    , artwork =
        [ Artwork "Travel" "assets/art_portfolio/energy_1.jpg"
        , Artwork "Trance" "assets/art_portfolio/energy_2.jpg"
        ]
    }


pastelGallery : Gallery
pastelGallery =
    { title = "Pastels"
    , artwork =
        [ Artwork "Meditation I" "assets/art_portfolio/minimal_1.jpg"
        , Artwork "The Stars are Dancing" "assets/art_portfolio/pastel_sky.jpg"
        , Artwork "Mantis Shrimp" "assets/art_portfolio/mantis_shrimp.jpg"
        ]
    }



---- UTILS ----


toSession : Model -> Session
toSession model =
    model.session
