# Jeffify - A Spotify Clone

![jeffify](https://i.imgur.com/njGq68u.png)

## Hello! Thanks for visiting Jeffify!

This is a 2-week project, aiming to showcase Spotify's unique style and its various features including search, playlists, and audio control.

The application is built upon a many-to-many relational database to allow connections between users, playlists, songs, albums, and artists.

### How it works

Users can:

- Choose to play entire albums by clicking on the album picture, or can play individual songs from within an album, search, or artist page. Users can also add songs to the queue if they wish to listen to it later.

- Signup/login to access the playlist features, allowing users to create personal playlists and add individual songs to them.

- Visit artist's page by clicking on the artist name either under the album name or inside an album. Artist's page will include all songs and albums by the artist, which the user can access.

- Search for all songs, albums, and artists that exist in the database

- Interact with the audio control just like any other music player out there!

### Technical Stack:

- React / Hooks
- Ruby on Rails
- PostgreSQL
- AWS S3

### Main features

- Audio control - Play/pause, repeat/skip, random, volume
- Search
- Playlists
- Queue
- Artist/album pages
- User signup/login to access playlists

### Extras

- **Backwards Button** :

Plays previous song if clicked within 3 seconds of current song

Repeats the current song from 0 seconds if clicked after the 3 second mark

- Playlist images evolve based on unique album images inside the playlist (Just like the real spotify!)
- Albums and songs will show an icon if it is currently playing
- Duplicate songs inside playlists are not allowed
- Username validation upon creation / Duplicate usernames not allowed
- Toggling random will randomize all songs after the current song in the queue
- Toggling the repeat button will repeat the song regardless of queue status

## Database

### Users

| id       | serial |
| -------- | ------ |
| username | string |
| password | string |

### Playlists

| id      | serial |
| ------- | ------ |
| name    | string |
| user_id | int    |

### UserPlaylists

| id          | serial |
| ----------- | ------ |
| song_id     | int    |
| playlist_id | int    |

### Songs

| id        | serial |
| --------- | ------ |
| title     | string |
| artist_id | int    |
| album_id  | int    |
| audio     | string |

### Albums

| id        | serial |
| --------- | ------ |
| name      | string |
| image     | string |
| year      | int    |
| artist_id | int    |

### Artists

| id    | serial |
| ----- | ------ |
| name  | string |
| image | string |
