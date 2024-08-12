package net.therap.controller;

import net.therap.model.User;
import net.therap.service.RoleService;
import net.therap.service.UserService;
import net.therap.validator.SignUpValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import static net.therap.helper.AuthenticationHelper.setSessionUser;
import static net.therap.utils.RoleType.USER;

/**
 * @author towhidul.islam
 * @since 9/25/23
 */
@Controller
@RequestMapping("/signup")
public class SignUpController {

    public static final String SIGN_UP_USER = "signUpUser";

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private SignUpValidator signUpValidator;

    @RequestMapping(method = RequestMethod.GET)
    public String showSignUp(ModelMap modelMap, HttpSession httpSession) {
        modelMap.addAttribute(SIGN_UP_USER, new User());

        return "signUp";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String signUp(@Valid @ModelAttribute(SIGN_UP_USER) User user,
                         BindingResult bindingResult,
                         HttpServletRequest request) {

        signUpValidator.validate(user, bindingResult);

        if (bindingResult.hasErrors()) {
            return "signUp";
        }

        userService.createUserByType(user, USER);

        setSessionUser(request, user);

        return "redirect:/problem/list";
    }

}