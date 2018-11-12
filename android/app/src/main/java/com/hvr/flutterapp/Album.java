package com.hvr.flutterapp;

import android.content.ContentResolver;
import android.database.Cursor;
import android.provider.MediaStore;

import java.util.HashMap;

class Album
{
    private long mId;
    private String mTitle;
    private int mNumSongs;
    private String mArtist;
    private int mFirstYear;
    private int mLastYear;
    private String mAlbumArt;

    Album(long id, String title, int numSongs, String artist, int firstYear, int lastYear, ContentResolver contentResolver) {
        mId = id;
        mTitle = title;
        mNumSongs = numSongs;
        mArtist = artist;
        mFirstYear = firstYear;
        mLastYear = lastYear;
        mAlbumArt = getAlbumArt(contentResolver);
    }

    private String getAlbumArt(ContentResolver contentResolver) {
        String path = " ";

        Cursor albumCursor = contentResolver.query(MediaStore.Audio.Albums.EXTERNAL_CONTENT_URI, new String[]{MediaStore.Audio.Albums._ID, MediaStore.Audio.Albums.ALBUM_ART}, MediaStore.Audio.Albums._ID + "=?", new String[]{String.valueOf(mId)}, null);
        if (albumCursor.moveToFirst()) {
            path = albumCursor.getString(albumCursor.getColumnIndex(MediaStore.Audio.Albums.ALBUM_ART));
        }
        albumCursor.close();
        return path;
    }

    HashMap<String, Object> toMap()
    {
        HashMap<String, Object> albumHashMap = new HashMap<>();
        albumHashMap.put("id",mId);
        albumHashMap.put("title",mTitle);
        albumHashMap.put("number_songs",mNumSongs);
        albumHashMap.put("first_year",mFirstYear);
        albumHashMap.put("last_year",mLastYear);
        albumHashMap.put("artist",mArtist);
        albumHashMap.put("albumArt",mAlbumArt);

        return albumHashMap;
    }
}

