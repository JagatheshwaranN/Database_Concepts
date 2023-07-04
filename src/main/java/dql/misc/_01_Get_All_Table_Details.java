package dql.misc;

import java.sql.*;

public class _01_Get_All_Table_Details {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")) {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("Select TName, TabType From Tab");
            while (resultSet.next()){
                System.out.println(resultSet.getString(1) + "\t" +resultSet.getString(2));
            }
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
