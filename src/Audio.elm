port module Audio
    exposing
        ( init
        , play
        , pause
        , stop
        , stopAndPlay
        , seek
        , seekPos
        , seekTo
        , volume
        , playEvent
        , pauseEvent
        , stopEvent
        )

{-| This module contains functions for dealing with audio.


# Initialization

@docs init


# AV Controls

@docs play, pause, stop, stopAndPlay, seek, seekPos, seekTo, volume


# Events

@docs playEvent, pauseEvent, stopEvent

-}


{-| Initialize `howler.js` with a list of tracks.

    init [ ["track-1.webm", "track-1.ogg", "track-1.mp3" ]
         , ["track-2.webm", "track-2.ogg", "track-2.mp3" ]
         , ["track-3.webm", "track-3.mp3", "track-3.ogg" ]
         ]

The first format supported by the browser will be played, e.g., if the browser
supports `Ogg` and `MP3` but not `WebM`, then it will play `track-1.ogg`,
`track-2.ogg`, and `track-3.mp3`. The format extension (e.g., "webm") is
required.

-}
port init : List (List String) -> Cmd msg


{-| Play the first track that the browser supports.
-}
port play : Int -> Cmd msg


{-| Pause the current track.
-}
port pause : Int -> Cmd msg


{-| Stop playing the current track.
-}
port stop : Int -> Cmd msg


{-| Stop playing the current track and start playing the next one.

    stopAndPlay (currentTrackId, nextTrackId)

It's used when skipping to the next or previous track.

-}
port stopAndPlay : ( Int, Int ) -> Cmd msg


{-| Get the current seek position for the current track.
-}
port seek : Int -> Cmd msg


{-| Return the current seek position for the current track.
-}
port seekPos : (Float -> msg) -> Sub msg


{-| Set the seek position for the current track.
-}
port seekTo : ( Int, Float ) -> Cmd msg


{-| Set the global volume.
-}
port volume : Float -> Cmd msg


{-| Listen for `onplay` events.
-}
port playEvent : (Float -> msg) -> Sub msg


{-| Listen for `pause` events.
-}
port pauseEvent : (() -> msg) -> Sub msg


{-| Listen for `onstop` events.
-}
port stopEvent : (() -> msg) -> Sub msg
