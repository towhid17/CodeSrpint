package net.therap.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;

import static net.therap.helper.AuthorizationHelper.checkAccess;
import static net.therap.utils.RoleType.ADMIN;

/**
 * @author towhidul.islam
 * @since 10/8/23
 */
@Controller
@RequestMapping(value = "/attribute")
public class AttributeController {

    @RequestMapping(method = RequestMethod.GET)
    public String getAttributePage(ModelMap modelMap, HttpSession httpSession) {
        checkAccess(httpSession, ADMIN);

        modelMap.addAttribute("currentTab", "attribute");

        return "attribute";
    }

}