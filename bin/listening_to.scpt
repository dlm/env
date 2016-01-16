on getCurrentlyPlayingSpotifyTrack()
	tell application "Spotify"
		set currentState to player state as string
		if currentState is equal to "playing" then
			set currentArtist to my trimString(artist of current track as string, 10)
			set currentTrack to my trimString(name of current track as string, 8)
			set output to (currentArtist & " ♪ " & currentTrack)
		else
			set output to ""
		end if
		return output
	end tell
end getCurrentlyPlayingSpotifyTrack

on trimString(inputString, maxLength)
	set toReturn to inputString
	if (count inputString) > maxLength then
		set toReturn to (text 1 through (maxLength - 1) of inputString) & "…"
	end if
	return toReturn
end trimString
getCurrentlyPlayingSpotifyTrack()
