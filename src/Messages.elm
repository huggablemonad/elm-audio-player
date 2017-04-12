module Messages exposing (Msg(..))

{-| This module contains messages handled by the application.

@docs Msg

-}

-- Standard library imports (elm-lang/*).

import Time exposing (Time)


{-| Messages handled by the application.
-}
type Msg
    = Play
    | Pause
    | Stop
    | Next
    | Prev
    | SeekPos Float
    | SeekTo Float
    | Volume Float
    | PlayEvent Float
    | PauseEvent ()
    | StopEvent ()
    | TimeDelta Time
