package dao;
import beans.User;
import java.sql.*;

public class UserDAO {

    public boolean register(User user) {
        String sql = "INSERT INTO users (username,email,password,nom,prenom,filiere,niveau,cne,is_verified) VALUES (?,?,?,?,?,?,?,?,TRUE)";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, user.getUsername()); ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword()); ps.setString(4, user.getNom());
            ps.setString(5, user.getPrenom()); ps.setString(6, user.getFiliere());
            ps.setString(7, user.getNiveau()); ps.setString(8, user.getCne());
            ps.executeUpdate(); return true;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public User login(String email, String password) {
        String sql = "SELECT * FROM users WHERE email=? AND password=?";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email); ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapUser(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public User getById(int id) {
        String sql = "SELECT * FROM users WHERE id=?";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id); ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapUser(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean updateProfile(User user) {
        String sql = "UPDATE users SET username=?,email=?,nom=?,prenom=?,filiere=?,niveau=?,cne=?,bio=? WHERE id=?";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1,user.getUsername()); ps.setString(2,user.getEmail());
            ps.setString(3,user.getNom()); ps.setString(4,user.getPrenom());
            ps.setString(5,user.getFiliere()); ps.setString(6,user.getNiveau());
            ps.setString(7,user.getCne()); ps.setString(8,user.getBio());
            ps.setInt(9,user.getId()); return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean updatePassword(int id, String pwd) {
        String sql = "UPDATE users SET password=? WHERE id=?";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1,pwd); ps.setInt(2,id); return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean emailExists(String email) {
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement("SELECT id FROM users WHERE email=?")) {
            ps.setString(1,email); return ps.executeQuery().next();
        } catch (SQLException e) { return false; }
    }

    public boolean usernameExists(String username) {
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement("SELECT id FROM users WHERE username=?")) {
            ps.setString(1,username); return ps.executeQuery().next();
        } catch (SQLException e) { return false; }
    }

    private User mapUser(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id")); u.setUsername(rs.getString("username"));
        u.setEmail(rs.getString("email")); u.setPassword(rs.getString("password"));
        u.setNom(rs.getString("nom")); u.setPrenom(rs.getString("prenom"));
        u.setFiliere(rs.getString("filiere")); u.setNiveau(rs.getString("niveau"));
        u.setCne(rs.getString("cne")); u.setRole(rs.getString("role"));
        u.setBio(rs.getString("bio")); u.setVerified(rs.getBoolean("is_verified"));
        u.setCreatedAt(rs.getTimestamp("created_at")); return u;
    }
}
