Imports System.IO
Imports System.Text
Imports System.Text.RegularExpressions

Public Class CMPCheatChangeLog
    Public CheatChangeLog As New CMPCheatChangeLogFunctions
    Private Sub CheatChangeLog_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        My.Computer.Network.DownloadFile("http://files-ds-scene.net/romtool/releases/cmp/changelog_cmp.bin", Cheatmenu.ExtPath + "/temp/changelog_cmp.bin", "", "", False, 100000, True)
        CheatChangeLog.ChangeLogTxt()
    End Sub

End Class
