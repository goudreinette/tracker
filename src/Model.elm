module Model exposing (..)

import Date exposing (Date)


type alias Model =
    { facts : List Fact
    , view : View
    , newFactTag : String
    , newFactValue : String
    , currentTime : Maybe Date
    }


type Fact
    = Textual TextualFact
    | Numeric NumericFact


type alias TextualFact =
    { tag : String
    , text : String
    , date : Date
    }


type alias NumericFact =
    { tag : String
    , value : Float
    , date : Date
    }


type View
    = Chart
    | Timeline
    | New
