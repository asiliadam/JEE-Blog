package beans;
import java.sql.Timestamp;

public class Reponse {
    private int id;
    private String contenu;
    private int userId, questionId;
    private String authorName;
    private Timestamp createdAt;

    public Reponse() {}
    public int getId() { return id; } public void setId(int id) { this.id = id; }
    public String getContenu() { return contenu; } public void setContenu(String c) { this.contenu = c; }
    public int getUserId() { return userId; } public void setUserId(int u) { this.userId = u; }
    public int getQuestionId() { return questionId; } public void setQuestionId(int q) { this.questionId = q; }
    public String getAuthorName() { return authorName; } public void setAuthorName(String a) { this.authorName = a; }
    public Timestamp getCreatedAt() { return createdAt; } public void setCreatedAt(Timestamp t) { this.createdAt = t; }
}
