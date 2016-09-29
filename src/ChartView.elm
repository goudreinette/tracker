module ChartView exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import String
import Debug exposing (log)


lineChart : Int -> Int -> List Float -> Svg msg
lineChart xstep height data =
    svg
        [ viewBox "0 0 2200 900" ]
        [ polyline
            [ stroke "#0074d9"
            , fill "#eee"
            , strokeWidth "1px"
            , points <| plot xstep height data
            ]
            []
        ]


plot xstep height data =
    let
        maxVal =
            List.maximum data |> Maybe.withDefault 100

        minVal =
            List.minimum data |> Maybe.withDefault 0

        -- pixels per unit
        ystep =
            height // maxVal
    in
        data
            |> List.indexedMap (plotPoint xstep ystep)
            |> String.join " "


plotPoint xstep ystep index value =
    let
        x =
            xstep * index

        y =
            -ystep * value + 1000
    in
        toString x ++ "," ++ toString y
