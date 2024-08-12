package net.therap.validator;

import net.therap.annotation.SubmissionFile;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.Arrays;
import java.util.List;

import static java.util.Objects.isNull;
import static net.therap.utils.FileUtils.getFileExtension;

/**
 * @author towhidul.islam
 * @since 9/17/23
 */
public class SubmissionFileValidator implements ConstraintValidator<SubmissionFile, MultipartFile> {

    private List<String> allowedExtensions;
    private long maxSize;

    @Override
    public void initialize(SubmissionFile constraintAnnotation) {
        this.allowedExtensions = Arrays.asList(constraintAnnotation.allowedExtensions());
        this.maxSize = constraintAnnotation.maxSize();
    }

    @Override
    public boolean isValid(MultipartFile file, ConstraintValidatorContext context) {
        if (isNull(file) || file.isEmpty()) {
            return false;
        }

        String fileName = file.getOriginalFilename();
        String fileExtension = getFileExtension(fileName);

        if (!allowedExtensions.contains(fileExtension)) {
            return false;
        }

        return file.getSize() <= maxSize;
    }
}
