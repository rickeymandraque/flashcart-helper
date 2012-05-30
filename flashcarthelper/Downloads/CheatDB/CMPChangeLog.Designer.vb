<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class CMPCheatChangeLog
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
        Me.rtf = New System.Windows.Forms.RichTextBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.SuspendLayout()
        '
        'rtf
        '
        Me.rtf.AcceptsTab = True
        Me.rtf.AutoWordSelection = True
        Me.rtf.Location = New System.Drawing.Point(12, 12)
        Me.rtf.Name = "rtf"
        Me.rtf.ReadOnly = True
        Me.rtf.Size = New System.Drawing.Size(575, 418)
        Me.rtf.TabIndex = 2
        Me.rtf.Text = ""
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(12, 443)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(369, 13)
        Me.Label1.TabIndex = 3
        Me.Label1.Text = "CMP Cheat DB credits to Code Masters Project and the DS-Scene Rom Tool"
        '
        'CMPCheatChangeLog
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(596, 465)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.rtf)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.MaximizeBox = False
        Me.Name = "CMPCheatChangeLog"
        Me.Text = "FlashcartHelper "
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Public WithEvents rtf As System.Windows.Forms.RichTextBox
    Friend WithEvents Label1 As System.Windows.Forms.Label

End Class
