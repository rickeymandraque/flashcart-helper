<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Settings
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
        Me.Clearsettings = New System.Windows.Forms.Button()
        Me.SaveBtn = New System.Windows.Forms.Button()
        Me.DstwoIsFlashedCHK = New System.Windows.Forms.CheckBox()
        Me.backbtn = New System.Windows.Forms.Button()
        Me.AdvFeatChk = New System.Windows.Forms.CheckBox()
        Me.SuspendLayout()
        '
        'Clearsettings
        '
        Me.Clearsettings.Location = New System.Drawing.Point(10, 247)
        Me.Clearsettings.Name = "Clearsettings"
        Me.Clearsettings.Size = New System.Drawing.Size(133, 23)
        Me.Clearsettings.TabIndex = 0
        Me.Clearsettings.Text = "Return to default settings"
        Me.Clearsettings.UseVisualStyleBackColor = True
        '
        'SaveBtn
        '
        Me.SaveBtn.Location = New System.Drawing.Point(149, 247)
        Me.SaveBtn.Name = "SaveBtn"
        Me.SaveBtn.Size = New System.Drawing.Size(89, 23)
        Me.SaveBtn.TabIndex = 1
        Me.SaveBtn.Text = "Save Settings"
        Me.SaveBtn.UseVisualStyleBackColor = True
        '
        'DstwoIsFlashedCHK
        '
        Me.DstwoIsFlashedCHK.AutoSize = True
        Me.DstwoIsFlashedCHK.Location = New System.Drawing.Point(10, 12)
        Me.DstwoIsFlashedCHK.Name = "DstwoIsFlashedCHK"
        Me.DstwoIsFlashedCHK.Size = New System.Drawing.Size(222, 17)
        Me.DstwoIsFlashedCHK.TabIndex = 2
        Me.DstwoIsFlashedCHK.Text = "Do not show DSTWO is flashed message"
        Me.DstwoIsFlashedCHK.UseVisualStyleBackColor = True
        '
        'backbtn
        '
        Me.backbtn.Location = New System.Drawing.Point(244, 247)
        Me.backbtn.Name = "backbtn"
        Me.backbtn.Size = New System.Drawing.Size(57, 23)
        Me.backbtn.TabIndex = 3
        Me.backbtn.Text = "Back"
        Me.backbtn.UseVisualStyleBackColor = True
        '
        'AdvFeatChk
        '
        Me.AdvFeatChk.AutoSize = True
        Me.AdvFeatChk.Location = New System.Drawing.Point(10, 36)
        Me.AdvFeatChk.Name = "AdvFeatChk"
        Me.AdvFeatChk.Size = New System.Drawing.Size(155, 17)
        Me.AdvFeatChk.TabIndex = 4
        Me.AdvFeatChk.Text = "Enable Advanced Features"
        Me.AdvFeatChk.UseVisualStyleBackColor = True
        '
        'Settings
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(310, 282)
        Me.Controls.Add(Me.AdvFeatChk)
        Me.Controls.Add(Me.backbtn)
        Me.Controls.Add(Me.DstwoIsFlashedCHK)
        Me.Controls.Add(Me.SaveBtn)
        Me.Controls.Add(Me.Clearsettings)
        Me.Name = "Settings"
        Me.Text = "Settings"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Clearsettings As System.Windows.Forms.Button
    Friend WithEvents SaveBtn As System.Windows.Forms.Button
    Friend WithEvents DstwoIsFlashedCHK As System.Windows.Forms.CheckBox
    Friend WithEvents backbtn As System.Windows.Forms.Button
    Friend WithEvents AdvFeatChk As System.Windows.Forms.CheckBox
End Class
