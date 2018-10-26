package com.hvr.flutterapp;

import java.util.HashMap;

public class Genre
{
    long mId;
    String mTitle;

    public Genre(long id, String title) {
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
