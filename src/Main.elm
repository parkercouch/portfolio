module Main exposing (Model, Msg(..), init, main, subscriptions, update, view, viewLink)

import Art
import Blog
import Browser
import Browser.Navigation as Nav
import Home
import Html exposing (Html, a, b, div, h1, h4, img, li, p, text, ul)
import Html.Attributes exposing (href, src)
import Portfolio
import Url
import Url.Parser as Parser
    exposing
        ( (</>)
        , Parser
        , fragment
        , int
        , map
        , oneOf
        , parse
        , s
        , string
        , top
        )
import Utils exposing (Session)


toSession : Model -> Session
toSession model =
    case model of
        HomeMod home ->
            Home.toSession home

        ArtMod art ->
            Art.toSession art

        BlogMod blog ->
            Blog.toSession blog

        PortfolioMod portfolio ->
            Portfolio.toSession portfolio



---- MODEL ----


type Model
    = HomeMod Home.Model
    | ArtMod Art.Model
    | BlogMod Blog.Model
    | PortfolioMod Portfolio.Model


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( HomeMod (Home.Model { key = key, url = url }), Cmd.none )



---- UPDATE ----


type Msg
    = NoOp
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | GotHomeMsg Home.Msg
    | GotArtMsg Art.Msg
    | GotBlogMsg Blog.Msg
    | GotPortfolioMsg Portfolio.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( LinkClicked urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl (toSession model).key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        ( UrlChanged url, _ ) ->
            changeRouteTo (fromUrl url) model

        ( GotHomeMsg subMsg, HomeMod home ) ->
            Home.update subMsg home
                |> updateWith HomeMod GotHomeMsg model

        ( GotArtMsg subMsg, ArtMod art ) ->
            Art.update subMsg art
                |> updateWith ArtMod GotArtMsg model

        ( GotBlogMsg subMsg, BlogMod blog ) ->
            Blog.update subMsg blog
                |> updateWith BlogMod GotBlogMsg model

        ( GotPortfolioMsg subMsg, PortfolioMod portfolio ) ->
            Portfolio.update subMsg portfolio
                |> updateWith PortfolioMod GotPortfolioMsg model

        ( NoOp, _ ) ->
            ( model, Cmd.none )

        ( _, _ ) ->
            ( model, Cmd.none )


updateWith : (subModel -> Model) -> (subMsg -> Msg) -> Model -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
updateWith toModel toMsg model ( subModel, subCmd ) =
    ( toModel subModel
    , Cmd.map toMsg subCmd
    )



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    case model of
        HomeMod home ->
            { title = "Parker Couch"
            , body = List.map (Html.map GotHomeMsg) (Home.view home)
            }

        ArtMod art ->
            { title = "Art - Parker Couch"
            , body = List.map (Html.map GotArtMsg) (Art.view art)
            }

        BlogMod blog ->
            { title = "Blog - Parker Couch"
            , body = List.map (Html.map GotBlogMsg) (Blog.view blog)
            }

        PortfolioMod portfolio ->
            { title = "Portfolio - Parker Couch"
            , body = List.map (Html.map GotPortfolioMsg) (Portfolio.view portfolio)
            }


viewLink : String -> Html msg
viewLink path =
    li [] [ a [ href path ] [ text path ] ]


type Route
    = NotFound
    | Home
    | Art
    | ArtGallery Int
    | Blog
    | BlogPost Int
    | Portfolio
    | ProjectDetails Int


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Home top
        , map Art (s "art" </> top)
        , map ArtGallery (s "art" </> int)
        , map Blog (s "blog" </> top)
        , map BlogPost (s "blog" </> int)
        , map Portfolio (s "portfolio" </> top)
        , map ProjectDetails (s "portfolio" </> int)
        ]


fromUrl : Url.Url -> Route
fromUrl url =
    Maybe.withDefault NotFound (Parser.parse parser url)


changeRouteTo : Route -> Model -> ( Model, Cmd Msg )
changeRouteTo route model =
    let
        session =
            toSession model
    in
    case route of
        -- TODO: make a better redirect
        NotFound ->
            Home.init session
                |> updateWith HomeMod GotHomeMsg model

        Home ->
            Home.init session
                |> updateWith HomeMod GotHomeMsg model

        Art ->
            Art.init session
                |> updateWith ArtMod GotArtMsg model

        ArtGallery galleryId ->
            Art.init session
                |> updateWith ArtMod GotArtMsg model

        Blog ->
            Blog.init session
                |> updateWith BlogMod GotBlogMsg model

        BlogPost blogId ->
            Blog.init session
                |> updateWith BlogMod GotBlogMsg model

        Portfolio ->
            Portfolio.init session
                |> updateWith PortfolioMod GotPortfolioMsg model

        ProjectDetails projectId ->
            Portfolio.init session
                |> updateWith PortfolioMod GotPortfolioMsg model



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        , subscriptions = subscriptions
        , update = update
        , view = view
        }
