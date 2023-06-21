package dml.select;

import javax.xml.transform.Result;
import java.sql.*;

public class _07_SelectDistinctRecord_SelectedColumn {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("Select Distinct Designation From Emp");
            while(resultSet.next()){
                System.out.println(resultSet.getString(1));
            }
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
