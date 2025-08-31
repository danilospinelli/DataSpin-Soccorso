package mySql;

import java.sql.*;
import java.text.SimpleDateFormat;

public class CreateAdminUser {

    // Parametri connessione al DB
    private static final String DB_URL = "jdbc:mysql://localhost:3306/soccorso";
    private static final String DB_USER = "superuser"; 
    private static final String DB_PASSWORD = "password123"; 
    private static final long SLEEP_MS = 10000; // 10 secondi

    public static void main(String[] args) {
        while (true) {
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                processAmministratori(conn);
                System.out.println("- - - Controllo completato. Attendo 10 secondi - - -\n");
                try {
                    Thread.sleep(SLEEP_MS);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            } catch (Exception e) {
                e.printStackTrace();
                break; 
            }
        }
    }

    private static void processAmministratori(Connection conn) throws SQLException {
        String sql = "SELECT Nome, Cognome, DataNascita FROM Amministratore";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                String nome = rs.getString("Nome");
                String cognome = rs.getString("Cognome");
                Date dataNascita = rs.getDate("DataNascita");

                // Creo username e password
                String username = cognome + nome;
                String password = cognome + new SimpleDateFormat("yyyyMMdd").format(dataNascita);

                createUserIfNotExists(conn, username, password);
                grantRole(conn, username);
            }
        }
    }

    private static void createUserIfNotExists(Connection conn, String username, String password) throws SQLException {
        String sql = "CREATE USER IF NOT EXISTS '" + username + "'@'localhost' IDENTIFIED BY '" + password + "'";
        try (Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
            System.out.println("Utente " + username + " verificato/creato.");
        }
    }

    private static void grantRole(Connection conn, String username) throws SQLException {
        try (Statement stmt = conn.createStatement()) {
            stmt.execute("GRANT amministratore TO '" + username + "'@'%'");
            stmt.execute("SET DEFAULT ROLE amministratore TO '" + username + "'@'%'");
            System.out.println("Ruolo amministratore assegnato a " + username);
        }
    }
}

