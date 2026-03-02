package beans;
import java.sql.Timestamp;

public class User {
    private int id;
    private String username, email, password;
    private String nom, prenom, filiere, niveau, cne;
    private String role, bio;
    private boolean isVerified;
    private String verificationToken;
    private Timestamp createdAt;

    public User() {}
    public User(String username, String email, String password) {
        this.username = username; this.email = email; this.password = password;
        this.role = "membre"; this.isVerified = true;
    }

    public int getId() { return id; } public void setId(int id) { this.id = id; }
    public String getUsername() { return username; } public void setUsername(String u) { this.username = u; }
    public String getEmail() { return email; } public void setEmail(String e) { this.email = e; }
    public String getPassword() { return password; } public void setPassword(String p) { this.password = p; }
    public String getNom() { return nom; } public void setNom(String n) { this.nom = n; }
    public String getPrenom() { return prenom; } public void setPrenom(String p) { this.prenom = p; }
    public String getFiliere() { return filiere; } public void setFiliere(String f) { this.filiere = f; }
    public String getNiveau() { return niveau; } public void setNiveau(String n) { this.niveau = n; }
    public String getCne() { return cne; } public void setCne(String c) { this.cne = c; }
    public String getRole() { return role; } public void setRole(String r) { this.role = r; }
    public String getBio() { return bio; } public void setBio(String b) { this.bio = b; }
    public boolean isVerified() { return isVerified; } public void setVerified(boolean v) { isVerified = v; }
    public String getVerificationToken() { return verificationToken; } public void setVerificationToken(String t) { this.verificationToken = t; }
    public Timestamp getCreatedAt() { return createdAt; } public void setCreatedAt(Timestamp t) { this.createdAt = t; }
    public boolean isAdmin() { return "admin".equals(this.role); }
    public String getNomComplet() { return (prenom != null ? prenom : "") + " " + (nom != null ? nom : ""); }
}
