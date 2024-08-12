package net.therap.exception;

/**
 * @author towhidul.islam
 * @since 10/16/23
 */
public class NotFoundException extends RuntimeException {

    public NotFoundException() {
        super("Not Found");
    }

    public NotFoundException(String message) {
        super(message);
    }

}