using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace INTRO_USERS
{
    public partial class BrowsePage : Form
    {
        public BrowsePage()
        {
            InitializeComponent();
            string customerQuery = "SELECT Email FROM Customer";
            string branchQuery = "SELECT BranchName FROM Branch";
            SQL.editComboBoxItems(comboBoxCustomer, customerQuery);
            SQL.editComboBoxItems(comboBoxBranch, branchQuery);
        }

        private void buttonSearch_Click(object sender, EventArgs e)
        {
            string customerEmail = comboBoxCustomer.SelectedItem?.ToString() ?? "";
            string branchName = comboBoxBranch.SelectedItem?.ToString() ?? "";
            string query = "SELECT * FROM Rental WHERE CustomerEmail LIKE @customerEmail";

            if (!string.IsNullOrEmpty(branchName))
            {
                query += " AND BranchName LIKE @branchName";
            }

            SqlCommand cmd = new SqlCommand(query, SQL.con);
            cmd.Parameters.AddWithValue("@customerEmail", "%" + customerEmail + "%");
            if (!string.IsNullOrEmpty(branchName))
            {
                cmd.Parameters.AddWithValue("@branchName", "%" + branchName + "%");
            }

            listBoxDisplay.Items.Clear();
            try
            {
                SQL.selectQuery(cmd);
                if (SQL.read.HasRows)
                {
                    while (SQL.read.Read())
                    {
                        listBoxDisplay.Items.Add($"{SQL.read["RentalID"]}, {SQL.read["CustomerEmail"]}, {SQL.read["BranchName"]}, {SQL.read["startTime"]}");
                    }
                }
                else
                {
                    listBoxDisplay.Items.Add("No rental records found.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error in querying database: {ex.Message}");
            }
            finally
            {
                SQL.con.Close();
            }
        }

        private void buttonClear_Click(object sender, EventArgs e)
        {
            comboBoxCustomer.SelectedIndex = -1;
            comboBoxBranch.SelectedIndex = -1;
            listBoxDisplay.Items.Clear();
        }

        private void buttonLogin_Click(object sender, EventArgs e)
        {
            Hide();
            LoginPage login = new LoginPage();
            login.ShowDialog();
            Close();
        }

        private void buttonBook_Click(object sender, EventArgs e)
        {
            string customerEmail = comboBoxCustomer.SelectedItem?.ToString() ?? "";
            string branchName = comboBoxBranch.SelectedItem?.ToString() ?? "";
            DateTime startTime = dateTimePickerStart.Value;
            string query = "INSERT INTO Rental (CustomerEmail, BranchName, startTime) VALUES (@customerEmail, @branchName, @startTime)";
            SqlCommand cmd = new SqlCommand(query, SQL.con);
            cmd.Parameters.AddWithValue("@customerEmail", customerEmail);
            cmd.Parameters.AddWithValue("@branchName", branchName);
            cmd.Parameters.AddWithValue("@startTime", startTime);
            try
            {
                SQL.executeQuery(cmd);
                MessageBox.Show("Booking successful!");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error booking equipment: {ex.Message}");
            }
        }

        private void buttonReturn_Click(object sender, EventArgs e)
        {
            int rentalID = int.Parse(textBoxRentalID.Text);
            DateTime returnTime = dateTimePickerReturn.Value;
            string query = "UPDATE Rental SET returnTime = @returnTime WHERE RentalID = @rentalID";
            SqlCommand cmd = new SqlCommand(query, SQL.con);
            cmd.Parameters.AddWithValue("@returnTime", returnTime);
            cmd.Parameters.AddWithValue("@rentalID", rentalID);
            try
            {
                SQL.executeQuery(cmd);
                MessageBox.Show("Return processed successfully!");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error processing return: {ex.Message}");
            }
        }

        private void buttonSummary_Click(object sender, EventArgs e)
        {
            string query = "SELECT BranchName, COUNT(DISTINCT CustomerEmail) AS UniqueCustomers FROM Rental GROUP BY BranchName";
            SqlCommand cmd = new SqlCommand(query, SQL.con);
            listBoxDisplay.Items.Clear();
            try
            {
                SQL.selectQuery(cmd);
                if (SQL.read.HasRows)
                {
                    while (SQL.read.Read())
                    {
                        listBoxDisplay.Items.Add($"{SQL.read["BranchName"]}: {SQL.read["UniqueCustomers"]} unique customers");
                    }
                }
                else
                {
                    listBoxDisplay.Items.Add("No data found.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error generating summary: {ex.Message}");
            }
        }
    }
}



