package net.therap.helper;

import org.springframework.stereotype.Component;

import java.io.*;

/**
 * @author towhidul.islam
 * @since 10/3/23
 */
@Component
public class CodeExecutionHelper {

    public static final String TEMP_EXECUTION_DIRECTORY = "/home/towhidulislam/Therap/Assignment_9_project/codesprint/temp/";
    public static final String SUBMITTED_JAVA_FILE = "Submitted.java";

    public String executeJavaFile() {
        try {
            if (!new java.io.File(TEMP_EXECUTION_DIRECTORY + SUBMITTED_JAVA_FILE).exists()) {
                return "File does not exist";
            }

            File dir = new File(TEMP_EXECUTION_DIRECTORY);

            if (!dir.exists()) {
                return "Directory does not exist";
            }

            Process compileProcess = new ProcessBuilder("./compileJava.sh", SUBMITTED_JAVA_FILE)
                    .directory(dir)
                    .start();

            int compileExitCode = compileProcess.waitFor();

            if (compileExitCode != 0) {
                return "Compilation failed with error code " + compileExitCode;
            }

            String className = SUBMITTED_JAVA_FILE.substring(0, SUBMITTED_JAVA_FILE.lastIndexOf('.'));
            Process executeProcess = new ProcessBuilder("./runJava.sh", className)
                    .directory(new File(TEMP_EXECUTION_DIRECTORY))
                    .start();

            StringBuilder output = new StringBuilder();
            BufferedReader reader = new BufferedReader(new InputStreamReader(executeProcess.getInputStream()));

            String line;

            while ((line = reader.readLine()) != null) {
                output.append(line).append("\n");
            }

            int executeExitCode = executeProcess.waitFor();

            if (executeExitCode == 0) {
                return "Execution successful:\n" + output.toString();

            } else {
                return "Execution failed with error code " + executeExitCode + ":\n" + output.toString();
            }

        } catch (IOException | InterruptedException e) {
            return "An error occurred while executing the Java file: " + e.getMessage();
        }
    }

    public boolean saveFile(String code) {
        try {
            File dir = new File(TEMP_EXECUTION_DIRECTORY);

            if (!dir.exists()) {
                dir.mkdir();
            }

            File file = new File(TEMP_EXECUTION_DIRECTORY + SUBMITTED_JAVA_FILE);

            if (!file.exists()) {
                file.createNewFile();
            }

            FileWriter fileWriter = new FileWriter(file);
            fileWriter.write(code);
            fileWriter.close();

            return true;

        } catch (IOException e) {
            return false;
        }
    }

}
