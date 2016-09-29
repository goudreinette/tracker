module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Date exposing (Date)
import Date.Format exposing (format)
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
    , date : Date
    , value : Float
    }


type alias Model =
    { entries : List Entry
    , newDropdown : NewDropdown
    , chartHeight : Float
    }



-- init


initDate =
    (Date.fromTime 1475158086)


initDropdown =
    NewDropdown False "" initDate 0


init =
    Model [] initDropdown 1464 ! [ Task.perform NoOp Now <| Date.now ]



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
    { newDropdown | date = date }



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
                [ text "+" ]
            ]
        , newDropdown model
        , div [ class "grid" ] []
        , div [ class "chart-container" ]
            [ lineChart 300 model.chartHeight (List.map .value model.entries)
            ]
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
            , dateInput model.newDropdown.date
            , input [ placeholder "Value" ] []
            , button [] [ text "Add" ]
            ]


dateInput date =
    div [ class "date-input" ]
        [ numberInput "d" ""
        , numberInput "m" ""
        , numberInput "y" ""
        ]


numberInput placeholder' value =
    input
        [ placeholder placeholder'
        , pattern "[0-9]"
        ]
        []


dateFormat : Date -> String
dateFormat date =
    format "%d-%m-%y" date


main =
    App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
