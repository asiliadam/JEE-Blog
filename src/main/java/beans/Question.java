package beans;
import java.sql.Timestamp;

public class Question {
    private int id;
    private String contenu;
    private int userId, moduleId;
    private String authorName, authorFiliere;
    private Timestamp createdAt;
    private int reponseCount;

    public Question() {}
    public int getId() { return id; } public void setId(int id) { this.id = id; }
    public String getContenu() { return contenu; } public void setContenu(String c) { this.contenu = c; }
    public int getUserId() { return userId; } public void setUserId(int u) { this.userId = u; }
    public int getModuleId() { return moduleId; } public void setModuleId(int m) { this.moduleId = m; }
    public String getAuthorName() { return authorName; } public void setAuthorName(String a) { this.authorName = a; }
    public String getAuthorFiliere() { return authorFiliere; } public void setAuthorFiliere(String f) { this.authorFiliere = f; }
    public Timestamp getCreatedAt() { return createdAt; } public void setCreatedAt(Timestamp t) { this.createdAt = t; }
    public int getReponseCount() { return reponseCount; } public void setReponseCount(int r) { this.reponseCount = r; }
}
