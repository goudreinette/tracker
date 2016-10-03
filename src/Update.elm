module Update exposing (..)

import Model exposing (..)


type Msg
    = SwitchView View
    | InputLabel
    | InputValue
    | SaveFact


update msg model =
    case msg of
        SwitchView view ->
            { model | view = view } ! []

        _ ->
            model ! []
