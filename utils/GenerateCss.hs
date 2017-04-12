{-|
Module: Main
Description: CSS stylesheet for elm-audio-player
Copyright: (c) Huggable Monad, 2017
License: BSD3
Maintainer: huggablemonad@hushmail.me
Stability: experimental
Portability: GHC

CSS stylesheet for @elm-audio-player@.
-}
{-# LANGUAGE OverloadedStrings #-}

module Main
  ( main
  ) where

import Clay
import qualified Data.Text.Lazy.IO as Text

-- | Main entry point.
main :: IO ()
main = do
  putCss myStyleSheet
  Text.putStr "\n"
  Text.writeFile "default.css" $ render myStyleSheet

-- | Stylesheet for @elm-audio-player@.
myStyleSheet :: Css
myStyleSheet = do
  myBody
  centerDiv
  mainDiv
  elapsedTime
  trackTitle
  seekSlider
  volume
  volumeSlider
  miscControls
  playlist
  lambda

-- | @HTML@ @body@.
myBody :: Css
myBody =
  body ? do
    background black
    color $ rgb 0xa6 0xc8 0xd3

-- | Container for centering elements.
centerDiv :: Css
centerDiv =
  "#center-div" ? do
    display flex
    justifyContent center
    marginTop $ px 150

-- | @div@ containing all the different parts of @elm-audio-player@.
mainDiv :: Css
mainDiv =
  "#main-div" ? do
    background $ rgb 0x2b 0x32 0x35
    padding (px 10) (px 10) (px 10) (px 10)
    position relative
    width $ px 545

-- | Elapsed time of the currently playing track.
elapsedTime :: Css
elapsedTime =
  "#elapsed-time" ? do
    background black
    defaultFontFamily
    fontSize $ px 72
    paddingLeft $ px 24
    paddingRight $ px 24
    paddingTop $ px 10
    width $ px 200

-- | Track title with a marquee effect.
trackTitle :: Css
trackTitle =
  "#track-title" ? do
    background black
    defaultFontFamily
    fontSize $ px 24
    left $ px 258
    overflow hidden
    paddingTop $ px 10
    position absolute
    top $ px 10
    whiteSpace nowrap
    width $ px 300
    Clay.span <? do
      display inlineBlock
      marquee

-- | Input range slider for seeking within a track.
seekSlider :: Css
seekSlider =
  "#seek-slider" ? do
    paddingBottom $ px 5
    paddingTop $ px 5
    width $ px 540

-- | @div@ for the volume control.
volume :: Css
volume =
  "#volume" ? do
    left $ px 260
    position absolute
    top $ px 50

-- | Input range slider for the volume.
volumeSlider :: Css
volumeSlider =
  "#volume-slider" ? do
    left $ px 40
    position absolute
    top $ px 7
    width $ px 250

-- | Volume icon.
volumeIcon :: Css
volumeIcon = "#volume-icon" ? paddingTop (px 10)

-- | @div@ for the @playlist@, @shuffle@, and @repeat@ buttons.
miscControls :: Css
miscControls =
  "#misc-controls" ? do
    left $ px 300
    position absolute
    top $ px 135

-- | Playlist button.
playlist :: Css
playlist = "#playlist" ? marginRight (px 20)

-- | Lambda icon.
lambda :: Css
lambda =
  "#lambda" ? do
    bottom $ px 15
    position absolute
    right $ px 10

-- | Default font to use in @elm-audio-player@.
defaultFontFamily :: Css
defaultFontFamily = fontFamily ["Orbitron"] [sansSerif]

-- | Marquee effect in CSS3.
--
-- Source:
-- <http://stackoverflow.com/q/21233033 CSS3 Marquee Effect>
-- question by
-- <http://stackoverflow.com/users/3055753/fred-wu Fred Wu>.
-- <http://stackoverflow.com/a/21233577 Answered>
-- by <http://stackoverflow.com/users/1098851/fcalderan fcalderan>.
marquee :: Css
marquee = do
  animation "marquee" (sec 15) linear (sec 0) infinite normal none
  keyframes
    "marquee"
    [ (0, transform $ translate nil nil)
    , (100, transform $ translate (pct (-100)) nil)
    ]
  paddingLeft $ pct 100
