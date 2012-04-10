Public Class DSTWODL
    Dim SharedC As New SharedClass
    Public Flashcart = "DSTWO"
    Dim dstwodl As New System.Net.WebClient
    Private Sub DSTWODL_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        SharedC.CheckDirStruct()
        If SharedC.InvalidPath = True Then
            Application.Exit()
        End If
        AddHandler dstwodl.DownloadProgressChanged, AddressOf dstwodl_ProgressChanged
        AddHandler dstwodl.DownloadFileCompleted, AddressOf dstwodl_DownloadCompleted
        dstwodl.DownloadFileAsync(New Uri("http://filetrip.net/h35130066-Supercard-DSTWO-EOS.html"), Flashcartmenu.ExtPath + "/temp/akaio.rar")
        Label1.Text = "Downloading EOS"
    End Sub
    Private Sub dstwodl_ProgressChanged(ByVal sender As Object, ByVal e As System.Net.DownloadProgressChangedEventArgs) 'Download Progress
        Dim bytesIn As Double = Double.Parse(e.BytesReceived.ToString())
        Dim totalBytes As Double = Double.Parse(e.TotalBytesToReceive.ToString())
        Dim percentage As Double = bytesIn / totalBytes * 100

        Progress.Value = Int32.Parse(Math.Truncate(percentage).ToString())
        Label1.Text = "Downloading EOS " + Progress.Value.ToString + "%"
        Label1.Refresh()
    End Sub

    Private Sub dstwodl_DownloadCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.AsyncCompletedEventArgs)
        dstwodl.CancelAsync()
        DSTWOFirmExt()
        Me.Hide()
        DSTWOPlugSel.Show()
    End Sub


    Public Sub DSTWOFirmExt() 'Extraction sub
        Dim akaio As New SevenZip.SevenZipExtractor(Flashcartmenu.ExtPath + "/temp/akaio.rar")
        Label1.Text = "Extracting EOS"
        Progress.Value = Progress.Minimum
        akaio.ExtractArchive(Flashcartmenu.ExtPath)
        Progress.Value = Progress.Maximum
    End Sub

    Private Sub DSTWOFlashcartEnd()
        If Flashcartmenu.CheckBox1.Checked = True Then
            Me.Hide() 'Calling Moonshell Plugin download form
        Else
            MsgBox("Finished" & vbNewLine & "An Explorer window will open" & vbNewLine & "Please drag all the files to your MicroSD")
            Process.Start("explorer.exe", Flashcartmenu.ExtPath) 'Open Explorer Window
            My.Computer.FileSystem.DeleteDirectory(Flashcartmenu.ExtPath + "/temp/", FileIO.DeleteDirectoryOption.DeleteAllContents) 'File Cleanup
            FHMenu.Show()
        End If
    End Sub

End Class



































'NEVAR GONNA GIVE YOU UP
'NEVAR GONNA LET YOU DOWN
'NEVAR GONNA TURN AROUND AND FORGET YOU