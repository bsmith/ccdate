{-# LANGUAGE PatternSynonyms #-}

module Main where

import Data.Time.Clock ( getCurrentTime, UTCTime(utctDay) )
import Data.Time (getZonedTime, ZonedTime (zonedTimeToLocalTime, ZonedTime), TimeZone (TimeZone), LocalTime (LocalTime), diffDays)
import Data.Time.LocalTime (localDay, midday)
import Data.Time.Calendar
    ( pattern YearMonthDay,
      pattern February,
      pattern January,
      pattern October,
      Day(toModifiedJulianDay),
      dayOfWeek )
import System.Environment (setEnv)
import Data.Functor ((<&>))
-- import HaskellSay (haskellSay)
-- import Data.Time

-- Weeks start on Monday and end on Sunday
-- Week 1 was Monday 17th October 2022 in Europe/London
-- Week 11 was Monday 9th January 2023 in Europe/London
-- Week 0x10 is Monday 20th February 2023 in Europe/London
-- londonWinterTz :: TimeZone
-- londonWinterTz = TimeZone 0 False "GMT"

-- XXX should be simplified to just Day rather than ZonedTime

-- week1Monday, week11Monday, week0x10Monday :: ZonedTime
-- week1Monday = ZonedTime (LocalTime (YearMonthDay 2022 October 17) midday) londonWinterTz
-- week11Monday = ZonedTime (LocalTime (YearMonthDay 2023 January 9) midday) londonWinterTz
-- week0x10Monday = ZonedTime (LocalTime (YearMonthDay 2023 February 20) midday) londonWinterTz
week1Monday, week11Monday, week0x10Monday :: Day
week1Monday = YearMonthDay 2022 October 17
week11Monday = YearMonthDay 2023 January 9
week0x10Monday = YearMonthDay 2023 February 20

main :: IO ()
main = do
    currentTime <- getCurrentTime
    -- haskellSay $ show currentTime
    print currentTime
    print $ utctDay currentTime
    print =<< getZonedTime
    getZonedTime >>= \zt -> do
        print $ localDay $ zonedTimeToLocalTime zt
        print $ toModifiedJulianDay (localDay $ zonedTimeToLocalTime zt)
    print [week1Monday, week11Monday, week0x10Monday]
    -- print $ map (dayOfWeek . localDay . zonedTimeToLocalTime) [week1Monday, week11Monday, week0x10Monday]
    print $ diffDays week11Monday week1Monday
    setEnv "TZ" "Europe/London"
    dayNow <- getZonedTime <&> (localDay . zonedTimeToLocalTime)
    print $ diffDays dayNow (week1Monday) `divMod` 7