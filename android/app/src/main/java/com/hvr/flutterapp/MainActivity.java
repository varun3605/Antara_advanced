package com.hvr.flutterapp;

import android.Manifest;
import android.annotation.TargetApi;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.media.AudioManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.util.Log;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity implements MethodChannel.MethodCallHandler {
    private static final int REQUEST_CODE_READ_STORAGE = 1;
    private static final String CHANNEL = "com.hvr.flutterApp/audioFinder";
    private static final String CHANNEL_2 = "com.hvr.flutterApp/database";
    private Result mResult;
    private int prev_stat;
    int i, id;

    private static AudioManager sAudioManager;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

      MethodChannel methodChannel = new MethodChannel(getFlutterView(), CHANNEL);
      methodChannel.setMethodCallHandler(this);
      if (sAudioManager == null) {
          sAudioManager = (AudioManager) getApplicationContext().getSystemService(AUDIO_SERVICE);
      }
  }

    @Override
    public void onMethodCall(MethodCall methodCall, Result result) {
      switch(methodCall.method)
      {
          case "getPlatformVersion":
              result.success("Android" + Build.VERSION.RELEASE);
              break;
          case "getSongs":
              result.success(getSongData());
              break;
          case "getAlbums":
              result.success(getAlbumData());
              break;
          case "getArtists":
              result.success(getArtistData());
              break;
          case "getGenres":
              result.success(getGenreData());
              break;
          case "getPlayLists":
              result.success(getPlaylistData());
              break;
          case "getSongsFromAlbum":
              id = methodCall.argument("id");
              result.success(getSongDataFromAlbum(id));
              break;
          case "getSongsFromArtist":
              id = methodCall.argument("id");
              result.success(getSongDataFromArtist(id));
              break;
          case "getSongsFromGenre":
              id = methodCall.argument("id");
              result.success(getSongDataFromGenre(id));
              break;
          case "getSongsFromPlaylist":
          id = methodCall.argument("id");
          result.success(getSongDataFromPlaylist(id));
          break;
          case "request_permissions": //9. Requesting Permissions
              i=0;
              mResult = result;
              prev_stat = methodCall.argument("status");
              Log.i("App", "1");
              chkPermission();
              break;
          case "open_settings":
              Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:" + getPackageName()));
              intent.addCategory(Intent.CATEGORY_DEFAULT);
              intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
              startActivity(intent);
              finish();
              break;
          default:
              result.notImplemented();
              break;
      }
    }

    ArrayList<HashMap> getSongData() {
        AudioFinder audioFinder = new AudioFinder(getContentResolver());
        audioFinder.findSongs();
        List<Song> songList = audioFinder.getSongList();
        System.out.print(songList);
        ArrayList<HashMap> songHashMaps = new ArrayList<>();
        for (Song song : songList) {
            songHashMaps.add(song.toMap());
        }
        return songHashMaps;
    }

    ArrayList<HashMap> getAlbumData()
    {
        AudioFinder audioFinder = new AudioFinder(getContentResolver());
        audioFinder.findAlbums();
        List<Album> albumList = audioFinder.getAlbumList();
        System.out.print(albumList);
        ArrayList<HashMap> albumHashMaps = new ArrayList<>();
        for(Album album: albumList)
        {
            albumHashMaps.add(album.toMap());
        }

        return albumHashMaps;
    }

    ArrayList<HashMap> getArtistData()
    {
        AudioFinder audioFinder = new AudioFinder(getContentResolver());
        audioFinder.findArtists();
        List<Artist> artistList = audioFinder.getArtistList();
        System.out.print(artistList);
        ArrayList<HashMap> artistHashMaps = new ArrayList<>();
        for(Artist artist: artistList)
        {
            artistHashMaps.add(artist.toMap());
        }

        return artistHashMaps;
    }

    ArrayList<HashMap> getGenreData()
    {
        AudioFinder audioFinder = new AudioFinder(getContentResolver());
        audioFinder.findGenres();
        List<Genre> genreList = audioFinder.getGenreList();
        System.out.print(genreList);
        ArrayList<HashMap> genreHashMaps = new ArrayList<>();
        for(Genre genre:genreList)
        {
            genreHashMaps.add(genre.toMap());
        }

        return genreHashMaps;
    }

    ArrayList<HashMap> getPlaylistData()
    {
        AudioFinder audioFinder = new AudioFinder(getContentResolver());
        audioFinder.findPlayLists();
        List<Playlist> playListList = audioFinder.getPlayListList();
        System.out.print(playListList);
        ArrayList<HashMap> playListHashMaps = new ArrayList<>();
        for(Playlist playlist: playListList)
        {
            playListHashMaps.add(playlist.toMap());
        }

        return playListHashMaps;
    }

    ArrayList<HashMap> getSongDataFromAlbum(int album_id)
    {
        AudioFinder audioFinder = new AudioFinder(getContentResolver());
        audioFinder.findSongsFromAlbum(album_id);
        List<Song> songList = audioFinder.getSongList();
        System.out.print(songList);
        ArrayList<HashMap> songHashMaps = new ArrayList<>();
        for (Song song : songList) {
            songHashMaps.add(song.toMap());
        }
        return songHashMaps;
    }

    ArrayList<HashMap> getSongDataFromArtist(int artist_id)
    {
        AudioFinder audioFinder = new AudioFinder(getContentResolver());
        audioFinder.findSongsFromArtist(artist_id);
        List<Song> songList = audioFinder.getSongList();
        System.out.print(songList);
        ArrayList<HashMap> songHashMaps = new ArrayList<>();
        for (Song song : songList) {
            songHashMaps.add(song.toMap());
        }
        return songHashMaps;
    }

    ArrayList<HashMap> getSongDataFromGenre(int genre_id)
    {
        AudioFinder audioFinder = new AudioFinder(getContentResolver());
        audioFinder.findSongsFromGenre(genre_id);
        List<Song> songList = audioFinder.getSongList();
        System.out.print(songList);
        ArrayList<HashMap> songHashMaps = new ArrayList<>();
        for (Song song : songList) {
            songHashMaps.add(song.toMap());
        }
        return songHashMaps;
    }

    ArrayList<HashMap> getSongDataFromPlaylist(int playlist_id)
    {
        AudioFinder audioFinder = new AudioFinder(getContentResolver());
        audioFinder.findSongsFromPlaylist(playlist_id);
        List<Song> songList = audioFinder.getSongList();
        System.out.print(songList);
        ArrayList<HashMap> songHashMaps = new ArrayList<>();
        for (Song song : songList) {
            songHashMaps.add(song.toMap());
        }
        return songHashMaps;
    }

    @TargetApi(Build.VERSION_CODES.M)
    void chkPermission() //10. Checking Permissions according to code passed
    {
        if(getApplicationContext().checkSelfPermission(Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED)
        {
            Log.i("App", "2");
            if(prev_stat == 1)
            rqstPermissions(); //11. With Code 1, Request Permissions
            if(prev_stat ==2)
                requestPermissions();
        }
        else
        {
                Log.i("App", "3");
                mResult.success("PERMISSION_GRANTED");
        }
    }


    void rqstPermissions()
    {
        if(Build.VERSION.SDK_INT >=23)
        {
            if(this.shouldShowRequestPermissionRationale(Manifest.permission.READ_EXTERNAL_STORAGE))
            {
                Log.i("App", "4");
                mResult.success("PERMISSION_DENIED");
            }
            else
            {
                Log.i("App", "5");
                requestPermissions(); //12. In this.
            }
        }
        else {
            mResult.success("PERMISSION_GRANTED");
        }
    }

    void requestPermissions()
    {
        if(Build.VERSION.SDK_INT >=23) {
            Log.i("App", "6");
            if(i==0) {//13. Requesting Permissions for the First Time
                this.requestPermissions(new String[]{Manifest.permission.READ_EXTERNAL_STORAGE}, REQUEST_CODE_READ_STORAGE);
                i++; //15. Asked for the Permission the First Time
            }
            else
            {
                mResult.success("PERMISSION_DENIED_PERMANENTLY");
            }
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        switch (requestCode)
        {
            case REQUEST_CODE_READ_STORAGE:
            {
                if(grantResults.length>0 && grantResults[0] == PackageManager.PERMISSION_GRANTED)
                {
                    Log.i("App", "7");
                    mResult.success("PERMISSION_GRANTED"); //14. If Permission Granted, then success.
                }
                else
                {
                    Log.i("App", "8");

                    if(prev_stat == 1)
                        rqstPermissions();
                    if(prev_stat ==2)
                        mResult.success("PERMISSION_DENIED_PERMANENTLY");
                }
            }
        }
    }

}
