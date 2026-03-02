package beans;
import java.sql.Timestamp;

public class Module {
    private int id;
    private String titre, description, contenu, filiere, niveau, semestre;
    private int userId;
    private String authorName;
    private Timestamp createdAt, updatedAt;
    private int questionCount;

    public Module() {}
    public int getId() { return id; } public void setId(int id) { this.id = id; }
    public String getTitre() { return titre; } public void setTitre(String t) { this.titre = t; }
    public String getDescription() { return description; } public void setDescription(String d) { this.description = d; }
    public String getContenu() { return contenu; } public void setContenu(String c) { this.contenu = c; }
    public String getFiliere() { return filiere; } public void setFiliere(String f) { this.filiere = f; }
    public String getNiveau() { return niveau; } public void setNiveau(String n) { this.niveau = n; }
    public String getSemestre() { return semestre; } public void setSemestre(String s) { this.semestre = s; }
    public int getUserId() { return userId; } public void setUserId(int u) { this.userId = u; }
    public String getAuthorName() { return authorName; } public void setAuthorName(String a) { this.authorName = a; }
    public Timestamp getCreatedAt() { return createdAt; } public void setCreatedAt(Timestamp t) { this.createdAt = t; }
    public Timestamp getUpdatedAt() { return updatedAt; } public void setUpdatedAt(Timestamp t) { this.updatedAt = t; }
    public int getQuestionCount() { return questionCount; } public void setQuestionCount(int q) { this.questionCount = q; }
    public String getExcerpt() {
        if (description == null) return "";
        return description.length() > 120 ? description.substring(0, 120) + "..." : description;
    }
}
