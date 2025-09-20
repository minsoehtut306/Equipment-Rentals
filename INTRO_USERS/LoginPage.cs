using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace INTRO_USERS
{
    //Name:
    //Student ID:

    public partial class LoginPage : Form
    {
        /// <summary>
        /// This is the first method called when the program form loads.
        /// </summary>
        public LoginPage()
        {
            InitializeComponent();
            //This line of code allows us to obscure the password visually and limit the max chars in textbox
            textBoxPassword.PasswordChar = '*';     //password character to hide password characters
            textBoxPassword.MaxLength = 20;         //max textbox character count
        }


        /// <summary>
        /// Clicked when user decides they are ready to log in, 
        /// Will get username and password, use that to query database and check that username and password are correct.
        /// A message box will be used to state whether or not we logged in successfully
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void buttonLogin_Click(object sender, EventArgs e)
        {
            //Variables to be used: 1x bool, 4x string
            bool loggedIn = false;
            string username = "", firstname = "", lastname = "", password = "";

            //check if boxes are empty, the Trim removes white space in text from either side
            if ("".Equals(textBoxUserName.Text.Trim()) || "".Equals(textBoxPassword.Text.Trim()))
            {
                MessageBox.Show("Please make sure you enter a Username and Password");
                return;
            }

            //(1) GET the username and password from the text boxes, is good to put them in a try catch
            try
            {
                //Get the username and password and store as string
                username = textBoxUserName.Text.Trim();
                password = textBoxPassword.Text.Trim();
            }
            catch
            {
                //Error message, more useful when you are storing numbers etc. into the database.
                MessageBox.Show("Username or Password given is in an incorrect format.");
                return;
            }

            //(2) SELECT statement getting all data from users, i.e. SELECT * FROM Users
            //Use a select query on the users table
            SQL.selectQuery("SELECT * from Users");


            //(3) IF it returns some data, THEN check each username and password combination, ELSE There are no registered users
            
            //If there exists at least one User
            if (SQL.read.HasRows)
            {
                //cycle through all users checking if the username exists and if the password matches
            while (SQL.read.Read())
                {
                    //SQL.read[i]: i=0 is UserName ... i=4 is Password
                    if (username.Equals(SQL.read[0].ToString()) &&
                    password.Equals(SQL.read[4].ToString()))
                    {
                        //Username and Password correct, get fname, lname to display
                        loggedIn = true;
                        firstname = SQL.read[1].ToString();
                        lastname = SQL.read[3].ToString();
                        break; //stops the while loop since they have logged in
                    }
                }
            }
            else
            {
                //Error message to show that no users have been registered
                MessageBox.Show("No users have been registered.");
                return;
            }

            //if logged in display a success message
            if (loggedIn)
            {
                //message stating we logged in good
                MessageBox.Show("Successfully logged in as: " + firstname + " " + lastname);
                initialiseTextBoxes();
            }
            else
            {
                //message stating we couldn't log in
                MessageBox.Show("Login attempt unsuccessful! Please check details");
                textBoxUserName.Focus();
                return;
            }

        }


        /// <summary>
        /// When clicked on switch page to the register page
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void labelRegister_Click(object sender, EventArgs e)
        {
            //Hides the login page form from user
            this.Hide();
            //Create a Register Page object to change to
            RegisterPage register = new RegisterPage();
            //show the register page
            register.ShowDialog();
            //close the login page we are currently on
            this.Close();
        }

        /// <summary>
        /// Clears the text boxes on the page focuses on top one
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void buttonClearAll_Click(object sender, EventArgs e)
        {
            initialiseTextBoxes();
        }

        /// <summary>
        /// Initialises all textboxes to blank text
        /// Re focus to first text box
        /// </summary>
        public void initialiseTextBoxes()
        {
            //goes through and clears all of the textboxes
            foreach (Control c in this.Controls)
            {
                if (c is TextBox)
                {
                    (c as TextBox).Clear();
                }
            }
            //makes next place user types the text box
            textBoxUserName.Focus();
        }

        /// <summary>
        /// When the mouse hovers over the top of the register button
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void labelRegister_MouseHover(object sender, EventArgs e)
        {
            //Changes the colour of the label
            labelRegister.ForeColor = Color.Blue;
        }

        private void labelRegister_MouseLeave(object sender, EventArgs e)
        {
            //Changes the colour of the label
            labelRegister.ForeColor = Color.Black;
        }

        /// <summary>
        /// Takes us to the browse session page
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void buttonBrowse_Click(object sender, EventArgs e)
        {
            //you have seen this plenty of times, I hope it is self explainatory now
            Hide();
            BrowsePage browsePage = new BrowsePage();
            browsePage.ShowDialog();
            Close();
        }
    }
}
