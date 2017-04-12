module Update exposing (update)

{-| This module contains functions for updating the `Model`.

@docs update

-}

-- Application specific imports.

import Audio
import Model exposing (Model)
import Messages exposing (Msg(..))


{-| Update the application state.
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Play ->
            ( model
            , if Model.isPlaying model then
                Cmd.none
              else
                Model.currentTrack model
                    |> Audio.play
            )

        Pause ->
            ( model
            , Model.currentTrack model
                |> Audio.pause
            )

        Stop ->
            ( model
            , Model.currentTrack model
                |> Audio.stop
            )

        Next ->
            next model

        Prev ->
            prev model

        SeekPos pos ->
            ( Model.setSeekPos pos model, Cmd.none )

        SeekTo pos ->
            ( model
            , if Model.isPlaying model then
                ( Model.currentTrack model, pos * Model.duration model / 100 )
                    |> Audio.seekTo
              else
                Cmd.none
            )

        Volume vol ->
            ( model
            , Audio.volume (vol / 100)
            )

        PlayEvent duration ->
            ( Model.setPlaying model
                |> Model.setDuration duration
            , Cmd.none
            )

        PauseEvent _ ->
            ( Model.setPaused model, Cmd.none )

        StopEvent _ ->
            ( Model.setStopped model
                |> Model.setDuration 0
            , Cmd.none
            )

        TimeDelta dt ->
            ( model
            , if Model.isPlaying model then
                Model.currentTrack model
                    |> Audio.seek
              else
                Cmd.none
            )


{-| Play the next track.
-}
next : Model -> ( Model, Cmd Msg )
next model =
    let
        currentTrack =
            Model.currentTrack model

        newModel =
            Model.nextTrack model
    in
        ( newModel
        , Audio.stopAndPlay ( currentTrack, Model.currentTrack newModel )
        )


{-| Play the previous track.
-}
prev : Model -> ( Model, Cmd Msg )
prev model =
    let
        currentTrack =
            Model.currentTrack model

        newModel =
            Model.prevTrack model
    in
        ( newModel
        , Audio.stopAndPlay ( currentTrack, Model.currentTrack newModel )
        )
