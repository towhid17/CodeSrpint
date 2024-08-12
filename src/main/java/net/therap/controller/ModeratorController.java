package net.therap.controller;

import net.therap.exception.NotFoundException;
import net.therap.model.Role;
import net.therap.model.User;
import net.therap.service.RoleService;
import net.therap.service.UserService;
import net.therap.validator.ModeratorValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.Set;

import static java.util.Objects.isNull;
import static net.therap.helper.AuthorizationHelper.checkAccess;
import static net.therap.utils.RoleType.ADMIN;
import static net.therap.utils.RoleType.MODERATOR;

/**
 * @author towhidul.islam
 * @since 10/2/23
 */
@Controller
@RequestMapping("/moderator")
public class ModeratorController {

    @Autowired
    private RoleService roleService;

    @Autowired
    private UserService userService;

    @Autowired
    private ModeratorValidator moderatorValidator;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String showModeratorList(ModelMap modelMap, HttpSession httpSession) {
        checkAccess(httpSession, ADMIN);

        Set<User> moderators = roleService.getAllModerators();

        modelMap.addAttribute("moderators", moderators);
        modelMap.addAttribute("currentTab", "moderator");

        return "moderatorList";
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String showCreateModerator(ModelMap modelMap, HttpSession httpSession) {
        checkAccess(httpSession, ADMIN);

        modelMap.addAttribute("moderator", new User());

        return "createModerator";
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String createModerator(@Valid @ModelAttribute("moderator") User user,
                                  BindingResult bindingResult,
                                  HttpSession httpSession) {

        checkAccess(httpSession, ADMIN);

        if (bindingResult.hasErrors()) {
            return "createModerator";
        }

        userService.createUserByType(user, MODERATOR);

        return "redirect:/moderator/list";
    }

    @RequestMapping(value = "/lock", method = RequestMethod.POST)
    public String lockOrUnlockModerator(@RequestParam("moderatorId") int moderatorId,
                                        @RequestParam("status") boolean isLocked,
                                        HttpSession httpSession) {

        checkAccess(httpSession, ADMIN);

        User moderator = userService.find(moderatorId);

        moderatorValidator.validateModeratorLock(moderator, isLocked);

        userService.updateLock(moderator, isLocked);

        return "redirect:/moderator/list";
    }

}