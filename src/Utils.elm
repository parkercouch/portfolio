module Utils exposing (Session)

import Browser.Navigation as Nav
import Url


type alias Session =
    { key : Nav.Key
    , url : Url.Url
    }
