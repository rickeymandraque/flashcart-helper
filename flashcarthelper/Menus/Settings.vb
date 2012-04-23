Public Class Settings

    Private Sub Settings_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If My.Settings.DSTWOIsFlashed = True Then DstwoIsFlashedCHK.Checked = True
        If My.Settings.DSTWOIsFlashed = False Then DstwoIsFlashedCHK.Checked = False
    End Sub

    Private Sub Clearsettings_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Clearsettings.Click
        My.Settings.Reset()
        Clearsettings.Enabled = False
    End Sub

    Private Sub SaveBtn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SaveBtn.Click
        If DstwoIsFlashedCHK.Checked = True Then My.Settings.DSTWOIsFlashed = True
        If DstwoIsFlashedCHK.Checked = False Then My.Settings.DSTWOIsFlashed = False
        My.Settings.Save()
        Clearsettings.Enabled = True
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles backbtn.Click
        Me.Hide()
        FHMenu.Show()
    End Sub
End Class
