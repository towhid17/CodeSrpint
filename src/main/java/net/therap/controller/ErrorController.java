package net.therap.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author towhidul.islam
 * @since 10/9/23
 */
@Controller
@RequestMapping(value = "/error")
public class ErrorController {

    @RequestMapping(value = "accessError", method = RequestMethod.GET)
    public String showAccessError() {
        return "accessError";
    }

    @RequestMapping(value = "serverError", method = RequestMethod.GET)
    public String showServerError() {
        return "serverError";
    }

}