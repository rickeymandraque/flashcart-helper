<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class DSWOMenu
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
        Me.FirmInst = New System.Windows.Forms.Button()
        Me.EOStip = New System.Windows.Forms.ToolTip(Me.components)
        Me.Plugins = New System.Windows.Forms.Button()
        Me.Backbtn = New System.Windows.Forms.Button()
        Me.SuspendLayout()
        '
        'FirmInst
        '
        Me.FirmInst.Location = New System.Drawing.Point(13, 13)
        Me.FirmInst.Name = "FirmInst"
        Me.FirmInst.Size = New System.Drawing.Size(259, 35)
        Me.FirmInst.TabIndex = 0
        Me.FirmInst.Text = "Install EOS"
        Me.EOStip.SetToolTip(Me.FirmInst, "EOS is the Firmware for the DSTWO")
        Me.FirmInst.UseVisualStyleBackColor = True
        '
        'Plugins
        '
        Me.Plugins.Location = New System.Drawing.Point(13, 54)
        Me.Plugins.Name = "Plugins"
        Me.Plugins.Size = New System.Drawing.Size(259, 26)
        Me.Plugins.TabIndex = 1
        Me.Plugins.Text = "Install Plugins"
        Me.EOStip.SetToolTip(Me.Plugins, "EOS is the Firmware for the DSTWO")
        Me.Plugins.UseVisualStyleBackColor = True
        '
        'Backbtn
        '
        Me.Backbtn.Location = New System.Drawing.Point(12, 228)
        Me.Backbtn.Name = "Backbtn"
        Me.Backbtn.Size = New System.Drawing.Size(74, 24)
        Me.Backbtn.TabIndex = 2
        Me.Backbtn.Text = "Back"
        Me.Backbtn.UseVisualStyleBackColor = True
        '
        'DSWOMenu
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(284, 264)
        Me.Controls.Add(Me.Backbtn)
        Me.Controls.Add(Me.Plugins)
        Me.Controls.Add(Me.FirmInst)
        Me.Name = "DSWOMenu"
        Me.Text = "DSWOMenu"
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents FirmInst As System.Windows.Forms.Button
    Friend WithEvents EOStip As System.Windows.Forms.ToolTip
    Friend WithEvents Plugins As System.Windows.Forms.Button
    Friend WithEvents Backbtn As System.Windows.Forms.Button
End Class
