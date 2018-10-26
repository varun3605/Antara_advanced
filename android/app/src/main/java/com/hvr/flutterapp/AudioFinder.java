package com.hvr.flutterapp;

import android.content.ContentResolver;
import android.database.Cursor;
import android.net.Uri;
import android.provider.MediaStore;
import android.util.Log;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class AudioFinder {
    private ContentResolver mContentResolver;
    private List<Song> mSongList = new ArrayList<>();
    private List<Album> mAlbumList = new ArrayList<>();
    private List<Artist> mArtistList = new ArrayList<>();
    private List<Genre> mGenreList = new ArrayList<>();
    private List<Playlist> mPlayLists = new ArrayList<>();
    private Random mRandom = new Random();

    public AudioFinder(ContentResolver contentResolver) {
        mContentResolver = contentResolver;
    }

    public void findSongs() {
        Uri songUri = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI;

        String sortOrder = MediaStore.Audio.Media.DEFAULT_SORT_ORDER + " ASC";
        Cursor songListCursor = mContentResolver.query(songUri, null, MediaStore.Audio.Media.IS_MUSIC + "=1", null, sortOrder);

        if (songListCursor == null)
            return;

        if (!songListCursor.moveToFirst())
            return;

        int idCol = songListCursor.getColumnIndex(MediaStore.Audio.Media._ID);
        int titleCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.TITLE);
        int artistCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.ARTIST);
        int albumCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.ALBUM);
        int durationCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.DURATION);
        int albumArtCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.ALBUM_ID);
        int sizeCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.SIZE);
        int dateModCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.DATE_MODIFIED);
        int typeCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.MIME_TYPE);
        int yearCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.YEAR);
        int composerCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.COMPOSER);
        int trackCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.TRACK);

        do {
            mSongList.add(new Song(
                    songListCursor.getLong(idCol),
                    songListCursor.getString(artistCol),
                    songListCursor.getString(titleCol),
                    songListCursor.getString(albumCol),
                    songListCursor.getLong(albumArtCol),
                    songListCursor.getLong(durationCol),
                    songListCursor.getLong(sizeCol),
                    songListCursor.getLong(dateModCol),
                    songListCursor.getString(typeCol),
                    songListCursor.getInt(yearCol),
                    songListCursor.getString(composerCol),
                    songListCursor.getInt(trackCol),
                    mContentResolver
            ));

        } while (songListCursor.moveToNext());

        songListCursor.close();
    }

    public void findAlbums() {
        Uri albumUri = MediaStore.Audio.Albums.EXTERNAL_CONTENT_URI;

        String sortOrder = MediaStore.Audio.Albums.DEFAULT_SORT_ORDER + " ASC";

        Cursor albumListCursor = mContentResolver.query(albumUri, null, null, null, sortOrder);

        if (albumListCursor == null)
            return;

        if (!albumListCursor.moveToFirst())
            return;

        int idCol = albumListCursor.getColumnIndex(MediaStore.Audio.Albums._ID);
        int titleCol = albumListCursor.getColumnIndex(MediaStore.Audio.Albums.ALBUM);
        int numSongCol = albumListCursor.getColumnIndex(MediaStore.Audio.Albums.NUMBER_OF_SONGS);
        int artistCol = albumListCursor.getColumnIndex(MediaStore.Audio.Albums.ARTIST);
        int firstYearCol = albumListCursor.getColumnIndex(MediaStore.Audio.Albums.FIRST_YEAR);
        int lastYearCol = albumListCursor.getColumnIndex(MediaStore.Audio.Albums.LAST_YEAR);


        do {
            mAlbumList.add(new Album(
                    albumListCursor.getLong(idCol),
                    albumListCursor.getString(titleCol),
                    albumListCursor.getInt(numSongCol),
                    albumListCursor.getString(artistCol),
                    albumListCursor.getInt(firstYearCol),
                    albumListCursor.getInt(lastYearCol),
                    mContentResolver
            ));
        } while (albumListCursor.moveToNext());

        albumListCursor.close();
    }

    public void findArtists() {
        Uri artistUri = MediaStore.Audio.Artists.EXTERNAL_CONTENT_URI;

        String sortOrder = MediaStore.Audio.Artists.DEFAULT_SORT_ORDER;

        Cursor artistCursor = mContentResolver.query(artistUri, null, null, null, sortOrder);

        if (artistCursor == null)
            return;

        if (!artistCursor.moveToFirst())
            return;

        int idCol = artistCursor.getColumnIndex(MediaStore.Audio.Artists._ID);
        int titleCol = artistCursor.getColumnIndex(MediaStore.Audio.Artists.ARTIST);
        int noOfTracksCol = artistCursor.getColumnIndex(MediaStore.Audio.Artists.NUMBER_OF_TRACKS);
        int noOfAlbumsCol = artistCursor.getColumnIndex(MediaStore.Audio.Artists.NUMBER_OF_ALBUMS);

        do {
            mArtistList.add(
                    new Artist(
                            artistCursor.getLong(idCol),
                            artistCursor.getString(titleCol),
                            artistCursor.getInt(noOfTracksCol),
                            artistCursor.getInt(noOfAlbumsCol)
                    )
            );
        } while (artistCursor.moveToNext());

        artistCursor.close();

    }

    public void findGenres()
    {
        Uri genreUri = MediaStore.Audio.Genres.EXTERNAL_CONTENT_URI;

        String sortOrder = MediaStore.Audio.Genres.DEFAULT_SORT_ORDER;

        Cursor genreCursor = mContentResolver.query(genreUri,null,null, null, sortOrder);

        if (genreCursor == null)
            return;

        if (!genreCursor.moveToFirst())
            return;

        int idCol = genreCursor.getColumnIndex(MediaStore.Audio.Genres._ID);
        int titleCol = genreCursor.getColumnIndex(MediaStore.Audio.Genres.NAME);

        do {
            mGenreList.add(new Genre(genreCursor.getLong(idCol), genreCursor.getString(titleCol)));
        }while(genreCursor.moveToNext());

        genreCursor.close();

    }

    public void findPlaylists()
    {
        Uri playListUri = MediaStore.Audio.Playlists.EXTERNAL_CONTENT_URI;

        String sortOrder = MediaStore.Audio.Playlists.DEFAULT_SORT_ORDER;

        Cursor playListCursor = mContentResolver.query(playListUri,null,null,null,sortOrder);

        if (playListCursor == null)
            return;

        if (!playListCursor.moveToFirst())
            return;

        int idCol = playListCursor.getColumnIndex(MediaStore.Audio.Playlists._ID);
        int titleCol = playListCursor.getColumnIndex(MediaStore.Audio.Playlists.NAME);
        int dateAddCol = playListCursor.getColumnIndex(MediaStore.Audio.Playlists.DATE_ADDED);
        int dateModCol = playListCursor.getColumnIndex(MediaStore.Audio.Playlists.DATE_MODIFIED);

        do {
            mPlayLists.add(new Playlist(playListCursor.getLong(idCol), playListCursor.getString(titleCol), playListCursor.getLong(dateAddCol), playListCursor.getLong(dateModCol)));
        }while(playListCursor.moveToNext());

        playListCursor.close();
    }

    public void findSongsfromAlbum(int id)
    {
        String selection = MediaStore.Audio.Media.ALBUM_ID + "=?";
        songFinder(selection,id);
    }

    public void findSongsfromArtist(int id)
    {
        String selection = MediaStore.Audio.Media.ARTIST_ID + "=?";
        songFinder(selection,id);
    }

    public void findSongsfromGenre(int id)
    {
        Uri genreUri = MediaStore.Audio.Genres.Members.getContentUri("external", id);
        songFinderforGenreUri(genreUri);
    }

    public void findSongsfromPlaylist(int id)
    {
        Uri playlistUri = MediaStore.Audio.Playlists.Members.getContentUri("external", id);
        songFinderforPlaylistUri(playlistUri);
    }

    public Song RandomSong() {
        if (mSongList.size() <= 0)
            return null;
        return mSongList.get(mRandom.nextInt(mSongList.size()));
    }

    public List<Song> getSongList() {
        return mSongList;
    }

    public List<Album> getAlbumList() {
        return mAlbumList;
    }

    public List<Artist> getArtistList()
    {
        return mArtistList;
    }

    public List<Genre> getGenreList()
    {
        return mGenreList;
    }

    public List<Playlist> getPlayListList()
    {
        return mPlayLists;
    }

    public void songFinder(String where, int id)
    {
        Uri songUri = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI;

        String sortOrder = MediaStore.Audio.Media.DEFAULT_SORT_ORDER + " ASC";


        String[] artistName = {String.valueOf(id)};
        Cursor songListCursor = mContentResolver.query(songUri, null, where, artistName, sortOrder);

        if (songListCursor == null)
            return;

        if (!songListCursor.moveToFirst())
            return;


        int idCol = songListCursor.getColumnIndex(MediaStore.Audio.Media._ID);
        int titleCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.TITLE);
        int artistCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.ARTIST);
        int albumCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.ALBUM);
        int durationCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.DURATION);
        int albumArtCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.ALBUM_ID);
        int sizeCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.SIZE);
        int dateModCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.DATE_MODIFIED);
        int typeCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.MIME_TYPE);
        int yearCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.YEAR);
        int composerCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.COMPOSER);
        int trackCol = songListCursor.getColumnIndex(MediaStore.Audio.Media.TRACK);

        do {
            mSongList.add(new Song(
                    songListCursor.getLong(idCol),
                    songListCursor.getString(artistCol),
                    songListCursor.getString(titleCol),
                    songListCursor.getString(albumCol),
                    songListCursor.getLong(albumArtCol),
                    songListCursor.getLong(durationCol),
                    songListCursor.getLong(sizeCol),
                    songListCursor.getLong(dateModCol),
                    songListCursor.getString(typeCol),
                    songListCursor.getInt(yearCol),
                    songListCursor.getString(composerCol),
                    songListCursor.getInt(trackCol),
                    mContentResolver
            ));

        } while (songListCursor.moveToNext());

        songListCursor.close();
    }

    public void songFinderforGenreUri(Uri genreUri)
    {
        String sortOrder = MediaStore.Audio.Media.DEFAULT_SORT_ORDER + " ASC";

        Cursor songListCursor = mContentResolver.query(genreUri, null, null, null, sortOrder);

        if (songListCursor == null)
            return;

        if (!songListCursor.moveToFirst())
            return;


        int idCol = songListCursor.getColumnIndex(MediaStore.Audio.Genres.Members._ID);
        int titleCol = songListCursor.getColumnIndex(MediaStore.Audio.Genres.Members.TITLE);
        int artistCol = songListCursor.getColumnIndex(MediaStore.Audio.Genres.Members.ARTIST);
        int albumCol = songListCursor.getColumnIndex(MediaStore.Audio.Genres.Members.ALBUM);
        int durationCol = songListCursor.getColumnIndex(MediaStore.Audio.Genres.Members.DURATION);
        int albumArtCol = songListCursor.getColumnIndex(MediaStore.Audio.Genres.Members.ALBUM_ID);
        int sizeCol = songListCursor.getColumnIndex(MediaStore.Audio.Genres.Members.SIZE);
        int dateModCol = songListCursor.getColumnIndex(MediaStore.Audio.Genres.Members.DATE_MODIFIED);
        int typeCol = songListCursor.getColumnIndex(MediaStore.Audio.Genres.Members.MIME_TYPE);
        int yearCol = songListCursor.getColumnIndex(MediaStore.Audio.Genres.Members.YEAR);
        int composerCol = songListCursor.getColumnIndex(MediaStore.Audio.Genres.Members.COMPOSER);
        int trackCol = songListCursor.getColumnIndex(MediaStore.Audio.Genres.Members.TRACK);

        do {
            mSongList.add(new Song(
                    songListCursor.getLong(idCol),
                    songListCursor.getString(artistCol),
                    songListCursor.getString(titleCol),
                    songListCursor.getString(albumCol),
                    songListCursor.getLong(albumArtCol),
                    songListCursor.getLong(durationCol),
                    songListCursor.getLong(sizeCol),
                    songListCursor.getLong(dateModCol),
                    songListCursor.getString(typeCol),
                    songListCursor.getInt(yearCol),
                    songListCursor.getString(composerCol),
                    songListCursor.getInt(trackCol),
                    mContentResolver
            ));

        } while (songListCursor.moveToNext());

        songListCursor.close();
    }

    public void songFinderforPlaylistUri(Uri playlistUri)
    {
        String sortOrder = MediaStore.Audio.Media.DEFAULT_SORT_ORDER + " ASC";

        String[] projection = {
                 MediaStore.Audio.Playlists.Members._ID,
        MediaStore.Audio.Playlists.Members.TITLE,
        MediaStore.Audio.Playlists.Members.ARTIST,
        MediaStore.Audio.Playlists.Members.ALBUM,
        MediaStore.Audio.Playlists.Members.DURATION,
        MediaStore.Audio.Playlists.Members.ALBUM_ID,
        MediaStore.Audio.Playlists.Members.SIZE,
        MediaStore.Audio.Playlists.Members.DATE_MODIFIED,
        MediaStore.Audio.Playlists.Members.MIME_TYPE,
        MediaStore.Audio.Playlists.Members.YEAR,
        MediaStore.Audio.Playlists.Members.COMPOSER,
        MediaStore.Audio.Playlists.Members.TRACK
        };
        Cursor songListCursor = mContentResolver.query(playlistUri, projection, null, null, sortOrder);

        if (songListCursor == null)
            return;

        if (!songListCursor.moveToFirst())
            return;

        int idCol = songListCursor.getColumnIndex(MediaStore.Audio.Playlists.Members._ID);
        int titleCol = songListCursor.getColumnIndex(MediaStore.Audio.Playlists.Members.TITLE);
        int artistCol = songListCursor.getColumnIndex(MediaStore.Audio.Playlists.Members.ARTIST);
        int albumCol = songListCursor.getColumnIndex(MediaStore.Audio.Playlists.Members.ALBUM);
        int durationCol = songListCursor.getColumnIndex(MediaStore.Audio.Playlists.Members.DURATION);
        int albumArtCol = songListCursor.getColumnIndex(MediaStore.Audio.Playlists.Members.ALBUM_ID);
        int sizeCol = songListCursor.getColumnIndex(MediaStore.Audio.Playlists.Members.SIZE);
        int dateModCol = songListCursor.getColumnIndex(MediaStore.Audio.Playlists.Members.DATE_MODIFIED);
        int typeCol = songListCursor.getColumnIndex(MediaStore.Audio.Playlists.Members.MIME_TYPE);
        int yearCol = songListCursor.getColumnIndex(MediaStore.Audio.Playlists.Members.YEAR);
        int composerCol = songListCursor.getColumnIndex(MediaStore.Audio.Playlists.Members.COMPOSER);
        int trackCol = songListCursor.getColumnIndex(MediaStore.Audio.Playlists.Members.TRACK);

        do {
            mSongList.add(new Song(
                    songListCursor.getLong(idCol),
                    songListCursor.getString(artistCol),
                    songListCursor.getString(titleCol),
                    songListCursor.getString(albumCol),
                    songListCursor.getLong(albumArtCol),
                    songListCursor.getLong(durationCol),
                    songListCursor.getLong(sizeCol),
                    songListCursor.getLong(dateModCol),
                    songListCursor.getString(typeCol),
                    songListCursor.getInt(yearCol),
                    songListCursor.getString(composerCol),
                    songListCursor.getInt(trackCol),
                    mContentResolver
            ));

        } while (songListCursor.moveToNext());

        songListCursor.close();
    }
}