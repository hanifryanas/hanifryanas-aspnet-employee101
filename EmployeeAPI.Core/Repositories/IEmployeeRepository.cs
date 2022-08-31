using EmployeeAPI.Core.Models;

namespace EmployeeAPI.Core.Repositories
{
    public interface IEmployeeRepository
    {
        Task<IEnumerable<EmployeeWithId>> GetAllEmployees();
        Task<EmployeeWithId> GetEmployeeById(int id);
        Task<EmployeeWithId> AddEmployee(Employee employee);
        Task<EmployeeWithId> UpdateEmployee(int id, Employee employee);
        Task<EmployeeWithId> DeleteEmployee(int id);
    }
}