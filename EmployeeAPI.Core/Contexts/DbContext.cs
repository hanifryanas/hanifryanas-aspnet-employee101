using System.Data;
using System.Data.SqlClient;

namespace EmployeeAPI.Core.Contexts
{
    public class DbContext
    {
        private readonly IConfiguration _configuration;
        private readonly string _connectionString;

        public DbContext(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("SqlConnection");
        }

        public IDbConnection Connection => new SqlConnection(_connectionString);
    }
}
