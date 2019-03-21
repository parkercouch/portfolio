module Art exposing (Model, Msg(..), init, toSession, update, view)

import Browser
import Browser.Dom as BD
import Browser.Navigation as Nav
import Html exposing (Html, a, button, div, h1, h2, h3, header, img, nav, p, section, text)
import Html.Attributes exposing (alt, class, classList, href, src, style)
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



---- TYPES ----


type alias Gallery =
    { title : String
    , artwork : List Artwork
    }


type alias Artwork =
    { title : String
    , url : String
    , altText : String
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
        , img [ src art.url, alt art.altText, classes [ T.shadow_5, T.br1, "art-img" ] ] []
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
        [ Artwork "Reaching" "/assets/art_portfolio/hand_1.jpg" "Hand reaching for the moon"
        , Artwork "Holding" "/assets/art_portfolio/hand_2.jpg" "Hand holding the moon"
        , Artwork "Uncovering" "/assets/art_portfolio/hand_3.jpg" "Hand cutting through mountains"
        ]
    }


sketchGallery : Gallery
sketchGallery =
    { title = "Sketches"
    , artwork =
        [ Artwork "Coffee Shop 1" "/assets/art_portfolio/sketch_1.jpg" "Sketch of people in coffee shop"
        , Artwork "Coffee Shop 2" "/assets/art_portfolio/sketch_2.jpg" "Sketch of person sitting in chair"
        , Artwork "I like your hat" "/assets/art_portfolio/sketch_3.jpg" "Sketch of two people with the same hat"
        , Artwork "Studying" "/assets/art_portfolio/sketch_4.jpg" "Sketch of someone looking at their phone"
        , Artwork "Look Up" "/assets/art_portfolio/sketch_5.jpg" "Sketch of an overhead light"
        , Artwork "Tiny Tree" "/assets/art_portfolio/sketch_6.jpg" "Sketch of a small tree in a pot"
        ]
    }


blackAndWhiteGallery : Gallery
blackAndWhiteGallery =
    { title = "Black and White"
    , artwork =
        [ Artwork "I" "/assets/art_portfolio/b_and_w_1.jpg" "Black and white drawing of trees"
        , Artwork "II" "/assets/art_portfolio/b_and_w_2.jpg" "Ink painting of a tree"
        , Artwork "III" "/assets/art_portfolio/b_and_w_3.jpg" "Ink painting of a bush"
        , Artwork "IV" "/assets/art_portfolio/b_and_w_4.jpg" "Ink painting of a tree trunk"
        , Artwork "V" "/assets/art_portfolio/b_and_w_5.jpg" "Ink painting of a cliff"
        , Artwork "VI" "/assets/art_portfolio/b_and_w_6.jpg" "Abstract ink painting with lines and dots"
        ]
    }


moonAndShroomGallery : Gallery
moonAndShroomGallery =
    { title = "Moon and Shrooms"
    , artwork =
        [ Artwork "Moon" "/assets/art_portfolio/moon_and_shrooms_1.jpg" "Pastel painting of the moon"
        , Artwork "Shrooms" "/assets/art_portfolio/moon_and_shrooms_2.jpg" "Pastel painting of mushrooms"
        ]
    }


energyGallery : Gallery
energyGallery =
    { title = "Energy"
    , artwork =
        [ Artwork "Travel" "/assets/art_portfolio/energy_1.jpg" "Abstract drawing with lots of swirls and colorful lines"
        , Artwork "Trance" "/assets/art_portfolio/energy_2.jpg" "Abstract drawing with two large circles and colors cutting through them"
        ]
    }


pastelGallery : Gallery
pastelGallery =
    { title = "Pastels"
    , artwork =
        [ Artwork "Meditation I" "/assets/art_portfolio/minimal_1.jpg" "Pastel painting of three spheres"
        , Artwork "The Stars are Dancing" "/assets/art_portfolio/pastel_sky.jpg" "Pastel painting of mountain and starry sky"
        , Artwork "Mantis Shrimp" "/assets/art_portfolio/mantis_shrimp.jpg" "Pastel painting of a mantis shrimp"
        ]
    }



---- UTILS ----


toSession : Model -> Session
toSession model =
    model.session
