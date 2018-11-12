package com.hvr.flutterapp;

import java.util.HashMap;

class Genre
{
    private long mId;
    private String mTitle;

    Genre(long id, String title) {
        mId = id;
        mTitle = title;
    }

    HashMap<String, Object> toMap()
    {
        HashMap<String, Object> genreHashMap = new HashMap<>();
        genreHashMap.put("id", mId);
        genreHashMap.put("title",mTitle);

        return genreHashMap;
    }

}
