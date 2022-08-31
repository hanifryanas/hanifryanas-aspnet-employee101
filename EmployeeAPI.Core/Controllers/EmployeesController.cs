using EmployeeAPI.Core.Models;
using EmployeeAPI.Core.Repositories;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace EmployeeAPI.Core.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmployeesController : ControllerBase
    {
        private readonly IEmployeeRepository _employeeRepository;
        public EmployeesController(IEmployeeRepository employeeRepository) => _employeeRepository = employeeRepository;
        // GET: api/<EmployeesController>
        [HttpGet]
        public async Task<IActionResult> GetEmployees()
        {
            var employees = await _employeeRepository.GetAllEmployees();
            if (employees == null)
            {
                return NotFound("No employees found");
            }
            return Ok(employees);
        }

        // GET api/<EmployeesController>/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetEmployee(int id)
        {
            var employee = await _employeeRepository.GetEmployeeById(id);
            if (employee == null)
            {
                return NotFound("No employee found");
            }
            return Ok(employee);
        }

        // POST api/<EmployeesController>
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] Employee employee)
        {
            var newEmployee = await _employeeRepository.AddEmployee(employee);
            if (newEmployee == null)
            {
                return BadRequest("Employee not added");
            }
            return CreatedAtAction(nameof(GetEmployee), new { id = newEmployee.Id }, newEmployee);
        }

        // PUT api/<EmployeesController>/5
        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, [FromBody] Employee employee)
        {
           var updatedEmployee = await _employeeRepository.UpdateEmployee(id, employee);
            if (updatedEmployee == null)
            {
                return NotFound("Employee not found");
            }
            return Ok(updatedEmployee);
        }

        // DELETE api/<EmployeesController>/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var employee = await _employeeRepository.GetEmployeeById(id);
            if (employee == null)
            {
                return NotFound("Employee not found");
            }
            var deletedEmployee = await _employeeRepository.DeleteEmployee(id);
            if (deletedEmployee==null)
            {
                return Ok("Employee deleted");
            }
            return BadRequest("Employee is not deleted");
        }
    }
}
