#!/usr/bin/env osascript
on getCurrentlyPlayingSpotifyTrack()
	tell application "Spotify"
		set currentState to player state as string
		if currentState is equal to "playing" then
			set currentArtist to (artist of current track as string)
			set currentTrack to (name of current track as string)
			set output to (currentArtist & "|" & currentTrack)
		else
			set output to ""
		end if
		return output
	end tell
end getCurrentlyPlayingSpotifyTrack

getCurrentlyPlayingSpotifyTrack()
