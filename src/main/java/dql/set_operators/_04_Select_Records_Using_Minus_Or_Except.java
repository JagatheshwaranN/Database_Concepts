package dql.set_operators;

import java.sql.*;

public class _04_Select_Records_Using_Minus_Or_Except {

    static ResultSet resultSet;
    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try (Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")) {
            Statement statement = connection.createStatement();
            resultSet = statement.executeQuery("Select * From Cust_Dtls_Br1 MINUS (Select * From Cust_Dtls_Br2 UNION ALL Select * From Cust_Dtls_Br3)");
            while (resultSet.next()) {
                System.out.println(resultSet.getInt(1)+" | "+resultSet.getString(2)+" | "+resultSet.getString(3)+" | "+
                        resultSet.getLong(4)+" | "+resultSet.getString(5));
            }
            System.out.println("======================================");
            resultSet = statement.executeQuery("Select * From Cust_Dtls_Br1 EXCEPT (Select * From Cust_Dtls_Br2 UNION ALL Select * From Cust_Dtls_Br3)");
            while (resultSet.next()) {
                System.out.println(resultSet.getInt(1)+" | "+resultSet.getString(2)+" | "+resultSet.getString(3)+" | "+
                        resultSet.getLong(4)+" | "+resultSet.getString(5));
            }
        }catch(SQLException sqlException){
                throw new RuntimeException(sqlException);
        }
    }
}