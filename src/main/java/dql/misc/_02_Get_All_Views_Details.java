package dql.misc;

import java.sql.*;

public class _02_Get_All_Views_Details {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")) {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("Select View_Name From User_Views");
            while (resultSet.next()){
                System.out.println(resultSet.getString(1));
            }
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
