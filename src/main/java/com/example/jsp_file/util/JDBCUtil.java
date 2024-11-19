package com.example.jsp_file.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class JDBCUtil {

    private static final String URL = "jdbc:mariadb://walab.handong.edu:3306/OSS24_22100423";
    private static final String USER = "OSS24_22100423";
    private static final String PASSWORD = "nieJo3ch";

    static {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Failed to load MariaDB Driver", e);
        }
    }

    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException e) {
            throw new RuntimeException("Database connection failed!", e);
        }
    }

    public static void close(PreparedStatement stmt, Connection conn) {
        try {
            if (stmt != null) stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        Connection conn = null;
        try {
            conn = JDBCUtil.getConnection();
            if (conn != null) {
                System.out.println("DB 연결 완료!");
            } else {
                System.out.println("DB 연결 실패!");
            }
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                    System.out.println("DB 연결 닫음!");
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}