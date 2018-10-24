package com.hvr.flutterapp;

import android.content.ContentResolver;
import android.database.Cursor;
import android.net.Uri;
import android.provider.MediaStore;

import java.util.HashMap;

public class Song
{

    long mId;
    String mArtist;
    String mTitle;
    String mAlbum;
    long mAlbumId;
    long mDuration;
    String mUri;
    String mAlbumart;
    long mSize;
    long mDateModified;
    String mType;
    int mYear;
    String mComposer;
    int mTrack;


    public Song(long id, String artist, String title, String album, long albumId, long duration, long size, long dateModified, String type, int year, String composer, int track, ContentResolver contentResolver) {
        mId = id;
        mArtist = artist;
        mTitle = title;
        mAlbum = album;
        mAlbumId = albumId;
        mDuration = duration;
        mSize = size;
        mDateModified = dateModified;
        mType = type;
        mYear = year;
        mComposer = composer;
        mTrack = track;
        mUri = getUri(contentResolver);
        mAlbumart = getAlbumart(contentResolver);
    }

    public long getId() {
        return mId;
    }

    public String getArtist() {
        return mArtist;
    }

    public String getTitle() {
        return mTitle;
    }

    public String getAlbum() {
        return mAlbum;
    }

    public long getAlbumId() {
        return mAlbumId;
    }

    public long getDuration() {
        return mDuration;
    }

    public long getSize() {
        return mSize;
    }

    public long getDateModified() {
        return mDateModified;
    }

    public String getType() {
        return mType;
    }

    public int getYear() {
        return mYear;
    }

    public String getComposer() {
        return mComposer;
    }

    public int getTrack() {
        return mTrack;
    }

    public String getUri(ContentResolver contentResolver) {

        Uri contentUri = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI;
        String[] projection = new String[]{MediaStore.Audio.Media._ID, MediaStore.Audio.Media.ARTIST, MediaStore.Audio.Media.TITLE, MediaStore.Audio.Media.ALBUM, MediaStore.Audio.Media.DURATION, MediaStore.Audio.Media.DATA, MediaStore.Audio.Media.ALBUM_ID};
        String selection = MediaStore.Audio.Media._ID + "=?";
        String[] selArg = new String[]{"" + mId};

        Cursor songCursor = contentResolver.query(contentUri, projection, selection, selArg, null);

        if (songCursor.getCount() >= 0) {
            songCursor.moveToPosition(0);
            mUri = songCursor.getString(songCursor.getColumnIndex(MediaStore.Audio.Media.DATA));
        }
        songCursor.close();
        return mUri;
    }

    public String getAlbumart(ContentResolver contentResolver) {
        String path = " ";

        Cursor albumCursor = contentResolver.query(MediaStore.Audio.Albums.EXTERNAL_CONTENT_URI, new String[]{MediaStore.Audio.Albums._ID, MediaStore.Audio.Albums.ALBUM_ART}, MediaStore.Audio.Albums._ID + "=?", new String[]{String.valueOf(mAlbumId)}, null);
        if (albumCursor.moveToFirst()) {
            path = albumCursor.getString(albumCursor.getColumnIndex(MediaStore.Audio.Albums.ALBUM_ART)); 
        }
        albumCursor.close();
        return path;
    }


    HashMap<String, Object> toMap() {
        HashMap<String, Object> songHashMap = new HashMap<>();
        songHashMap.put("id", mId);
        songHashMap.put("artist", mArtist);
        songHashMap.put("title", mTitle);
        songHashMap.put("album", mAlbum);
        songHashMap.put("albumId", mAlbumId);
        songHashMap.put("duration", mDuration);
        songHashMap.put("uri", mUri);
        songHashMap.put("albumArt", mAlbumart);
        songHashMap.put("size",mSize);
        songHashMap.put("date_modified",mDateModified);
        songHashMap.put("composer",mComposer);
        songHashMap.put("track_no",mTrack);
        songHashMap.put("song_type",mType);
        songHashMap.put("year",mYear);

        return songHashMap;
    }
}
