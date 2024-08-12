package net.therap.utils;

/**
 * @author towhidul.islam
 * @since 7/24/23
 */
public enum RoleType {

    ADMIN(0),
    MODERATOR(1),
    USER(2);

    private int value;

    RoleType(int value) {
        this.value = value;
    }

}