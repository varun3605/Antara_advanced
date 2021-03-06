package com.hvr.flutterapp;

import java.util.HashMap;

class Playlist
{
    private long mId;
    private String mTitle;
    private long mDateAdded;
    private long mDateModified;

    Playlist(long id, String title, long dateAdded, long dateModified) {
        mId = id;
        mTitle = title;
        mDateAdded = dateAdded;
        mDateModified = dateModified;
    }

    HashMap<String, Object> toMap()
    {
        HashMap<String, Object> playlistHashMap = new HashMap<>();
        playlistHashMap.put("id", mId);
        playlistHashMap.put("title",mTitle);
        playlistHashMap.put("date_added",mDateAdded);
        playlistHashMap.put("date_modified",mDateModified);

        return playlistHashMap;
    }
}
