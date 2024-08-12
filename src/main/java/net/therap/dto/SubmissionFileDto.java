package net.therap.dto;

import net.therap.annotation.SubmissionFile;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.Serializable;

/**
 * @author towhidul.islam
 * @since 10/2/23
 */
@Component
public class SubmissionFileDto implements Serializable {

    private static final long serialVersionUID = 1L;

    @SubmissionFile
    private MultipartFile submissionFile;

    public SubmissionFileDto() {
    }

    public SubmissionFileDto(MultipartFile submissionFile) {
        this.submissionFile = submissionFile;
    }

    public MultipartFile getSubmissionFile() {
        return submissionFile;
    }

    public void setSubmissionFile(MultipartFile submissionFile) {
        this.submissionFile = submissionFile;
    }

}