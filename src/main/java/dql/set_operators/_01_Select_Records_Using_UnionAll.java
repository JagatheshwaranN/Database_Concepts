package dql.set_operators;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class _01_Select_Records_Using_UnionAll {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try (Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")) {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("Select * From Cust_Dtls_Br1 UNION ALL Select * From Cust_Dtls_Br2 UNION ALL Select * From Cust_Dtls_Br3");
            while (resultSet.next()) {
                System.out.println(resultSet.getInt(1)+" | "+resultSet.getString(2)+" | "+resultSet.getString(3)+" | "+
                        resultSet.getLong(4)+" | "+resultSet.getString(5));
            }
        }catch(SQLException sqlException){
                throw new RuntimeException(sqlException);
        }
    }
}