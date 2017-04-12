module Subscriptions exposing (subscriptions)

{-| This module contains functions to subscribe to events needed by the
application.

@docs subscriptions

-}

-- Standard library imports (elm-lang/*).

import AnimationFrame


-- Application specific imports.

import Audio
import Model exposing (Model)
import Messages exposing (Msg(..))


{-| Event sources that the application subscribes to.
-}
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Audio.seekPos SeekPos
        , Audio.playEvent PlayEvent
        , Audio.pauseEvent PauseEvent
        , Audio.stopEvent StopEvent
        , AnimationFrame.diffs TimeDelta
        ]
