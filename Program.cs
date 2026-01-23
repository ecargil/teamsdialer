using System;
using System.Diagnostics;
using System.Text.RegularExpressions;
using System.Windows.Forms;
using System.IO;
using System.Drawing;
using Microsoft.Win32;

namespace TeamsDialer
{
    class Program
    {
        [STAThread]
        static void Main(string[] args)
        {
            if (args.Length == 0)
            {
                RegisterProtocol();
                ShowConfigDialog();
                return;
            }

            string url = args[0];
            
            // Remove tel: prefix
            string number = url.Replace("tel:", "").Replace("tel%3A", "");
            
            // Remove spaces, dashes, parentheses
            number = Regex.Replace(number, @"[\s\-\(\)]", "");
            
            // Get default prefix from registry
            string defaultPrefix = GetDefaultPrefix();
            
            // Add default prefix if no country code
            if (!number.StartsWith("+") && !number.StartsWith("00"))
            {
                number = defaultPrefix + number;
            }
            
            // Replace 00 with +
            if (number.StartsWith("00"))
            {
                number = "+" + number.Substring(2);
            }
            
            // Launch Teams
            string teamsUrl = "https://teams.microsoft.com/l/call/0/0?users=4%3A" + Uri.EscapeDataString(number);
            ProcessStartInfo psi = new ProcessStartInfo(teamsUrl);
            psi.UseShellExecute = true;
            Process.Start(psi);
        }
        
        static void RegisterProtocol()
        {
            try
            {
                string exePath = System.Reflection.Assembly.GetExecutingAssembly().Location;
                
                RegistryKey key = Registry.CurrentUser.CreateSubKey("Software\\Classes\\tel");
                key.SetValue("", "URL:tel Protocol");
                key.SetValue("URL Protocol", "");
                key.Close();
                
                key = Registry.CurrentUser.CreateSubKey("Software\\Classes\\tel\\shell\\open\\command");
                key.SetValue("", "\"" + exePath + "\" \"%1\"");
                key.Close();
                
                key = Registry.CurrentUser.CreateSubKey("Software\\TeamsDialer\\Capabilities");
                key.SetValue("ApplicationName", "Teams Dialer");
                key.SetValue("ApplicationDescription", "Dial phone numbers with Microsoft Teams");
                key.Close();
                
                key = Registry.CurrentUser.CreateSubKey("Software\\TeamsDialer\\Capabilities\\URLAssociations");
                key.SetValue("tel", "tel");
                key.Close();
                
                try
                {
                    Registry.CurrentUser.DeleteSubKeyTree("Software\\Microsoft\\Windows\\Shell\\Associations\\UrlAssociations\\tel\\UserChoice");
                }
                catch { }
            }
            catch { }
        }
        
        static string GetDefaultPrefix()
        {
            try
            {
                RegistryKey key = Registry.CurrentUser.OpenSubKey("Software\\TeamsDialer");
                if (key != null)
                {
                    string prefix = key.GetValue("DefaultPrefix") as string;
                    key.Close();
                    if (!string.IsNullOrEmpty(prefix))
                        return prefix;
                }
            }
            catch { }
            return "+34";
        }
        
        static void ShowConfigDialog()
        {
            Form form = new Form();
            form.Text = "TeamsDialer - Settings";
            form.Width = 300;
            form.Height = 210;
            form.StartPosition = FormStartPosition.CenterScreen;
            form.FormBorderStyle = FormBorderStyle.FixedDialog;
            form.MaximizeBox = false;
            
            try
            {
                string exePath = System.Reflection.Assembly.GetExecutingAssembly().Location;
                form.Icon = Icon.ExtractAssociatedIcon(exePath);
            }
            catch { }
            
            Label lblInfo = new Label();
            lblInfo.Text = "TeamsDialer registered for tel: links";
            lblInfo.Left = 40;
            lblInfo.Top = 10;
            lblInfo.Width = 220;
            lblInfo.ForeColor = Color.Green;
            form.Controls.Add(lblInfo);
            
            Label label = new Label();
            label.Text = "Default prefix:";
            label.Left = 20;
            label.Top = 40;
            label.Width = 120;
            form.Controls.Add(label);
            
            TextBox textBox = new TextBox();
            textBox.Text = GetDefaultPrefix();
            textBox.Left = 150;
            textBox.Top = 40;
            textBox.Width = 100;
            form.Controls.Add(textBox);
            
            Button btnSave = new Button();
            btnSave.Text = "Save";
            btnSave.Left = 100;
            btnSave.Top = 80;
            btnSave.Tag = new object[] { textBox, form };
            btnSave.Click += new EventHandler(BtnSave_Click);
            form.Controls.Add(btnSave);
            
            LinkLabel linkGithub = new LinkLabel();
            linkGithub.Text = "GitHub: ecargil";
            linkGithub.Left = 85;
            linkGithub.Top = 120;
            linkGithub.Width = 120;
            linkGithub.LinkClicked += new LinkLabelLinkClickedEventHandler(LinkGithub_Click);
            form.Controls.Add(linkGithub);
            
            Application.Run(form);
        }
        
        static void LinkGithub_Click(object sender, LinkLabelLinkClickedEventArgs e)
        {
            try
            {
                ProcessStartInfo psi = new ProcessStartInfo("https://github.com/ecargil");
                psi.UseShellExecute = true;
                Process.Start(psi);
            }
            catch { }
        }
        
        static void BtnSave_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            object[] data = (object[])btn.Tag;
            TextBox textBox = (TextBox)data[0];
            Form form = (Form)data[1];
            
            try
            {
                RegistryKey key = Registry.CurrentUser.CreateSubKey("Software\\TeamsDialer");
                key.SetValue("DefaultPrefix", textBox.Text);
                key.Close();
                MessageBox.Show("Settings saved", "TeamsDialer");
                form.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message, "TeamsDialer");
            }
        }
    }
}
