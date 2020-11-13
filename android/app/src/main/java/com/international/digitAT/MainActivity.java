package com.international.digitAT;

import android.content.ContextWrapper;
import android.content.Intent;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import androidx.annotation.NonNull;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
     private static final String CHANNEL = "international.digitat.com/channel";
     @Override
 public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
 GeneratedPluginRegistrant.registerWith(flutterEngine);
  new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result response) {
                      if(call.method.equals("test")){
                         response.success("Hello From Android!"); 
                      }  
                    }
                });
    }

 }


