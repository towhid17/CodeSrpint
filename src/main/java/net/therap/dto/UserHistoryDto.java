package net.therap.dto;

import org.springframework.stereotype.Component;

import java.io.Serializable;

/**
 * @author towhidul.islam
 * @since 10/8/23
 */
@Component
public class UserHistoryDto implements Serializable {

    private static final long serialVersionUID = 1L;

    private int totalProblems;

    private int totalHardProblems;

    private int totalMediumProblems;

    private int totalEasyProblems;

    private int totalSubmissions;

    private int totalProblemsAccepted;

    private int totalHardProblemsAccepted;

    private int totalMediumProblemsAccepted;

    private int totalEasyProblemsAccepted;

    public UserHistoryDto() {
    }

    public int getTotalProblems() {
        return totalProblems;
    }

    public void setTotalProblems(int totalProblems) {
        this.totalProblems = totalProblems;
    }

    public int getTotalHardProblems() {
        return totalHardProblems;
    }

    public void setTotalHardProblems(int totalHardProblems) {
        this.totalHardProblems = totalHardProblems;
    }

    public int getTotalMediumProblems() {
        return totalMediumProblems;
    }

    public void setTotalMediumProblems(int totalMediumProblems) {
        this.totalMediumProblems = totalMediumProblems;
    }

    public int getTotalEasyProblems() {
        return totalEasyProblems;
    }

    public void setTotalEasyProblems(int totalEasyProblems) {
        this.totalEasyProblems = totalEasyProblems;
    }

    public int getTotalSubmissions() {
        return totalSubmissions;
    }

    public void setTotalSubmissions(int totalSubmissions) {
        this.totalSubmissions = totalSubmissions;
    }

    public int getTotalProblemsAccepted() {
        return totalProblemsAccepted;
    }

    public void setTotalProblemsAccepted(int totalProblemsAccepted) {
        this.totalProblemsAccepted = totalProblemsAccepted;
    }

    public int getTotalHardProblemsAccepted() {
        return totalHardProblemsAccepted;
    }

    public void setTotalHardProblemsAccepted(int totalHardProblemsAccepted) {
        this.totalHardProblemsAccepted = totalHardProblemsAccepted;
    }

    public int getTotalMediumProblemsAccepted() {
        return totalMediumProblemsAccepted;
    }

    public void setTotalMediumProblemsAccepted(int totalMediumProblemsAccepted) {
        this.totalMediumProblemsAccepted = totalMediumProblemsAccepted;
    }

    public int getTotalEasyProblemsAccepted() {
        return totalEasyProblemsAccepted;
    }

    public void setTotalEasyProblemsAccepted(int totalEasyProblemsAccepted) {
        this.totalEasyProblemsAccepted = totalEasyProblemsAccepted;
    }

}