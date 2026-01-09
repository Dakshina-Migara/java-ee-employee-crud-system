package com.example.practiceee.db;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DBConnection {
    private static DBConnection instance;
    private HikariDataSource ds;

    private DBConnection() {
        try {
            // Load MySQL driver explicitly (required in Tomcat sometimes)
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:mysql://localhost:3306/sanka_seafood?useSSL=false&serverTimezone=UTC");
        config.setUsername("root"); // change if different
        config.setPassword("1234"); // change if different
        config.setMaximumPoolSize(10);
        config.setConnectionTimeout(30000);

        ds = new HikariDataSource(config);
    }

    public static DBConnection getInstance() {
        if (instance == null) {
            instance = new DBConnection();
        }
        return instance;
    }

    public Connection getConnection() throws SQLException {
        return ds.getConnection();
    }
}
