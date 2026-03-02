package utils;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtil {

    // ⚠️ Remplacez par votre email Gmail et mot de passe d'application
    private static final String FROM_EMAIL    = "votre.email@gmail.com";
    private static final String FROM_PASSWORD = "votre_mot_de_passe_app_gmail";

    public static void sendVerificationEmail(String toEmail, String verifyLink) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, FROM_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("✅ Vérifiez votre compte - JEE Blog");

            String body = "<div style='font-family:Arial;max-width:600px;margin:auto;padding:30px;border:1px solid #ddd;border-radius:10px;'>"
                    + "<h2 style='color:#4361ee;'>🎉 Bienvenue sur JEE Blog !</h2>"
                    + "<p>Merci de vous être inscrit. Cliquez sur le bouton ci-dessous pour activer votre compte :</p>"
                    + "<a href='" + verifyLink + "' style='display:inline-block;padding:12px 24px;background:#4361ee;color:white;text-decoration:none;border-radius:5px;font-weight:bold;'>Vérifier mon compte</a>"
                    + "<p style='margin-top:20px;color:#888;font-size:12px;'>Si vous n'avez pas créé de compte, ignorez cet email.</p>"
                    + "</div>";

            message.setContent(body, "text/html; charset=UTF-8");
            Transport.send(message);

        } catch (MessagingException e) {
            System.err.println("Erreur envoi email: " + e.getMessage());
        }
    }
}
