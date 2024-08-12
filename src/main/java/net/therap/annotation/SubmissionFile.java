package net.therap.annotation;

import net.therap.validator.SubmissionFileValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @author towhidul.islam
 * @since 9/17/23
 */
@Target({ElementType.FIELD, ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = SubmissionFileValidator.class)
public @interface SubmissionFile {

    String message() default "Invalid image file";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    String[] allowedExtensions() default {".java"};

    long maxSize() default 10485760; // 10MB
}
