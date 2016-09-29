module ChartView exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import String
import Debug exposing (log)


lineChart : Int -> Float -> List number -> Svg msg
lineChart xstep height data =
    svg
        [ width <| toString (xstep * (List.length data - 1))
        ]
        [ polyline
            [ stroke "#0074d9"
            , fill "#eee"
            , strokeWidth "1px"
            , points <| plot xstep height data
            ]
            []
        ]


-- swap first two arguments


-- Line
plot xstep height data =
    let
        maxVal =
            log "maxVal" (List.maximum data |> Maybe.withDefault 100)

        minVal =
            log "minVal" (List.minimum data |> Maybe.withDefault 0)

        -- pixels per unit
        difference =
            maxVal - minVal


    in
        data
            |> List.indexedMap (plotPoint xstep height minVal difference)
            |> List.map pointToString
            |> String.join " "


plotPoint xstep height minVal difference index value =
    let
        _ = log "difference" difference
        _ = log "value" value
        fraction = log "fraction" ((value - minVal) / difference)
        ypos     = log "ypos" height - fraction * height
        xpos    =  log "xpos" index *  xstep
    in
        (xpos, ypos)

pointToString (x, y) =
    toString x ++ "," ++ toString y ++ " "


-- Grid
