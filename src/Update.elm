module Update exposing (..)


type Msg
    = ToggleNew
    | InputLabel
    | InputValue
    | SaveFact


update msg model =
    case msg of
        ToggleNew ->
            { model | showingNewFact = not model.showingNewFact } ! []

        _ ->
            model ! []
