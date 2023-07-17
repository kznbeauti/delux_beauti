package com.kzn.beauti
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // Call installSplashScreen() before setting the content view
        installSplashScreen()
        super.onCreate(savedInstanceState)
        
    }
}
