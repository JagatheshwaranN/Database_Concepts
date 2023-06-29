package dql.rownum;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class _01_SelectRecords_Using_RowNum {

    static ResultSet resultSet;
    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")){
            Statement statement = connection.createStatement();

            resultSet = statement.executeQuery("Select ROWNUM, E.* From Emp E");
            while(resultSet.next()){
                System.out.println(resultSet.getInt(1)+" | "+resultSet.getInt(2)+" | "+resultSet.getString(3)+" | "+
                        resultSet.getInt(4) + " | "+resultSet.getString(5));
            }
            System.out.println("=======================================");
            /*
                ROWNUM can be used with some restriction like we can use ROWNUM = 1 to get the first record
                But we can't use ROWNUM = 2 to get the second record or any other records. We have to use
                relation operator to get the bunch of records.
            */
            resultSet = statement.executeQuery("Select ROWNUM, E.* From Emp E Where ROWNUM = 1");
            while(resultSet.next()){
                System.out.println(resultSet.getInt(1)+" | "+resultSet.getInt(2)+" | "+resultSet.getString(3)+" | "+
                        resultSet.getInt(4) + " | "+resultSet.getString(5));
            }
            System.out.println("=======================================");
            resultSet = statement.executeQuery("Select ROWNUM, E.* From Emp E Where ROWNUM <= 5");
            while(resultSet.next()){
                System.out.println(resultSet.getInt(1)+" | "+resultSet.getInt(2)+" | "+resultSet.getString(3)+" | "+
                        resultSet.getInt(4) + " | "+resultSet.getString(5));
            }
            System.out.println("=======================================");
            resultSet = statement.executeQuery("Select ROWNUM, E.* From Emp E Where ROWNUM < 8");
            while(resultSet.next()){
                System.out.println(resultSet.getInt(1)+" | "+resultSet.getInt(2)+" | "+resultSet.getString(3)+" | "+
                        resultSet.getInt(4) + " | "+resultSet.getString(5));
            }
        }catch(SQLException sqlException){
            throw new RuntimeException(sqlException);
        }
    }
}
