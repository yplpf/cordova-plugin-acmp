package org.giterlab;

import android.app.Application;
import android.content.Context;
import android.util.Log;

import com.alibaba.sdk.android.push.CloudPushService;
import com.alibaba.sdk.android.push.CommonCallback;
import com.alibaba.sdk.android.push.noonesdk.PushServiceFactory;

import static com.alibaba.sdk.android.push.AgooMessageReceiver.TAG;

/**
 * Created by wxj on 2017/9/11.
 */

public class DXApplication extends Application {
    private static DXApplication myContext;

    public DXApplication(){}
    public static DXApplication getContext(){
        return myContext;
    }

    public void onCreate(){
        super.onCreate();
        init(this);
        myContext= DXApplication.this;
    }

    private void init(Context applicationContext){
        PushServiceFactory.init(applicationContext);
        CloudPushService pushService = PushServiceFactory.getCloudPushService();
        pushService.register(applicationContext, new CommonCallback() {
            @Override
            public void onSuccess(String response) {
                Log.d(TAG, "init cloudchannel success");
            }
            @Override
            public void onFailed(String errorCode, String errorMessage) {

                Log.d(TAG, "init cloudchannel failed -- errorcode:" + errorCode + " -- errorMessage:" + errorMessage);
            }
        });

    }

}
