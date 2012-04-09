Public Class AK2DL
    Dim SharedC As New SharedClass
    Dim akaiodl As New System.Net.WebClient
    Public cd = Application.StartupPath
    Public Flashcart = "Acekard2"

    Private Sub Acekard_Download(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Shown
        SharedC.CheckDirStruct()
        If SharedC.InvalidPath = True Then
            Application.Exit()
        End If
        AddHandler akaiodl.DownloadProgressChanged, AddressOf akaiodl_ProgressChanged
        AddHandler akaiodl.DownloadFileCompleted, AddressOf akaiodl_DownloadCompleted
        akaiodl.DownloadFileAsync(New Uri("http://filetrip.net/h7853-AKAIO.html"), Flashcartmenu.ExtPath + "/temp/akaio.rar")
        Label1.Text = "Downloading AKAIO"
    End Sub

    Private Sub akaiodl_ProgressChanged(ByVal sender As Object, ByVal e As System.Net.DownloadProgressChangedEventArgs) 'Download Progress
        Dim bytesIn As Double = Double.Parse(e.BytesReceived.ToString())
        Dim totalBytes As Double = Double.Parse(e.TotalBytesToReceive.ToString())
        Dim percentage As Double = bytesIn / totalBytes * 100

        Progress.Value = Int32.Parse(Math.Truncate(percentage).ToString())
        Label1.Text = "Downloading AKAIO " + Progress.Value.ToString + "%"
        Label1.Refresh()
    End Sub

    Private Sub akaiodl_DownloadCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.AsyncCompletedEventArgs)
        akaiodl.CancelAsync()
        AKExtract()
        SharedC.FlashcartEnd() 'Flashcart Install End Subroutine
        Me.Hide()
    End Sub


    Public Sub AKExtract() 'Extraction sub
        Dim akaio As New SevenZip.SevenZipExtractor(Flashcartmenu.ExtPath + "/temp/akaio.rar")
        Label1.Text = "Extracting AKAIO"
        Progress.Value = Progress.Minimum
        akaio.ExtractArchive(Flashcartmenu.ExtPath)
        Progress.Value = Progress.Maximum
    End Sub
End Class