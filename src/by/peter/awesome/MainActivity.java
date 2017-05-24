package by.peter.awesome;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.res.Resources;
import android.os.Bundle;
import android.widget.RelativeLayout;

public class MainActivity extends Activity {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
		
		Resources res = getResources();
		String[] quotes = res.getStringArray(R.array.pinkie_pie_quotes);
		
		RelativeLayout tapLayout = (RelativeLayout) findViewById(R.id.tap_layout);
		tapLayout.setOnClickListener(v -> {
            new AlertDialog.Builder(MainActivity.this)
                    .setTitle(getString(R.string.title))
                    .setMessage(quotes[(int)(Math.random()*quotes.length)])
                    .show();
        });
    }
}
