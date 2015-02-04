namespace Win_Congres
{
    partial class FrmMenu
    {
        /// <summary>
        /// Variable nécessaire au concepteur.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Nettoyage des ressources utilisées.
        /// </summary>
        /// <param name="disposing">true si les ressources managées doivent être supprimées ; sinon, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Code généré par le Concepteur Windows Form

        /// <summary>
        /// Méthode requise pour la prise en charge du concepteur - ne modifiez pas
        /// le contenu de cette méthode avec l'éditeur de code.
        /// </summary>
        private void InitializeComponent()
        {
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.sessionToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.acivitéToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.thêmeToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.intervenantToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ligueToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.congressisteToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.hôtelToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.menuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.sessionToolStripMenuItem,
            this.acivitéToolStripMenuItem,
            this.thêmeToolStripMenuItem,
            this.intervenantToolStripMenuItem,
            this.ligueToolStripMenuItem,
            this.congressisteToolStripMenuItem,
            this.hôtelToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(676, 24);
            this.menuStrip1.TabIndex = 0;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // sessionToolStripMenuItem
            // 
            this.sessionToolStripMenuItem.Name = "sessionToolStripMenuItem";
            this.sessionToolStripMenuItem.Size = new System.Drawing.Size(58, 20);
            this.sessionToolStripMenuItem.Text = "Session";
            // 
            // acivitéToolStripMenuItem
            // 
            this.acivitéToolStripMenuItem.Name = "acivitéToolStripMenuItem";
            this.acivitéToolStripMenuItem.Size = new System.Drawing.Size(55, 20);
            this.acivitéToolStripMenuItem.Text = "Acivité";
            // 
            // thêmeToolStripMenuItem
            // 
            this.thêmeToolStripMenuItem.Name = "thêmeToolStripMenuItem";
            this.thêmeToolStripMenuItem.Size = new System.Drawing.Size(56, 20);
            this.thêmeToolStripMenuItem.Text = "Thême";
            // 
            // intervenantToolStripMenuItem
            // 
            this.intervenantToolStripMenuItem.Name = "intervenantToolStripMenuItem";
            this.intervenantToolStripMenuItem.Size = new System.Drawing.Size(79, 20);
            this.intervenantToolStripMenuItem.Text = "Intervenant";
            // 
            // ligueToolStripMenuItem
            // 
            this.ligueToolStripMenuItem.Name = "ligueToolStripMenuItem";
            this.ligueToolStripMenuItem.Size = new System.Drawing.Size(48, 20);
            this.ligueToolStripMenuItem.Text = "Ligue";
            // 
            // congressisteToolStripMenuItem
            // 
            this.congressisteToolStripMenuItem.Name = "congressisteToolStripMenuItem";
            this.congressisteToolStripMenuItem.Size = new System.Drawing.Size(86, 20);
            this.congressisteToolStripMenuItem.Text = "Congressiste";
            // 
            // hôtelToolStripMenuItem
            // 
            this.hôtelToolStripMenuItem.Name = "hôtelToolStripMenuItem";
            this.hôtelToolStripMenuItem.Size = new System.Drawing.Size(48, 20);
            this.hôtelToolStripMenuItem.Text = "Hôtel";
            // 
            // FrmMenu
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(676, 261);
            this.Controls.Add(this.menuStrip1);
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "FrmMenu";
            this.Text = "Gestion des Congrès";
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem sessionToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem acivitéToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem thêmeToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem intervenantToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem ligueToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem congressisteToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem hôtelToolStripMenuItem;
    }
}

