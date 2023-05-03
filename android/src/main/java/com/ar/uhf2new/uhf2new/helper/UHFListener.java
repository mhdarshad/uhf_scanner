package com.ar.uhf2new.uhf2new.helper;


public interface UHFListener {
    void onRead(String tagsJson);

    void onConnect(boolean isConnected, int powerLevel);

}