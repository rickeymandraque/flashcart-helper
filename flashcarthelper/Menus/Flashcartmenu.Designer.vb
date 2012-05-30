<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Flashcartmenu
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Me.AKBtn = New System.Windows.Forms.Button()
        Me.CheckBox1 = New System.Windows.Forms.CheckBox()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.Path = New System.Windows.Forms.TextBox()
        Me.R4Btn = New System.Windows.Forms.Button()
        Me.AKtip = New System.Windows.Forms.ToolTip(Me.components)
        Me.R4tip = New System.Windows.Forms.ToolTip(Me.components)
        Me.FlashcartBox = New System.Windows.Forms.PictureBox()
        Me.DS2btn = New System.Windows.Forms.Button()
        Me.DS2tip = New System.Windows.Forms.ToolTip(Me.components)
        Me.Backbtn = New System.Windows.Forms.Button()
        Me.ExtPathDialog = New System.Windows.Forms.FolderBrowserDialog()
        CType(Me.FlashcartBox, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'AKBtn
        '
        Me.AKBtn.Location = New System.Drawing.Point(12, 36)
        Me.AKBtn.Name = "AKBtn"
        Me.AKBtn.Size = New System.Drawing.Size(348, 64)
        Me.AKBtn.TabIndex = 0
        Me.AKBtn.Text = "Acekard"
        Me.AKBtn.UseVisualStyleBackColor = True
        '
        'CheckBox1
        '
        Me.CheckBox1.AutoSize = True
        Me.CheckBox1.Location = New System.Drawing.Point(12, 530)
        Me.CheckBox1.Name = "CheckBox1"
        Me.CheckBox1.Size = New System.Drawing.Size(125, 17)
        Me.CheckBox1.TabIndex = 1
        Me.CheckBox1.Text = "Download Moonshell"
        Me.CheckBox1.UseVisualStyleBackColor = True
        '
        'Button2
        '
        Me.Button2.Location = New System.Drawing.Point(143, 525)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(133, 23)
        Me.Button2.TabIndex = 2
        Me.Button2.Text = "Choose Download Path"
        Me.Button2.UseVisualStyleBackColor = True
        '
        'Path
        '
        Me.Path.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest
        Me.Path.Enabled = False
        Me.Path.ForeColor = System.Drawing.SystemColors.InfoText
        Me.Path.HideSelection = False
        Me.Path.Location = New System.Drawing.Point(282, 526)
        Me.Path.Name = "Path"
        Me.Path.Size = New System.Drawing.Size(304, 20)
        Me.Path.TabIndex = 3
        '
        'R4Btn
        '
        Me.R4Btn.Location = New System.Drawing.Point(12, 106)
        Me.R4Btn.Name = "R4Btn"
        Me.R4Btn.Size = New System.Drawing.Size(348, 64)
        Me.R4Btn.TabIndex = 4
        Me.R4Btn.Text = "R4"
        Me.R4Btn.UseVisualStyleBackColor = True
        '
        'AKtip
        '
        '
        'R4tip
        '
        '
        'FlashcartBox
        '
        Me.FlashcartBox.Location = New System.Drawing.Point(387, 40)
        Me.FlashcartBox.Name = "FlashcartBox"
        Me.FlashcartBox.Size = New System.Drawing.Size(199, 186)
        Me.FlashcartBox.TabIndex = 5
        Me.FlashcartBox.TabStop = False
        '
        'DS2btn
        '
        Me.DS2btn.Location = New System.Drawing.Point(12, 176)
        Me.DS2btn.Name = "DS2btn"
        Me.DS2btn.Size = New System.Drawing.Size(348, 64)
        Me.DS2btn.TabIndex = 6
        Me.DS2btn.Text = "DSTWO"
        Me.DS2btn.UseVisualStyleBackColor = True
        '
        'DS2tip
        '
        '
        'Backbtn
        '
        Me.Backbtn.Location = New System.Drawing.Point(12, 7)
        Me.Backbtn.Name = "Backbtn"
        Me.Backbtn.Size = New System.Drawing.Size(75, 23)
        Me.Backbtn.TabIndex = 7
        Me.Backbtn.Text = "Back"
        Me.Backbtn.UseVisualStyleBackColor = True
        '
        'Flashcartmenu
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(598, 559)
        Me.Controls.Add(Me.Backbtn)
        Me.Controls.Add(Me.DS2btn)
        Me.Controls.Add(Me.FlashcartBox)
        Me.Controls.Add(Me.R4Btn)
        Me.Controls.Add(Me.Path)
        Me.Controls.Add(Me.Button2)
        Me.Controls.Add(Me.CheckBox1)
        Me.Controls.Add(Me.AKBtn)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Name = "Flashcartmenu"
        Me.Text = "FlashcartHelper"
        CType(Me.FlashcartBox, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents AKBtn As System.Windows.Forms.Button
    Friend WithEvents CheckBox1 As System.Windows.Forms.CheckBox
    Friend WithEvents Button2 As System.Windows.Forms.Button
    Friend WithEvents Path As System.Windows.Forms.TextBox
    Friend WithEvents R4Btn As System.Windows.Forms.Button
    Friend WithEvents AKtip As System.Windows.Forms.ToolTip
    Friend WithEvents R4tip As System.Windows.Forms.ToolTip
    Friend WithEvents FlashcartBox As System.Windows.Forms.PictureBox
    Friend WithEvents DS2btn As System.Windows.Forms.Button
    Friend WithEvents DS2tip As System.Windows.Forms.ToolTip
    Friend WithEvents Backbtn As System.Windows.Forms.Button
    Friend WithEvents ExtPathDialog As System.Windows.Forms.FolderBrowserDialog
End Class
