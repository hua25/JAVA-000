package org.example.java0;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

import java.io.IOException;

public class HttpRequest {
    public static void main(String[] args) {
        String url = "http://localhost:8801";
        String result = null;
        try {
            result = doGet(url);
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(result);

    }

    private static String doGet(String url) throws IOException {
        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
                .get()
                .url(url)
                .build();
        Response response = null;
        response = client.newCall(request).execute();
        return response.body().string();
    }


}
