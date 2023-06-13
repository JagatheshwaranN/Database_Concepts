package dml.select;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class VerifyTableCreated {

    public static void main(String[] args) throws ClassNotFoundException, SQLException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME");
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT Column_Name, Data_Type, Data_Length, Nullable From User_Tab_Columns Where Table_Name = 'GROCERIES'");
        while (rs.next()) {
            System.out.println(rs.getString(1) + "	" + rs.getString(2) + "	" + rs.getInt(3) + "	 " + rs.getString(4));
        }
        conn.close();
    }
}
