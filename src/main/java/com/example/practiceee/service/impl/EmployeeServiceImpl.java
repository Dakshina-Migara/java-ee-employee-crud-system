package com.example.practiceee.service.impl;

import com.example.practiceee.dto.EmployeeDto;
import com.example.practiceee.service.EmployeeService;

import java.util.List;

public class EmployeeServiceImpl implements EmployeeService {
    @Override
    public EmployeeDto saveEmployee(EmployeeDto employeeDto) {
        return null;
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
