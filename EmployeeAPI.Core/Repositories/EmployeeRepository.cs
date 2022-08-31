using Dapper;
using EmployeeAPI.Core.Contexts;
using EmployeeAPI.Core.Models;
using System.Data;

namespace EmployeeAPI.Core.Repositories
{
    public class EmployeeRepository : IEmployeeRepository
    {
        private readonly DbContext _dbContext;
        public EmployeeRepository(DbContext dbContext)
        {
            _dbContext = dbContext;
        }
        public async Task <IEnumerable<EmployeeWithId>> GetAllEmployees()
        {
            return await _dbContext.Connection.QueryAsync<EmployeeWithId>("GetAllEmployees", commandType: CommandType.StoredProcedure);
        }
        public async Task<EmployeeWithId> GetEmployeeById(int id)
        {
            return await _dbContext.Connection.QueryFirstOrDefaultAsync<EmployeeWithId>("GetSelectedEmployee", new { id }, commandType: CommandType.StoredProcedure);
        }
        public async Task<EmployeeWithId> AddEmployee(Employee employee)
        {
            var newId = await _dbContext.Connection.QuerySingleAsync<int>("INSERT INTO Employees (Name, Address, Phone) VALUES (@name, @address, @phone)" + "SELECT CAST(SCOPE_IDENTITY() AS int)",
                new { name = employee.Name, address = employee.Address, phone = employee.Phone });
            return await GetEmployeeById(newId);
        }
        public async Task<EmployeeWithId> UpdateEmployee(int id, Employee employee)
        {
            _dbContext.Connection.Execute("UpdateEmployee", new { id = id, name = employee.Name, address = employee.Address, phone = employee.Phone }, commandType: CommandType.StoredProcedure);
            return await GetEmployeeById(id);
        }
        public async Task<EmployeeWithId> DeleteEmployee(int id)
        {
            _dbContext.Connection.Execute("DeleteEmployee", new { id }, commandType: CommandType.StoredProcedure);
            return await GetEmployeeById(id);
        }
    }    
}
