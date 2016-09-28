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


plot : Int -> Int -> List Float -> String
plot xstep height data =
    let
        maxVal =
            List.maximum data |> Maybe.withDefault 1000

        ystep =
            round <| (toFloat height / maxVal)

        _ =
            log "ystep" ystep
    in
        List.map toFloat data
            |> List.indexedMap (plotPoint xstep ystep)
            |> log "points"
            |> List.map pointToString
            |> String.join " "


plotPoint : Int -> Int -> Int -> Float -> ( Int, Int )
plotPoint xstep ystep index value =
    ( xstep * index, ystep * round value )


pointToString : ( Int, Int ) -> String
pointToString ( x, y ) =
    toString x ++ "," ++ toString y
