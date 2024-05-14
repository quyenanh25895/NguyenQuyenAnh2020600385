package Utils;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.BufferedReader;
import java.io.IOException;

public class HttpUtil {

    private String value;

    public HttpUtil(String value) {
        this.value = value;
    }

    public static HttpUtil Of(BufferedReader reader) {
        StringBuilder sb = new StringBuilder();
        try {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

        } catch (IOException e) {
            System.out.print(e.getMessage());
        }
        return new HttpUtil(sb.toString());
    }

    public <T> T toModel(Class<T> classes) {
        try {
            return new ObjectMapper().readValue(value, classes);
        } catch (Exception e) {
            System.out.print(e.getMessage());
        }
        return null;
    }

}
