module Main exposing (..)

import Html.App as App
import Model exposing (Model, Fact(..), View(..))
import Update exposing (update)
import View exposing (view)
import Date exposing (fromTime)
import Debug exposing (log)


-- init


init =
    Model (log "initFacts" initFacts) Chart "" "" Nothing ! []


initFacts : List Fact
initFacts =
    [ Textual { date = (fromTime 883008000000), tag = "elm", text = "flat > nested" }
    ]



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
