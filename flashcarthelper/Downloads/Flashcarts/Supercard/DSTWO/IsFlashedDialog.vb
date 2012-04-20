Public Class IsFlashedDialog
    Public IsFlashed As Boolean
    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Yes.Click
        IsFlashed = True
        If CheckBox1.Checked = True Then
            My.Settings.DSTWOIsFlashed = True
            My.Settings.Save()
        End If
        Me.Hide()
    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles No.Click
        IsFlashed = False
        If CheckBox1.Checked = True Then
            My.Settings.DSTWOIsFlashed = True
            My.Settings.Save()

        End If
        Me.Hide()
    End Sub
End Class