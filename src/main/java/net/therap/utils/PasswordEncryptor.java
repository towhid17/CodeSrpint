package net.therap.utils;

import javax.persistence.AttributeConverter;

import static net.therap.helper.AuthenticationHelper.generateMD5CryptHash;

/**
 * @author towhidul.islam
 * @since 9/25/23
 */
public class PasswordEncryptor implements AttributeConverter<String, String> {

    @Override
    public String convertToDatabaseColumn(String password) {
        return generateMD5CryptHash(password);
    }

    @Override
    public String convertToEntityAttribute(String dbData) {
        return dbData;
    }

}