
Public Class Cheatmenu
    Public InvalidPath As Boolean
    Public ExtPath As String
    Public CheatType As String
    Private Sub Cheatmenu_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If My.Settings.PreferredExtPath = Nothing Then 'Sets default download path
            ExtPathDialog.SelectedPath = My.Computer.FileSystem.SpecialDirectories.Desktop + "\FlashcartHelper"
        Else
            ExtPathDialog.SelectedPath = My.Settings.PreferredExtPath
        End If

        ExtPath = ExtPathDialog.SelectedPath
        Path.Text = ExtPath
    End Sub


    Private Sub SaveBtn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles savebtn.Click

        If ExtPathDialog.ShowDialog() = DialogResult.OK Then
            ExtPath = ExtPathDialog.SelectedPath
            Path.Text = ExtPath
            Path.Refresh()
            My.Settings.PreferredExtPath = ExtPathDialog.SelectedPath
            My.Settings.Save() 'Saves download path to settings
        End If
    End Sub

    Private Sub USRCheat_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Me.Hide()
        CheatType = "USRCheat"
        CheatDown.Show()
    End Sub

    Private Sub Back_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button4.Click
        Me.Hide()
        FHMenu.Show()
    End Sub

    Public Sub CheatDownloadEnd()
        MsgBox("Finished" & vbNewLine & "An Explorer window will open" & vbNewLine & "Please drag your cheat file to where it goes on your microSD" & vbNewLine & "This is usually inside your firmware directory" & vbNewLine & "Usually there is an existing cheat file. Just replace it with the new one")
        Process.Start("explorer.exe", Me.ExtPath) 'Open Explorer Window
        My.Computer.FileSystem.DeleteDirectory(Me.ExtPath + "/temp/", FileIO.DeleteDirectoryOption.DeleteAllContents) 'File Cleanup
        FHMenu.Show()
    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button3.Click
        Me.Hide()
        CheatType = "CycloDS"
        CheatDown.Show()
    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        Me.Hide()
        CheatType = "Edge"
        CheatDown.Show()
    End Sub

End Class