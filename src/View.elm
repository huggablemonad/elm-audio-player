module View exposing (view)

{-| This module contains functions to represent the application state as HTML.

@docs view

-}

-- Standard library imports (elm-lang/*).

import Color
import Html exposing (Html)
import Html.Attributes as Html
import Html.Events as Html
import Json.Decode as Json
import Svg
import Svg.Attributes as SvgA


-- Third party imports.

import Material.Icons.Av as Icons


-- Application specific imports.

import Model exposing (Model)
import Messages exposing (Msg(..))


{-| View the application state as HTML.
-}
view : Model -> Html Msg
view model =
    viewCenterDiv model


{-| `div` to center the application `div`.
-}
viewCenterDiv : Model -> Html Msg
viewCenterDiv model =
    Html.div
        [ Html.id "center-div" ]
        [ viewMainDiv model ]


{-| `div` containing the application.
-}
viewMainDiv : Model -> Html Msg
viewMainDiv model =
    Html.div
        [ Html.id "main-div" ]
        [ viewTitle model
        , viewElapsedTime model
        , viewSeekSlider model
        , viewControls
        , viewMiscControls
        , viewVolume
        , viewLambda
        ]


{-| Title of the current track.
-}
viewTitle : Model -> Html Msg
viewTitle model =
    Html.div
        [ Html.id "track-title" ]
        [ Html.span
            []
            [ Model.trackTitle model
                |> Maybe.withDefault "No title available"
                |> Html.text
            ]
        ]


{-| Audio controls.
-}
viewControls : Html Msg
viewControls =
    Html.div
        []
        [ viewPrev, viewPlay, viewPause, viewStop, viewNext ]


{-| `Play` button.
-}
viewPlay : Html Msg
viewPlay =
    Html.button
        [ Html.onClick Play ]
        [ Icons.play_arrow Color.charcoal controlButtonSize ]


{-| `Pause` button.
-}
viewPause : Html Msg
viewPause =
    Html.button
        [ Html.onClick Pause ]
        [ Icons.pause Color.charcoal controlButtonSize ]


{-| `Stop` button.
-}
viewStop : Html Msg
viewStop =
    Html.button
        [ Html.onClick Stop ]
        [ Icons.stop Color.charcoal controlButtonSize ]


{-| `Next` button.
-}
viewNext : Html Msg
viewNext =
    Html.button
        [ Html.onClick Next ]
        [ Icons.skip_next Color.charcoal controlButtonSize ]


{-| `Prev` button.
-}
viewPrev : Html Msg
viewPrev =
    Html.button
        [ Html.onClick Prev ]
        [ Icons.skip_previous Color.charcoal controlButtonSize ]


{-| Size of AV control buttons.
-}
controlButtonSize : Int
controlButtonSize =
    36


{-| Elapsed time.
-}
viewElapsedTime : Model -> Html Msg
viewElapsedTime model =
    Html.div
        [ Html.id "elapsed-time" ]
        [ Model.seekPos model
            |> formatTime
            |> Html.text
        ]


{-| Seek slider.
-}
viewSeekSlider : Model -> Html Msg
viewSeekSlider model =
    Html.div
        []
        [ Html.input
            [ Html.id "seek-slider"
            , Html.type_ "range"
            , Html.min "0"
            , Html.max "100"
            , Html.step "1"
            , Html.value <|
                if Model.isStopped model then
                    "0"
                else
                    Model.seekPos model
                        / Model.duration model
                        * 100
                        |> toString
            , Json.at [ "target", "valueAsNumber" ] Json.float
                |> Json.map SeekTo
                |> Html.on "input"
            ]
            []
        ]


{-| Format seconds as Minutes:Seconds.

    formatTime 0 == "0:00"
    formatTime 9 == "0:09"
    formatTime 10 == "0:10"
    formatTime 60 == "1:00"
    formatTime 119 == "1:59"
    formatTime 630 == "10:30"

-}
formatTime : Float -> String
formatTime time =
    let
        roundTime =
            round time

        minutes =
            roundTime // 60

        seconds =
            rem roundTime 60

        secondsString =
            if seconds < 10 then
                toString seconds
                    |> String.cons '0'
            else
                toString seconds
    in
        String.concat [ toString minutes, ":", secondsString ]


{-| Volume control.
-}
viewVolume : Html Msg
viewVolume =
    Html.div
        [ Html.id "volume" ]
        [ Html.div
            []
            [ Icons.volume_up Color.lightCharcoal 36 ]
        , Html.input
            [ Html.id "volume-slider"
            , Html.type_ "range"
            , Html.min "0"
            , Html.max "100"
            , Html.step "1"
            , Json.at [ "target", "valueAsNumber" ] Json.float
                |> Json.map Volume
                |> Html.on "input"
            ]
            []
        ]


{-| The `Playlist`, `Shuffle`, and `Repeat` buttons.
-}
viewMiscControls : Html Msg
viewMiscControls =
    Html.div
        [ Html.id "misc-controls" ]
        [ viewPlaylist, viewShuffle, viewRepeat ]


{-| The `Playlist` button.
-}
viewPlaylist : Html Msg
viewPlaylist =
    Html.button
        [ Html.id "playlist"
        , Html.disabled True
        ]
        [ Icons.playlist_add Color.darkGray 24 ]


{-| `Shuffle` button.
-}
viewShuffle : Html Msg
viewShuffle =
    Html.button
        [ Html.disabled True ]
        [ Icons.shuffle Color.darkGray 24 ]


{-| `Repeat` button.
-}
viewRepeat : Html Msg
viewRepeat =
    Html.button
        [ Html.disabled True ]
        [ Icons.repeat Color.darkGray 24 ]


{-| Lambda icon.

Source: <https://commons.wikimedia.org/wiki/File:Greek_lc_lamda_thin.svg>.

License: Public Domain

-}
viewLambda : Html Msg
viewLambda =
    Html.div
        [ Html.id "lambda" ]
        [ Svg.svg
            [ SvgA.width "15"
            , SvgA.viewBox "0 0 240 400"
            ]
            [ Svg.path
                [ SvgA.d "M 231.16564,301.71779 L 240,301.71779 C 239.99975,327.56651 235.78708,346.3804 227.36196,358.15951 C 218.93638,369.93865 208.42514,375.82822 195.82822,375.82822 C 185.52128,375.82822 175.62354,371.94274 166.13497,364.17178 C 156.64605,356.40083 148.13891,335.58286 140.6135,301.71779 L 119.5092,206.50307 L 46.380368,372.39264 L -8.1956387e-007,372.39264 L 105.03067,146.13497 C 99.468197,116.85097 92.760637,95.174101 84.907975,81.104294 C 77.055131,67.035069 67.32099,60.000311 55.705521,59.999999 C 46.380315,60.000311 38.241264,63.55859 31.288343,70.674846 C 24.335347,77.791705 20.44987,88.793739 19.631901,103.68098 L 10.797545,103.68098 C 11.288325,79.632194 16.114496,60.368409 25.276073,45.889569 C 34.437587,31.411383 45.889518,24.172126 59.631901,24.171778 C 68.466183,24.172126 76.850632,27.812204 84.785276,35.092023 C 92.719737,42.372517 99.590896,54.806042 105.39877,72.392637 C 111.20643,89.979832 120.24527,126.42151 132.51534,181.71779 L 149.93865,259.5092 C 156.97325,291.73832 164.37611,313.29249 172.14724,324.17178 C 179.91801,335.05116 189.20226,340.49083 200,340.4908 C 218.32288,340.49083 228.71142,327.56651 231.16564,301.71779 L 231.16564,301.71779 z"
                , SvgA.fill "gold"
                ]
                []
            ]
        ]
