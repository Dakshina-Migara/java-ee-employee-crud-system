<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Management System</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }

        .card {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<div class="container-fluid mt-4">
    <div class="row">

        <!-- ================= LEFT SIDE : SAVE EMPLOYEE ================= -->
        <div class="col-md-4">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Save Employee</h5>
                </div>

                <div class="card-body">
                    <form id="saveEmployeeForm">

                        <div class="mb-3">
                            <label class="form-label">NIC</label>
                            <input type="text" class="form-control" id="empNic" placeholder="Enter NIC">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Name</label>
                            <input type="text" class="form-control" id="empName" placeholder="Enter Name">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Age</label>
                            <input type="number" class="form-control" id="empAge" placeholder="Enter Age">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Salary</label>
                            <input type="number" class="form-control" id="empSalary" placeholder="Enter Salary">
                        </div>

                        <button type="button" class="btn btn-success w-100" onclick="saveEmployee()">
                            Save Employee
                        </button>

                    </form>
                </div>
            </div>
        </div>

        <!-- ================= RIGHT SIDE : SEARCH + TABLE ================= -->
        <div class="col-md-8">
            <div class="card shadow">
                <div class="card-header bg-dark text-white">
                    <h5 class="mb-0">Employee Details</h5>
                </div>

                <div class="card-body">

                    <!-- Search Bar -->
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="searchNic" placeholder="Search by NIC">
                        </div>
                        <div class="col-md-4">
                            <button type="button" class="btn btn-primary w-100" onclick="serachEmployee()">
                                Search
                            </button>
                        </div>
                    </div>

                    <!-- Employee Table -->
                    <table class="table table-bordered table-striped">
                        <thead class="table-secondary">
                        <tr>
                            <th>Name</th>
                            <th>NIC</th>
                            <th>Age</th>
                            <th>Salary</th>
                            <th>Action</th>
                        </tr>
                        </thead>

                        <tbody id="employeeTableBody">

                        <!-- ===== DUMMY DATA START ===== -->
                        <tr>
                            <td>Kamal Perera</td>
                            <td>991234567V</td>
                            <td>25</td>
                            <td>50000</td>
                            <td>
                                <button class="btn btn-warning btn-sm btn-update" data-bs-toggle="modal"
                                        data-bs-target="#updateModal">Update
                                </button>
                                <button class="btn btn-danger btn-sm btn-delete" data-bs-toggle="modal"
                                        data-bs-target="#deleteModal">Delete
                                </button>
                            </td>
                        </tr>

                        <tr>
                            <td>Nimal Silva</td>
                            <td>982345678V</td>
                            <td>30</td>
                            <td>65000</td>
                            <td>
                                <button class="btn btn-warning btn-sm btn-update" data-bs-toggle="modal"
                                        data-bs-target="#updateModal">Update
                                </button>
                                <button class="btn btn-danger btn-sm btn-delete" data-bs-toggle="modal"
                                        data-bs-target="#deleteModal">Delete
                                </button>
                            </td>
                        </tr>

                        <tr>
                            <td>Saman Jayasinghe</td>
                            <td>200012345678</td>
                            <td>28</td>
                            <td>72000</td>
                            <td>
                                <button class="btn btn-warning btn-sm btn-update" data-bs-toggle="modal"
                                        data-bs-target="#updateModal">Update
                                </button>
                                <button class="btn btn-danger btn-sm btn-delete" data-bs-toggle="modal"
                                        data-bs-target="#deleteModal">Delete
                                </button>
                            </td>
                        </tr>
                        <!-- ===== DUMMY DATA END ===== -->

                        </tbody>
                    </table>

                </div>
            </div>
        </div>

    </div>
</div>

<!-- ================= MODAL FOR UPDATE ================= -->
<div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-warning text-dark">
                <h5 class="modal-title" id="updateModalLabel">Update Employee</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <form id="updateEmployeeForm">
                    <div class="mb-3">
                        <label class="form-label">NIC</label>
                        <input type="text" class="form-control" id="updateEmpNic" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Name</label>
                        <input type="text" class="form-control" id="updateEmpName">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Age</label>
                        <input type="number" class="form-control" id="updateEmpAge">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Salary</label>
                        <input type="number" class="form-control" id="updateEmpSalary">
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-warning" onclick="updateEmployee()">Update</button>
            </div>
        </div>
    </div>
</div>

<!-- ================= MODAL FOR DELETE ================= -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="deleteModalLabel">Delete Employee</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <p>Are you sure you want to delete this employee?</p>
                <p><strong id="deleteEmpDetails"></strong></p>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-danger" onclick="deleteEmployee()">Delete</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS (required for modals) -->
<script>
    console.log("JS Loaded Successfully");
    getAllEmployee();

    //create the saveEmployee function
    function saveEmployee() {
        console.log("ethulata giya")
        const employee = {
            nic: document.getElementById('empNic').value,
            name: document.getElementById('empName').value,
            age: parseInt(document.getElementById('empAge').value),
            salary: parseFloat(document.getElementById('empSalary').value)
        };
        console.log(employee);

        fetch('http://localhost:8080/practice_ee_war_exploded/employee', {
            method: 'POST',
            body: JSON.stringify(employee),
            headers: {
                'Content-type': 'application/json; charset=UTF-8',
            },
        })
            .then((response) => response.json())
            .then(data => {
                alert("employee saved successfully!");
                getAllEmployee();
            })
            .catch(err => console.log("Error:", err));
    }

    // create the getAllEmployee function
    function getAllEmployee() {
        console.log("get all eka ethulata giya");

        fetch('http://localhost:8080/practice_ee_war_exploded/employee')
            .then(res => res.json())
            .then(data => {
                const tbody = document.getElementById('employeeTableBody');
                tbody.innerHTML = "";
                data.forEach(emp => {
                    const row = `<tr>
                                  <td>\${emp.nic}</td>
                                  <td>\${emp.name}</td>
                                  <td>\${emp.age}</td>
                                  <td>\${emp.salary}</td>
                           <td>
                                  <button class="btn btn-warning btn-sm btn-update" onclick="populateUpdateModal(\${emp.nic}, '\${emp.name}', \${emp.age}, \${emp.salary})">Update</button>
                                  <button class="btn btn-danger btn-sm btn-delete" onclick="populateDeleteModal(\${emp.nic})">Delete</button>
                           </td>
                                  </tr>`;
                    tbody.innerHTML += row;
                });
            })
            .catch(err => console.log(err));
        console.log("get all eken eliyata awa");
    }

    function searchEmployee() {

    }
</script>
</body>
</html>
