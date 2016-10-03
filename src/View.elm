module View exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


-- view


view model =
    div [ class "container" ]
        [ header []
            [ button
                [ id "new-entry"
                , class <|
                    if model.showingNewFact then
                        "active"
                    else
                        ""
                ]
                [ text "+" ]
            ]
        , div [ class "grid" ] []
        , text <| toString model
        ]
