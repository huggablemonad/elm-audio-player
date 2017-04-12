module Main exposing (main)

{-| Module containing the entry point to the `elm-audio-player` program.

@docs main

-}

-- Standard library imports (elm-lang/*).

import Html


-- Application specific imports.

import Audio
import Messages exposing (Msg(..))
import Model exposing (Model)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import View exposing (view)


{-| Main entry point.
-}
main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


{-| Initialize the application state.
-}
init : ( Model, Cmd Msg )
init =
    ( Model.init, initAudio )


{-| Initialize the audio.
-}
initAudio : Cmd msg
initAudio =
    Audio.init Model.tracks
