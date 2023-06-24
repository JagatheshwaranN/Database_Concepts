package dql.aggregate_functions;

import java.sql.*;

public class _05_Select_Record_Using_Sum_function {

    static ResultSet resultSet;

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            resultSet = statement.executeQuery("Select Sum(Sal) From Emp");
            while (resultSet.next()){
                System.out.println(resultSet.getString(1));
            }
            System.out.println("====================================");
            resultSet = statement.executeQuery("Select Sum(All Sal) From Emp");
            while (resultSet.next()){
                System.out.println(resultSet.getString(1));
            }
            System.out.println("====================================");
            resultSet = statement.executeQuery("Select Sum(Distinct Sal) From Emp");
            while (resultSet.next()){
                System.out.println(resultSet.getString(1));
            }
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
