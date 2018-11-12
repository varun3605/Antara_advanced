package com.hvr.flutterapp;

import java.util.ArrayList;
import java.util.HashMap;

public class ArtistNew
{
    String mArtistName;
    private ArrayList<Long> mAlbumIds;

    ArtistNew(String artistName, ArrayList<Long> albumIds) {
        mArtistName = artistName;
        mAlbumIds = albumIds;
    }

    public ArtistNew(String artistName) {
        mArtistName = artistName;
    }

    HashMap<String, Object> toMap()
    {
        HashMap<String, Object> artistHashMap = new HashMap<>();
        artistHashMap.put("id", mAlbumIds);
        artistHashMap.put("title",mArtistName);

        return artistHashMap;
    }
}
