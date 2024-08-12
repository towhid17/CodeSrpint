package net.therap.exception;

/**
 * @author towhidul.islam
 * @since 10/9/23
 */
public class NoAccessException extends RuntimeException {

    public NoAccessException() {
        super("Access denied");
    }

    public NoAccessException(String message) {
        super(message);
    }

}