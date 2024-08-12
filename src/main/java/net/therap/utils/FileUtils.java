package net.therap.utils;

/**
 * @author towhidul.islam
 * @since 10/18/23
 */
public class FileUtils {

    public static String getFileExtension(String fileName) {
        return fileName.substring(fileName.lastIndexOf('.')).toLowerCase();
    }
}
