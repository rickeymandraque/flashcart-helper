<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Cheatmenu
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
        Me.Button1 = New System.Windows.Forms.Button()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.Button3 = New System.Windows.Forms.Button()
        Me.Path = New System.Windows.Forms.TextBox()
        Me.savebtn = New System.Windows.Forms.Button()
        Me.ExtPathDialog = New System.Windows.Forms.FolderBrowserDialog()
        Me.Button4 = New System.Windows.Forms.Button()
        Me.ChnglogBtn = New System.Windows.Forms.Button()
        Me.SuspendLayout()
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(18, 13)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(249, 37)
        Me.Button1.TabIndex = 0
        Me.Button1.Text = "USRcheat.dat (Generic)"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'Button2
        '
        Me.Button2.Location = New System.Drawing.Point(18, 113)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(249, 37)
        Me.Button2.TabIndex = 1
        Me.Button2.Text = "Edge/iEdge"
        Me.Button2.UseVisualStyleBackColor = True
        '
        'Button3
        '
        Me.Button3.Location = New System.Drawing.Point(18, 63)
        Me.Button3.Name = "Button3"
        Me.Button3.Size = New System.Drawing.Size(249, 37)
        Me.Button3.TabIndex = 2
        Me.Button3.Text = "CycloDS"
        Me.Button3.UseVisualStyleBackColor = True
        '
        'Path
        '
        Me.Path.Enabled = False
        Me.Path.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.Path.Location = New System.Drawing.Point(18, 232)
        Me.Path.Name = "Path"
        Me.Path.ReadOnly = True
        Me.Path.Size = New System.Drawing.Size(249, 20)
        Me.Path.TabIndex = 3
        '
        'savebtn
        '
        Me.savebtn.Location = New System.Drawing.Point(18, 204)
        Me.savebtn.Name = "savebtn"
        Me.savebtn.Size = New System.Drawing.Size(150, 25)
        Me.savebtn.TabIndex = 4
        Me.savebtn.Text = "Choose Download Location"
        Me.savebtn.UseVisualStyleBackColor = True
        '
        'Button4
        '
        Me.Button4.Location = New System.Drawing.Point(177, 204)
        Me.Button4.Name = "Button4"
        Me.Button4.Size = New System.Drawing.Size(89, 25)
        Me.Button4.TabIndex = 5
        Me.Button4.Text = "Back"
        Me.Button4.UseVisualStyleBackColor = True
        '
        'ChnglogBtn
        '
        Me.ChnglogBtn.Location = New System.Drawing.Point(18, 176)
        Me.ChnglogBtn.Name = "ChnglogBtn"
        Me.ChnglogBtn.Size = New System.Drawing.Size(249, 22)
        Me.ChnglogBtn.TabIndex = 6
        Me.ChnglogBtn.Text = "View Cheat DB Changelog"
        Me.ChnglogBtn.UseVisualStyleBackColor = True
        '
        'Cheatmenu
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(284, 264)
        Me.Controls.Add(Me.ChnglogBtn)
        Me.Controls.Add(Me.Button4)
        Me.Controls.Add(Me.savebtn)
        Me.Controls.Add(Me.Path)
        Me.Controls.Add(Me.Button3)
        Me.Controls.Add(Me.Button2)
        Me.Controls.Add(Me.Button1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Fixed3D
        Me.MaximizeBox = False
        Me.Name = "Cheatmenu"
        Me.Text = "FlashcartHelper"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents Button2 As System.Windows.Forms.Button
    Friend WithEvents Button3 As System.Windows.Forms.Button
    Friend WithEvents Path As System.Windows.Forms.TextBox
    Friend WithEvents savebtn As System.Windows.Forms.Button
    Friend WithEvents ExtPathDialog As System.Windows.Forms.FolderBrowserDialog
    Friend WithEvents Button4 As System.Windows.Forms.Button
    Friend WithEvents ChnglogBtn As System.Windows.Forms.Button
End Class
