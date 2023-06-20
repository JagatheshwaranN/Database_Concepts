package dml.non_select;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class _05_InsertMultipleRecords {

    public static void main(String[] args) throws ClassNotFoundException {

        Class.forName("oracle.jdbc.driver.OracleDriver");
        try(Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XEPDB1", "JAGA", "ALLOWME")) {
            Statement statement = connection.createStatement();
            int counter = 0;
            while(true){
                Scanner scanner = new Scanner(System.in);
                System.out.println("Please enter the grocery number");
                int gcNumber = scanner.nextInt();
                System.out.println("Please enter the grocery name");
                String gcName = scanner.next();
                System.out.println("Please enter the grocery quantity");
                String gcQty = scanner.next();
                System.out.println("Please enter the grocery price");
                int gcPrice = scanner.nextInt();
                String insertQuery = String.format("Insert Into Groceries values(%d, '%s', '%s', %d)", gcNumber, gcName, gcQty, gcPrice);
                statement.executeUpdate(insertQuery);
                counter++;
                System.out.println("Do you want to insert one more record [Y/N]");
                String option = scanner.next();
                if(option.equalsIgnoreCase("N")){
                   break;
                }
            }
            System.out.println("Number of rows created : "+counter);
        } catch (SQLException sqlException) {
            throw new RuntimeException(sqlException);
        }
    }
}
