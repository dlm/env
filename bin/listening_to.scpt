on getCurrentlyPlayingSpotifyTrack()
	tell application "Spotify"
		set currentArtist to artist of current track as string
		set currentTrack to name of current track as string
		set output to ("♪ " & currentArtist & " - " & currentTrack)
	end tell
end getCurrentlyPlayingSpotifyTrack
getCurrentlyPlayingSpotifyTrack()

