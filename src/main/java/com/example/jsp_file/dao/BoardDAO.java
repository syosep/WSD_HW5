package com.example.jsp_file.dao;

import com.example.jsp_file.bean.BoardVO;
import com.example.jsp_file.util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    public int insertBoard(BoardVO vo) {
        String sql = "INSERT INTO board (title, writer, content, filename) VALUES (?, ?, ?, ?)";
        int result = 0;

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, vo.getTitle());
            stmt.setString(2, vo.getWriter());
            stmt.setString(3, vo.getContent());
            stmt.setString(4, vo.getFilename());
            result = stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public List<BoardVO> getBoardList(String sortBy) {
        List<BoardVO> boardList = new ArrayList<>();
        String sql = "SELECT seq, title, writer, content, filename, regdate, cnt FROM board ORDER BY ";

        if ("title".equals(sortBy)) {
            sql += "title ASC";
        } else {
            sql += "regdate DESC";
        }

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                BoardVO board = new BoardVO();
                board.setId(rs.getInt("seq"));
                board.setTitle(rs.getString("title"));
                board.setWriter(rs.getString("writer"));
                board.setContent(rs.getString("content"));
                board.setFilename(rs.getString("filename"));
                board.setRegdate(rs.getTimestamp("regdate"));
                board.setCnt(rs.getInt("cnt"));
                boardList.add(board);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return boardList;
    }

    public List<BoardVO> searchPosts(String keyword) {
        List<BoardVO> boardList = new ArrayList<>();
        String sql = "SELECT seq, title, writer, content, filename, regdate, cnt FROM board " +
                "WHERE title LIKE ? OR content LIKE ? ORDER BY regdate DESC";

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                BoardVO board = new BoardVO();
                board.setId(rs.getInt("seq"));
                board.setTitle(rs.getString("title"));
                board.setWriter(rs.getString("writer"));
                board.setContent(rs.getString("content"));
                board.setFilename(rs.getString("filename"));
                board.setRegdate(rs.getTimestamp("regdate"));
                board.setCnt(rs.getInt("cnt"));
                boardList.add(board);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return boardList;
    }

    public void increaseViewCount(int seq) {
        String sql = "UPDATE board SET cnt = cnt + 1 WHERE seq = ?";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, seq);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public BoardVO getBoard(int seq) {
        BoardVO board = null;
        String sql = "SELECT seq, title, writer, content, filename, regdate, cnt FROM board WHERE seq = ?";

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, seq);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                board = new BoardVO();
                board.setId(rs.getInt("seq"));
                board.setTitle(rs.getString("title"));
                board.setWriter(rs.getString("writer"));
                board.setContent(rs.getString("content"));
                board.setFilename(rs.getString("filename"));
                board.setRegdate(rs.getTimestamp("regdate"));
                board.setCnt(rs.getInt("cnt"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return board;
    }

    public int updateBoard(BoardVO vo) {
        String sql = "UPDATE board SET title = ?, writer = ?, content = ?, filename = ? WHERE seq = ?";
        int result = 0;

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, vo.getTitle());
            stmt.setString(2, vo.getWriter());
            stmt.setString(3, vo.getContent());
            stmt.setString(4, vo.getFilename());
            stmt.setInt(5, vo.getId());
            result = stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public int deleteBoard(int seq) {
        String sql = "DELETE FROM board WHERE seq = ?";
        int result = 0;

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, seq);
            result = stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public String getPhotoFilename(int seq) {
        String sql = "SELECT filename FROM board WHERE seq = ?";
        String filename = null;

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, seq);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                filename = rs.getString("filename");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return filename;
    }
}