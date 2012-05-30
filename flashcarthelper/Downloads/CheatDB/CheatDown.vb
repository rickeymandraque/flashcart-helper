Public Class CheatDown
    Dim SharedC As New CheatSharedvb
    Dim cheatdl As New System.Net.WebClient

    Private Sub Cheat_Download(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Shown
        SharedC.CheckDirStruct()
        If SharedC.InvalidPath = True Then
            Me.Hide()
            Application.Exit()
        End If
        My.Settings.PreferredCheatExtPath = Cheatmenu.ExtPath
        My.Settings.Save()
        AddHandler cheatdl.DownloadProgressChanged, AddressOf cheatdl_ProgressChanged
        AddHandler cheatdl.DownloadFileCompleted, AddressOf cheatdl_DownloadCompleted
        If Cheatmenu.CheatType = "USRCheat" Then
            cheatdl.DownloadFileAsync(New Uri("http://files-ds-scene.net/romtool/releases/cmp/CMP_USRcheat.rar"), Cheatmenu.ExtPath + "/temp/cheat.rar")
        End If
        If Cheatmenu.CheatType = "Edge" Then
            cheatdl.DownloadFileAsync(New Uri("http://files-ds-scene.net/romtool/releases/cmp/CMP_edgeCheats.rar"), Cheatmenu.ExtPath + "/temp/cheat.rar")
        End If
        If Cheatmenu.CheatType = "CycloDS" Then
            cheatdl.DownloadFileAsync(New Uri("http://files-ds-scene.net/romtool/releases/cmp/CMP_userEvocheats.rar"), Cheatmenu.ExtPath + "/temp/cheat.rar")
        End If
        Label1.Text = "Downloading latest Cheat DB" + " (" + Cheatmenu.CheatType + ")"
    End Sub

    Private Sub cheatdl_ProgressChanged(ByVal sender As Object, ByVal e As System.Net.DownloadProgressChangedEventArgs) 'Download Progress
        Dim bytesIn As Double = Double.Parse(e.BytesReceived.ToString())
        Dim totalBytes As Double = Double.Parse(e.TotalBytesToReceive.ToString())
        Dim percentage As Double = bytesIn / totalBytes * 100

        Progress.Value = Int32.Parse(Math.Truncate(percentage).ToString())
        Label1.Text = "Downloading Cheat DB" + " (" + Cheatmenu.CheatType + ") " + Progress.Value.ToString + "%"
        Label1.Refresh()
    End Sub

    Private Sub cheatdl_DownloadCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.AsyncCompletedEventArgs)
        cheatdl.CancelAsync()
        CheatExtract()
        Cheatmenu.CheatDownloadEnd() 'Cheat end subrtn
        Me.Hide()
    End Sub


    Public Sub CheatExtract() 'Extraction sub
        Dim cheatext As New SevenZip.SevenZipExtractor(Cheatmenu.ExtPath + "/temp/cheat.rar")
        Label1.Text = "Extracting Cheat DB"
        Progress.Value = Progress.Minimum
        cheatext.ExtractArchive(Cheatmenu.ExtPath)
        Progress.Value = Progress.Maximum
    End Sub


End Class















































#Region "M4G1C HAXX"
'We're no strangers to love
'You know the rules and so do I
'A full commitment's what I'm thinking of
'You wouldn't get this from any other guy

'I just wanna tell you how I'm feeling
'Gotta make you understand

'Never gonna give you up
'Never gonna let you down
'Never gonna run around and desert you
'Never gonna make you cry
'Never gonna say goodbye
'Never gonna tell a lie and hurt you

'We've known each other for so long
'Your heart's been aching, but
'You're too shy to say it
'Inside, we both know what's been going on
'We know the game and we're gonna play it

'And if you ask me how I'm feeling
'Don't tell me you're too blind to see

'Never gonna give you up
'Never gonna let you down
'Never gonna run around and desert you
'Never gonna make you cry
'Never gonna say goodbye
'Never gonna tell a lie and hurt you

'Never gonna give you up
'Never gonna let you down
'Never gonna run around and desert you
'Never gonna make you cry
'Never gonna say goodbye
'Never gonna tell a lie and hurt you
#End Region
