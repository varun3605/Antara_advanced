package com.hvr.flutterapp;

import java.util.HashMap;

class Artist
{
    long mId;
    String mTitle;

    Artist(long id, String title) {
        mId = id;
        mTitle = title;

    }

    HashMap<String, Object> toMap()
    {
        HashMap<String, Object> artistHashMap = new HashMap<>();
        artistHashMap.put("id", mId);
        artistHashMap.put("title",mTitle);

        return artistHashMap;
    }
}
