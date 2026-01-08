package com.example.practiceee.db;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DBConnection {
    private static DBConnection dbConnection;
    private HikariDataSource dataSource;

    private DBConnection() {
        HikariConfig config = new HikariConfig();

        config.setJdbcUrl("jdbc:mysql://localhost:3306/sanka_seafood");
        config.setUsername("root");
        config.setPassword("1234");

        config.setMaximumPoolSize(10);
        config.setMinimumIdle(1);
        config.setMaxLifetime(30000);

        dataSource = new HikariDataSource(config);
    }

    public static DBConnection getInstance() {
        if (dbConnection == null) {
            synchronized (DBConnection.class) {
                if (dbConnection == null) {
                    dbConnection = new DBConnection();
                }
            }
        }
        return dbConnection;
    }

    public Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    public void closeDataSource() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
        }
    }
}
