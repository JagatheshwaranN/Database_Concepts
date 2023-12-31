package dml.delete;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class _03_DeleteRecord_From_View {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            int updateCount = statement.executeUpdate("Delete From Vw_Groceries Where Grcs_No = 102");
            System.out.println("Number of rows deleted : "+updateCount);
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
