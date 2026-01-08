package com.example.practiceee.service;

import com.example.practiceee.dto.EmployeeDto;

import java.util.List;

public interface EmployeeService {
    EmployeeDto saveEmployee(EmployeeDto employeeDto);
    EmployeeDto updateEmployee(EmployeeDto employeeDto);
    boolean deleteEmployee(String nic);
    List<EmployeeDto> getAllEmployees();
    List<EmployeeDto> searchEmployees(String nic);
}
