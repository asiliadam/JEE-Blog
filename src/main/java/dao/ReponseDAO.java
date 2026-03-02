package dao;
import beans.Reponse;
import java.sql.*;
import java.util.*;

public class ReponseDAO {

    public boolean add(Reponse r) {
        String sql = "INSERT INTO reponses (contenu,user_id,question_id) VALUES (?,?,?)";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1,r.getContenu()); ps.setInt(2,r.getUserId()); ps.setInt(3,r.getQuestionId());
            ps.executeUpdate(); return true;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<Reponse> getByQuestion(int questionId) {
        List<Reponse> list = new ArrayList<>();
        String sql = "SELECT r.*, u.username, u.nom, u.prenom FROM reponses r JOIN users u ON r.user_id=u.id WHERE r.question_id=? ORDER BY r.created_at ASC";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1,questionId); ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Reponse r2 = new Reponse();
                r2.setId(rs.getInt("id")); r2.setContenu(rs.getString("contenu"));
                r2.setUserId(rs.getInt("user_id")); r2.setQuestionId(rs.getInt("question_id"));
                String nom=rs.getString("nom"), prenom=rs.getString("prenom"), username=rs.getString("username");
                r2.setAuthorName((prenom!=null&&!prenom.isEmpty()?prenom+" ":"")+(nom!=null&&!nom.isEmpty()?nom:username));
                r2.setCreatedAt(rs.getTimestamp("created_at")); list.add(r2);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public boolean delete(int id) {
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement("DELETE FROM reponses WHERE id=?")) {
            ps.setInt(1,id); return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }
}
