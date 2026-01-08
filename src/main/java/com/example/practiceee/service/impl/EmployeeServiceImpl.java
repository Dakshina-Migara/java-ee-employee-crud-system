package com.example.practiceee.service.impl;

import com.example.practiceee.db.DBConnection;
import com.example.practiceee.dto.EmployeeDto;
import com.example.practiceee.service.EmployeeService;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

public class EmployeeServiceImpl implements EmployeeService {
    @Override
    public EmployeeDto saveEmployee(EmployeeDto employeeDto) {
        String sql = "INSERT INTO employee(employee_nic, employee_name, employee_age, employee_salary) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, employeeDto.getNic());
            pst.setString(2, employeeDto.getName());
            pst.setInt(3, employeeDto.getAge());
            pst.setDouble(4, employeeDto.getSalary());

            int affectedRows = pst.executeUpdate();

            if (affectedRows > 0) {
                return employeeDto;
            } else {
                return null;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public EmployeeDto updateEmployee(EmployeeDto employeeDto) {
        return null;
    }

    @Override
    public boolean deleteEmployee(String nic) {
        return false;
    }

    @Override
    public List<EmployeeDto> getAllEmployees() {
        return List.of();
    }

    @Override
    public List<EmployeeDto> searchEmployees(String nic) {
        return List.of();
    }
}
