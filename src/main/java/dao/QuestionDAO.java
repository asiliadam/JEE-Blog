package dao;
import beans.Question;
import java.sql.*;
import java.util.*;

public class QuestionDAO {

    public boolean add(Question q) {
        String sql = "INSERT INTO questions (contenu,user_id,module_id) VALUES (?,?,?)";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1,q.getContenu()); ps.setInt(2,q.getUserId()); ps.setInt(3,q.getModuleId());
            ps.executeUpdate(); return true;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<Question> getByModule(int moduleId) {
        List<Question> list = new ArrayList<>();
        String sql = "SELECT q.*, u.username, u.nom, u.prenom, u.filiere, " +
                     "(SELECT COUNT(*) FROM reponses r WHERE r.question_id=q.id) as rcount " +
                     "FROM questions q JOIN users u ON q.user_id=u.id WHERE q.module_id=? ORDER BY q.created_at DESC";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1,moduleId); ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Question q2 = new Question();
                q2.setId(rs.getInt("id")); q2.setContenu(rs.getString("contenu"));
                q2.setUserId(rs.getInt("user_id")); q2.setModuleId(rs.getInt("module_id"));
                String nom=rs.getString("nom"), prenom=rs.getString("prenom"), username=rs.getString("username");
                q2.setAuthorName((prenom!=null&&!prenom.isEmpty()?prenom+" ":"")+(nom!=null&&!nom.isEmpty()?nom:username));
                q2.setAuthorFiliere(rs.getString("filiere"));
                q2.setCreatedAt(rs.getTimestamp("created_at"));
                try { q2.setReponseCount(rs.getInt("rcount")); } catch(Exception ignored){}
                list.add(q2);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Question getById(int id) {
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement("SELECT * FROM questions WHERE id=?")) {
            ps.setInt(1,id); ResultSet rs = ps.executeQuery();
            if (rs.next()) { Question q = new Question(); q.setId(rs.getInt("id")); q.setUserId(rs.getInt("user_id")); q.setModuleId(rs.getInt("module_id")); return q; }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean delete(int id) {
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement("DELETE FROM questions WHERE id=?")) {
            ps.setInt(1,id); return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }
}
