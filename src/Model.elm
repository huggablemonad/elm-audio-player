module Model
    exposing
        ( Model
        , init
        , trackTitle
        , tracks
        , currentTrack
        , nextTrack
        , prevTrack
        , isPlaying
        , setPlaying
        , isPaused
        , setPaused
        , isStopped
        , setStopped
        , seekPos
        , setSeekPos
        , duration
        , setDuration
        )

{-| This module contains the application's [`Model`](#Model).

@docs Model, init


# Track Info

@docs trackTitle, tracks


# Changing Tracks

@docs currentTrack, nextTrack, prevTrack


# Track Status

@docs isPlaying, setPlaying, isPaused, setPaused, isStopped, setStopped


# Seeking

@docs seekPos, setSeekPos, duration, setDuration

-}

-- Standard library imports (elm-lang/*).

import Array exposing (Array)


{-| Application state.
-}
type Model
    = Model
        { currentTrack : Int
        , playState : PlayState
        , seekPos : Float
        , duration : Float
        }


{-| Whether a track is currently playing, paused, or stopped.
-}
type PlayState
    = Playing
    | Paused
    | Stopped


{-| Initialize the [`Model`](#Model).
-}
init : Model
init =
    Model
        { currentTrack = 0
        , playState = Stopped
        , seekPos = 0
        , duration = 0
        }


{-| Track titles.
-}
titles : Array String
titles =
    Array.fromList
        [ "1. Juhani Junkala - Title Screen"
        , "2. Juhani Junkala - Level 1"
        , "3. Juhani Junkala - Level 2"
        , "4. Juhani Junkala - Level 3"
        , "5. Juhani Junkala - Ending"
        ]


{-| Return the current track title.
-}
trackTitle : Model -> Maybe String
trackTitle (Model model) =
    Array.get (model.currentTrack) titles


{-| Track filenames.
-}
tracks : List (List String)
tracks =
    [ [ "title-screen.ogg" ]
    , [ "level-1.ogg" ]
    , [ "level-2.ogg" ]
    , [ "level-3.ogg" ]
    , [ "ending.ogg" ]
    ]


{-| Return the current track.
-}
currentTrack : Model -> Int
currentTrack (Model model) =
    model.currentTrack


{-| Skip to the next track.

If the current track is the last one, then wrap to the first track.

-}
nextTrack : Model -> Model
nextTrack (Model model) =
    Model
        { model
            | currentTrack =
                if model.currentTrack == List.length tracks - 1 then
                    0
                else
                    model.currentTrack + 1
        }


{-| Skip to the previous track.

If the current track is the first one, then wrap to the last track.

-}
prevTrack : Model -> Model
prevTrack (Model model) =
    Model
        { model
            | currentTrack =
                if model.currentTrack == 0 then
                    List.length tracks - 1
                else
                    model.currentTrack - 1
        }


{-| Return `True` if the current track is playing.
-}
isPlaying : Model -> Bool
isPlaying (Model model) =
    model.playState == Playing


{-| Set the current track's play state to "playing."
-}
setPlaying : Model -> Model
setPlaying (Model model) =
    Model
        { model
            | playState =
                Playing
        }


{-| Return `True` if the current track is paused.
-}
isPaused : Model -> Bool
isPaused (Model model) =
    model.playState == Paused


{-| Set the current track's play state to "paused."
-}
setPaused : Model -> Model
setPaused (Model model) =
    Model
        { model
            | playState =
                Paused
        }


{-| Return `True` if the current track is stopped.
-}
isStopped : Model -> Bool
isStopped (Model model) =
    model.playState == Stopped


{-| Set the current track's play state to "stopped."
-}
setStopped : Model -> Model
setStopped (Model model) =
    Model
        { model
            | playState =
                Stopped
            , seekPos =
                0
        }


{-| Return the current track's seek position.
-}
seekPos : Model -> Float
seekPos (Model model) =
    model.seekPos


{-| Set the current track's seek position.
-}
setSeekPos : Float -> Model -> Model
setSeekPos pos (Model model) =
    Model
        { model
            | seekPos =
                pos
        }


{-| Return the current track's duration.
-}
duration : Model -> Float
duration (Model model) =
    model.duration


{-| Set the current track's duration.
-}
setDuration : Float -> Model -> Model
setDuration dur (Model model) =
    Model
        { model
            | duration =
                dur
        }
