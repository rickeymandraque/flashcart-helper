<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class CycloRegionDialog
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
        Me.Europe = New System.Windows.Forms.Button()
        Me.NorthAmerica = New System.Windows.Forms.Button()
        Me.Help = New System.Windows.Forms.ToolTip(Me.components)
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(5, 9)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(187, 13)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "What region is your CycloDS iEvo for?"
        Me.Help.SetToolTip(Me.Label1, "If you are setting up a brand new DSTWO, choose No")
        '
        'Europe
        '
        Me.Europe.Location = New System.Drawing.Point(19, 67)
        Me.Europe.Name = "Europe"
        Me.Europe.Size = New System.Drawing.Size(76, 23)
        Me.Europe.TabIndex = 1
        Me.Europe.Text = "Europe (E)"
        Me.Europe.UseVisualStyleBackColor = True
        '
        'NorthAmerica
        '
        Me.NorthAmerica.Location = New System.Drawing.Point(101, 67)
        Me.NorthAmerica.Name = "NorthAmerica"
        Me.NorthAmerica.Size = New System.Drawing.Size(76, 23)
        Me.NorthAmerica.TabIndex = 2
        Me.NorthAmerica.Text = "USA (U)"
        Me.NorthAmerica.UseVisualStyleBackColor = True
        '
        'CycloRegionDialog
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.ClientSize = New System.Drawing.Size(197, 94)
        Me.Controls.Add(Me.NorthAmerica)
        Me.Controls.Add(Me.Europe)
        Me.Controls.Add(Me.Label1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.MaximizeBox = False
        Me.Name = "CycloRegionDialog"
        Me.Text = "FlashcartHelper"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Help As System.Windows.Forms.ToolTip
    Friend WithEvents Europe As System.Windows.Forms.Button
    Friend WithEvents NorthAmerica As System.Windows.Forms.Button
End Class
