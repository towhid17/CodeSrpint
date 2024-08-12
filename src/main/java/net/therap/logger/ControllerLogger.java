package net.therap.logger;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import java.util.logging.FileHandler;
import java.util.logging.Logger;

/**
 * @author towhidul.islam
 * @since 9/26/23
 */
@Aspect
@Component
public class ControllerLogger {

    private static final Logger logger = Logger.getLogger(ControllerLogger.class.getName());

    static {
        try {
            FileHandler fileHandler = new FileHandler("/home/towhidulislam/Therap/Assignment_9_project/codesprint/logger/controller.log");
            logger.addHandler(fileHandler);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Before("execution(* net.therap.controller.*.*(..))")
    public void logBeforeControllerMethod(JoinPoint joinPoint) {
        String methodName = joinPoint.getSignature().getName();
        logger.info("Before calling " + methodName + " method.");
    }

    @AfterReturning(pointcut = "execution(* net.therap.controller.*.*(..))", returning = "result")
    public void logAfterControllerMethod(JoinPoint joinPoint, Object result) {
        String methodName = joinPoint.getSignature().getName();
        logger.info("After calling " + methodName + " method. Returned: " + result);
    }

}