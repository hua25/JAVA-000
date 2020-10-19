import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class MyClassLoader extends ClassLoader {
    public static void main(String[] args) {
        try {
            Class clazz = new MyClassLoader().findClass("Hello");
            Object obj = clazz.newInstance();
            Method method = clazz.getDeclaredMethod("hello");
            method.invoke(obj);
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected Class<?> findClass(String name) throws ClassNotFoundException {
       byte[] bytes = readXlassFile(this.getClass().getResource("Hello.xlass").getPath());
        return defineClass(name, bytes, 0,bytes.length);
    }

    private byte[] readXlassFile(String path) {
        File file = new File(path);
        if (file.exists() && file.isFile()) {
            int length = (int) file.length();
            byte[] bytes = new byte[length];
            try (FileInputStream fi = new FileInputStream(file)) {
                fi.read(bytes);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
            for (int i = 0; i < bytes.length; i++) {
                bytes[i] = (byte) (255 - bytes[i]);
            }
            return bytes;
        }
        return new byte[0];
    }
}
