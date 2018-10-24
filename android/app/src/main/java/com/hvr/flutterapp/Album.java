package com.hvr.flutterapp;

import android.content.ContentResolver;
import android.database.Cursor;
import android.provider.MediaStore;

import java.util.HashMap;

public class Album
{
    long mId;
    String mTitle;
    int mNumSongs;
    String mArtist;
    int mFirstYear;
    int mLastYear;
    String mAlbumArt;

    public Album(long id, String title, int numSongs, String artist, int firstYear, int lastYear, ContentResolver contentResolver) {
        mId = id;
        mTitle = title;
        mNumSongs = numSongs;
        mArtist = artist;
        mFirstYear = firstYear;
        mLastYear = lastYear;
        mAlbumArt = getAlbumArt(contentResolver);
    }

    public long getId() {
        return mId;
    }

    public String getTitle() {
        return mTitle;
    }


    public int getNumSongs() {
        return mNumSongs;
    }

    public String getArtist() {
        return mArtist;
    }

    public int getFirstYear() {
        return mFirstYear;
    }

    public int getLastYear() {
        return mLastYear;
    }



    public String getAlbumArt(ContentResolver contentResolver) {
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

