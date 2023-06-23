package dql.between;

import java.sql.*;

public class _02_SelectRecords_Using_Not_Between_Clause {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("Select * from Emp where Sal Not Between 40000 and 50000 order by Sal");
            while (resultSet.next()){
                System.out.println(resultSet.getInt(1)+" | "+resultSet.getString(2)+" | "+
                        resultSet.getInt(3) + " | "+resultSet.getString(4));
            }
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
