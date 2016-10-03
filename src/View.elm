module View exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Update exposing (..)


-- view


view model =
    div [ class "container" ]
        [ header []
            [ div [ class "right" ]
                [ button [ id "chart" ]
                    [ text "chart" ]
                , button [ id "timeline" ]
                    [ text "timeline" ]
                ]
            , button
                [ onClick ToggleNew
                , id "new-entry"
                , class <|
                    if model.showingNewFact then
                        "active"
                    else
                        ""
                ]
                [ text "+" ]
            ]
        , newFactView model.showingNewFact Nothing "" ""
        ]


newFactView showing date label value =
    let
        class' =
            if showing then
                "show"
            else
                ""
    in
        Html.form [ id "new-fact", class class' ]
            [ div [ class "inner" ]
                [ h1 [] [ text "New Fact" ]
                , input [ placeholder "Tag" ] []
                , input [ placeholder "Value" ] []
                , button [] [ text "Add" ]
                ]
            ]
