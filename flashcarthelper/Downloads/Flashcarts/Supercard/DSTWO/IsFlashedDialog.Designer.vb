<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class IsFlashedDialog
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
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Yes = New System.Windows.Forms.Button()
        Me.No = New System.Windows.Forms.Button()
        Me.CheckBox1 = New System.Windows.Forms.CheckBox()
        Me.Help = New System.Windows.Forms.ToolTip(Me.components)
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(12, 9)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(128, 13)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "Is your DSTWO Flashed?"
        Me.Help.SetToolTip(Me.Label1, "If you are setting up a brand new DSTWO, choose No")
        '
        'Yes
        '
        Me.Yes.Location = New System.Drawing.Point(15, 67)
        Me.Yes.Name = "Yes"
        Me.Yes.Size = New System.Drawing.Size(76, 23)
        Me.Yes.TabIndex = 1
        Me.Yes.Text = "Yes"
        Me.Yes.UseVisualStyleBackColor = True
        '
        'No
        '
        Me.No.Location = New System.Drawing.Point(97, 67)
        Me.No.Name = "No"
        Me.No.Size = New System.Drawing.Size(76, 23)
        Me.No.TabIndex = 2
        Me.No.Text = "No"
        Me.No.UseVisualStyleBackColor = True
        '
        'CheckBox1
        '
        Me.CheckBox1.AutoSize = True
        Me.CheckBox1.Location = New System.Drawing.Point(6, 96)
        Me.CheckBox1.Name = "CheckBox1"
        Me.CheckBox1.Size = New System.Drawing.Size(179, 17)
        Me.CheckBox1.TabIndex = 3
        Me.CheckBox1.Text = "Do not show this message again"
        Me.CheckBox1.UseVisualStyleBackColor = True
        '
        'IsFlashedDialog
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(188, 120)
        Me.Controls.Add(Me.CheckBox1)
        Me.Controls.Add(Me.No)
        Me.Controls.Add(Me.Yes)
        Me.Controls.Add(Me.Label1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.Name = "IsFlashedDialog"
        Me.Text = "FlashcartHelper"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Help As System.Windows.Forms.ToolTip
    Friend WithEvents Yes As System.Windows.Forms.Button
    Friend WithEvents No As System.Windows.Forms.Button
    Friend WithEvents CheckBox1 As System.Windows.Forms.CheckBox
End Class
