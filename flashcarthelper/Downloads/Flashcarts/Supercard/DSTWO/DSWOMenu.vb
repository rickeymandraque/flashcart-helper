Public Class DSWOMenu

    Private Sub FirmButtonClick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles FirmInst.Click
        Dim YesNo
        YesNo = MsgBox(Prompt:="Download the firmware for the DSTWO?", Title:="Confirm", Buttons:=vbYesNo)
        If YesNo = vbYes Then
            Me.Hide()
            DSTWODL.Show()
        End If
    End Sub

    Private Sub Plugins_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Plugins.Click
        Dim YesNo
        YesNo = MsgBox(Prompt:="Download DSTWO plugins?", Title:="Confirm", Buttons:=vbYesNo)
        If YesNo = vbYes Then
            Me.Hide()
            DSTWOPlugSel.Show()
        End If
    End Sub

    Private Sub Backbtn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Backbtn.Click
        Me.Hide()
        Flashcartmenu.Show()
    End Sub
End Class