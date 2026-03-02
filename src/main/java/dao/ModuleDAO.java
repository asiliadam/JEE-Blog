package dao;
import beans.Module;
import java.sql.*;
import java.util.*;

public class ModuleDAO {

    public boolean create(Module m) {
        String sql = "INSERT INTO modules (titre,description,contenu,filiere,niveau,semestre,user_id) VALUES (?,?,?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1,m.getTitre()); ps.setString(2,m.getDescription());
            ps.setString(3,m.getContenu()); ps.setString(4,m.getFiliere());
            ps.setString(5,m.getNiveau()); ps.setString(6,m.getSemestre());
            ps.setInt(7,m.getUserId()); ps.executeUpdate(); return true;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<Module> getAll() {
        List<Module> list = new ArrayList<>();
        String sql = "SELECT m.*, u.username, u.nom, u.prenom, " +
                     "(SELECT COUNT(*) FROM questions q WHERE q.module_id=m.id) as qcount " +
                     "FROM modules m JOIN users u ON m.user_id=u.id ORDER BY m.created_at DESC";
        try (Connection con = DBConnection.getConnection(); Statement st = con.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapModule(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Module getById(int id) {
        String sql = "SELECT m.*, u.username, u.nom, u.prenom FROM modules m JOIN users u ON m.user_id=u.id WHERE m.id=?";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1,id); ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapModule(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean update(Module m) {
        String sql = "UPDATE modules SET titre=?,description=?,contenu=?,filiere=?,niveau=?,semestre=? WHERE id=?";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1,m.getTitre()); ps.setString(2,m.getDescription());
            ps.setString(3,m.getContenu()); ps.setString(4,m.getFiliere());
            ps.setString(5,m.getNiveau()); ps.setString(6,m.getSemestre());
            ps.setInt(7,m.getId()); return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean delete(int id) {
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement("DELETE FROM modules WHERE id=?")) {
            ps.setInt(1,id); return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    private Module mapModule(ResultSet rs) throws SQLException {
        Module m = new Module();
        m.setId(rs.getInt("id")); m.setTitre(rs.getString("titre"));
        m.setDescription(rs.getString("description")); m.setContenu(rs.getString("contenu"));
        m.setFiliere(rs.getString("filiere")); m.setNiveau(rs.getString("niveau"));
        m.setSemestre(rs.getString("semestre")); m.setUserId(rs.getInt("user_id"));
        try {
            String nom = rs.getString("nom"), prenom = rs.getString("prenom");
            String username = rs.getString("username");
            m.setAuthorName((prenom!=null&&!prenom.isEmpty() ? prenom+" " : "") + (nom!=null&&!nom.isEmpty() ? nom : username));
        } catch (Exception ignored) {}
        m.setCreatedAt(rs.getTimestamp("created_at"));
        try { m.setQuestionCount(rs.getInt("qcount")); } catch (Exception ignored) {}
        return m;
    }
}
