package dql.aggregate_functions;

import java.sql.*;

public class _03_Select_Record_Using_Avg_function {

    static ResultSet resultSet;

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            resultSet = statement.executeQuery("Select Avg(Sal) From Emp");
            while (resultSet.next()){
                System.out.println(resultSet.getInt(1));
            }
            System.out.println("======================================================");
            resultSet = statement.executeQuery("Select Avg(All Sal) From Emp");
            while (resultSet.next()){
                System.out.println(resultSet.getInt(1));
            }
            System.out.println("======================================================");
            resultSet = statement.executeQuery("Select Avg(Distinct Sal) From Emp");
            while (resultSet.next()){
                System.out.println(resultSet.getInt(1));
            }
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
