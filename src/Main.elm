module Main exposing (..)

import Html.App as App
import Model exposing (Model, Fact)
import Update exposing (update)
import View exposing (view)


-- init


init =
    Model [] False "" "" Nothing ! []



-- update
-- subscriptions


subscriptions model =
    Sub.none


main =
    App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
