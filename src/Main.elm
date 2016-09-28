module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Date exposing (Date)
import Task
import ChartView exposing (lineChart)


-- model


type alias Name =
    String


type alias Entry =
    { date : Date
    , name : Name
    , value : Float
    }


type alias NewDropdown =
    { open : Bool
    , name : Name
    , date : String
    , value : Float
    }


type alias Model =
    { entries : List Entry
    , newDropdown : NewDropdown
    }



-- init


newEntry date =
    Entry date "" 0


init =
    Model [] (NewDropdown False "" "" 0) ! [ Task.perform NoOp Now <| Date.now ]



-- update


type Msg x
    = NoOp x
    | SaveEntry
    | ToggleDropdown Bool
    | Now Date
    | Resize Int Int


update msg model =
    case msg of
        SaveEntry ->
            model ! []

        ToggleDropdown bool ->
            { model | newDropdown = toggleOpen bool model.newDropdown } ! []

        Now date ->
            { model | newDropdown = setDate date model.newDropdown } ! []

        _ ->
            model ! []


toggleOpen open newDropdown =
    { newDropdown | open = open }


setDate date newDropdown =
    { newDropdown | date = toString date }



-- subscriptions


subscriptions model =
    Sub.none



-- view


view model =
    div [ class "container" ]
        [ header []
            [ button
                [ id "new-entry"
                , class <|
                    if model.newDropdown.open then
                        "active"
                    else
                        ""
                , onClick (ToggleDropdown (not model.newDropdown.open))
                ]
                []
            ]
        , newDropdown model
        , div [ class "chart-container" ]
            [ lineChart 100 887 [ 72.5, 73.2, 71.8, 72.8, 74.0, 72.0, 71.0 ] ]
        ]


newDropdown model =
    let
        class' =
            if model.newDropdown.open then
                "open"
            else
                ""
    in
        div [ class <| "new-dropdown " ++ class' ]
            [ input [ placeholder "Name" ] []
            , input [ placeholder "Date", value <| model.newDropdown.date ] []
            , input [ placeholder "Value" ] []
            , button [] [ text "Add" ]
            ]


main =
    App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
