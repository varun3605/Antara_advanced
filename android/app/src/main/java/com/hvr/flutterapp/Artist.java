package com.hvr.flutterapp;

import java.util.HashMap;

public class Artist
{
    long mId;
    String mTitle;
    int mNoOfAlbums;
    int mNoOfTracks;

    public Artist(long id, String title, int noOfAlbums, int noOfTracks) {
        mId = id;
        mTitle = title;
        mNoOfAlbums = noOfAlbums;
        mNoOfTracks = noOfTracks;
    }

    HashMap<String, Object> toMap()
    {
        HashMap<String, Object> artistHashMap = new HashMap<>();
        artistHashMap.put("id", mId);
        artistHashMap.put("title",mTitle);
        artistHashMap.put("no_of_tracks",mNoOfTracks);
        artistHashMap.put("no_of_albums",mNoOfAlbums);

        return artistHashMap;
    }
}
