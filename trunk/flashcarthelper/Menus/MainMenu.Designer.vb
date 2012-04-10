<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FHMenu
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
        Me.SetUpFlashcartBtn = New System.Windows.Forms.Button()
        Me.ExitAppBtn = New System.Windows.Forms.Button()
        Me.SetUpFlashcartTip = New System.Windows.Forms.ToolTip(Me.components)
        Me.AppExitTip = New System.Windows.Forms.ToolTip(Me.components)
        Me.Label1 = New System.Windows.Forms.Label()
        Me.SuspendLayout()
        '
        'SetUpFlashcartBtn
        '
        Me.SetUpFlashcartBtn.Location = New System.Drawing.Point(12, 12)
        Me.SetUpFlashcartBtn.Name = "SetUpFlashcartBtn"
        Me.SetUpFlashcartBtn.Size = New System.Drawing.Size(233, 51)
        Me.SetUpFlashcartBtn.TabIndex = 0
        Me.SetUpFlashcartBtn.Text = "Set Up Flashcart"
        Me.SetUpFlashcartBtn.UseVisualStyleBackColor = True
        '
        'ExitAppBtn
        '
        Me.ExitAppBtn.Location = New System.Drawing.Point(12, 382)
        Me.ExitAppBtn.Name = "ExitAppBtn"
        Me.ExitAppBtn.Size = New System.Drawing.Size(233, 51)
        Me.ExitAppBtn.TabIndex = 1
        Me.ExitAppBtn.Text = "Exit FlashcartHelper"
        Me.ExitAppBtn.UseVisualStyleBackColor = True
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(725, 12)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(39, 13)
        Me.Label1.TabIndex = 2
        Me.Label1.Text = "Label1"
        '
        'FHMenu
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(905, 445)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.ExitAppBtn)
        Me.Controls.Add(Me.SetUpFlashcartBtn)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Name = "FHMenu"
        Me.Text = "FlashcartHelper"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents SetUpFlashcartBtn As System.Windows.Forms.Button
    Friend WithEvents ExitAppBtn As System.Windows.Forms.Button
    Friend WithEvents SetUpFlashcartTip As System.Windows.Forms.ToolTip
    Friend WithEvents AppExitTip As System.Windows.Forms.ToolTip
    Friend WithEvents Label1 As System.Windows.Forms.Label
End Class
