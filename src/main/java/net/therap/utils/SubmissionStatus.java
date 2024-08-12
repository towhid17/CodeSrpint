package net.therap.utils;

/**
 * @author towhidul.islam
 * @since 10/1/23
 */
public enum SubmissionStatus {

    PENDING(0),
    SUCCEED(1),
    WRONG(2);

    private int value;

    SubmissionStatus(int value) {
        this.value = value;
    }

}