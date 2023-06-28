package dql.relational_ops;

import java.sql.*;

public class _02_SelectRecords_Using_Relational_Ops_OrderBy_Type2 {

    static ResultSet resultSet;
    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();

            resultSet = statement.executeQuery("Select * from Emp where Sal <= 40000 order by Sal");
            while (resultSet.next()){
                System.out.println(resultSet.getInt(1)+" | "+resultSet.getString(2)+" | "+
                        resultSet.getInt(3) + " | "+resultSet.getString(4));
            }
            System.out.println("========================================");
            resultSet = statement.executeQuery("Select * from Emp where Sal >= 40000 order by Sal");
            while (resultSet.next()){
                System.out.println(resultSet.getInt(1)+" | "+resultSet.getString(2)+" | "+
                        resultSet.getInt(3) + " | "+resultSet.getString(4));
            }
            System.out.println("========================================");
            resultSet = statement.executeQuery("Select * from Emp where Sal < 50000 order by Sal");
            while (resultSet.next()){
                System.out.println(resultSet.getInt(1)+" | "+resultSet.getString(2)+" | "+
                        resultSet.getInt(3) + " | "+resultSet.getString(4));
            }
            System.out.println("========================================");
            resultSet = statement.executeQuery("Select * from Emp where Sal > 50000 order by Sal");
            while (resultSet.next()){
                System.out.println(resultSet.getInt(1)+" | "+resultSet.getString(2)+" | "+
                        resultSet.getInt(3) + " | "+resultSet.getString(4));
            }
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
