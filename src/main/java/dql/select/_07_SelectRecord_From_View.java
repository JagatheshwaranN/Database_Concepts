package dql.select;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class _07_SelectRecord_From_View {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("Select * From Vw_Groceries");
            while(resultSet.next()){
                System.out.println(resultSet.getInt(1) + " | " + resultSet.getString(2) + " | " + resultSet.getString(3) + " | " + resultSet.getInt(4));
            }
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
