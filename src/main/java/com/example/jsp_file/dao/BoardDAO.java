package com.example.jsp_file.dao;

import com.example.jsp_file.bean.BoardVO;
import com.example.jsp_file.util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String board_insert = "INSERT INTO board (title, writer, content, filename) VALUES (?, ?, ?, ?)";
    String board_update = "update board set title=?, writer=?, content=? where seq=?";
    String board_delete = "delete from board where seq=?";
    String board_get = "select * from board where seq=?";
    String board_list = "select * from board order by seq desc";
    String M_SELECT = "SELECT filename FROM board WHERE seq=?";

    public int insertBoard(BoardVO vo) {
        int result = 0;
        String sql = "INSERT INTO board (title, writer, content, filename) VALUES (?, ?, ?, ?)";

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

    public List<BoardVO> getBoardList() {
        List<BoardVO> boardList = new ArrayList<>();
        String sql = "SELECT seq, title, writer, content, filename, regdate FROM board ORDER BY seq DESC";

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
                boardList.add(board);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return boardList;
    }

    public BoardVO getBoard(int seq) {
        BoardVO board = null;
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(board_get);
            stmt.setInt(1, seq);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                board = new BoardVO();
                board.setId(rs.getInt("seq"));
                board.setTitle(rs.getString("title"));
                board.setWriter(rs.getString("writer"));
                board.setContent(rs.getString("content"));
                board.setCnt(rs.getInt("cnt"));
                board.setRegdate(rs.getTimestamp("regdate"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(stmt, conn);
        }
        return board;
    }

    public int updateBoard(BoardVO vo) {
        int result = 0;
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(board_update);
            stmt.setString(1, vo.getTitle());
            stmt.setString(2, vo.getWriter());
            stmt.setString(3, vo.getContent());
            stmt.setInt(4, vo.getId());
            result = stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(stmt, conn);
        }
        return result;
    }

    public int deleteBoard(int seq) {
        int result = 0;
        String sql = "DELETE FROM board WHERE seq = ?";
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, seq);
            result = stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(stmt, conn);
        }
        return result;
    }

    public String getPhotoFilename (int seq) {
        String filename = null;
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(M_SELECT);
            stmt.setInt(1, seq);
            rs = stmt.executeQuery();
            if (rs.next()) {
                filename = rs.getString("photo");
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("===> JDBC로 getPhotoFilename() 기능 처리");
        return filename;
    }
}
