package dml.update;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class _02_UpdateRecord_Into_View {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            int updateCount = statement.executeUpdate("Update Vw_Groceries Set Grcs_Qty = '2No' where Grcs_Name = 'Cookies'");
            System.out.println("Number of rows updated : "+updateCount);
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
