package dml.select;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SelectAllRows {

    public static void main(String[] args) throws ClassNotFoundException, SQLException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME");
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("Select * from Employee");
        while (rs.next()) {
            System.out.println(rs.getInt(1) + "	" + rs.getString(2) + "	" + rs.getInt(3) + "	 " + rs.getInt(4));
        }
        conn.close();
    }
}
