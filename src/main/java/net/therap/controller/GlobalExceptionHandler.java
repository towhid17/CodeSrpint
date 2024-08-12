package net.therap.controller;

import net.therap.exception.NoAccessException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * @author towhidul.islam
 * @since 10/9/23
 */
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public String handleAllExceptionsExceptCustomException(Exception ex, RedirectAttributes redirectAttributes) {
        if (ex instanceof NoAccessException) {
            throw (NoAccessException) ex;

        } else {
            redirectAttributes.addFlashAttribute("errorMessage", ex.getMessage());

            return "redirect:/error/serverError";
        }
    }

    @ExceptionHandler(NoAccessException.class)
    public String handleCustomException(NoAccessException ex) {
        return "redirect:/error/accessError";
    }
}