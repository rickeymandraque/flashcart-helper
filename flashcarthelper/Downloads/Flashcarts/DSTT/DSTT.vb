#Region "LICENSE"
'  This file is part of FlashcartHelper.
'
'  FlashcartHelper is free software: you can redistribute it and/or modify
'  it under the terms of the GNU General Public License as published by
'  the Free Software Foundation, either version 3 of the License, or
'  (at your option) any later version.

'  FlashcartHelper is distributed in the hope that it will be useful,
'  but WITHOUT ANY WARRANTY; without even the implied warranty of
'  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'  GNU General Public License for more details.
'
'  You should have received a copy of the GNU General Public License
'  along with FlashcartHelper.  If not, see <http://www.gnu.org/licenses/>.
#End Region
Public Class DSTTDL
    Dim SharedC As New SharedClass
    Dim dsttdl As New System.Net.WebClient
    Public Flashcart = "DSTT"

    Private Sub DSTT_Download(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Shown
        SharedC.CheckDirStruct()
        If SharedC.InvalidPath = True Then
            Application.Exit()
        End If
        AddHandler dsttdl.DownloadProgressChanged, AddressOf dsttdl_ProgressChanged
        AddHandler dsttdl.DownloadFileCompleted, AddressOf dsttdl_DownloadCompleted
        dsttdl.DownloadFileAsync(New Uri("http://filetrip.net/h25123605-RetroGameFan-Multi-Cart-Update.html"), Flashcartmenu.ExtPath + "/temp/dstt.7z")
        Label1.Text = "Downloading RetroGameFan's Updates for DSTT"
    End Sub

    Private Sub dsttdl_ProgressChanged(ByVal sender As Object, ByVal e As System.Net.DownloadProgressChangedEventArgs) 'Download Progress
        Dim bytesIn As Double = Double.Parse(e.BytesReceived.ToString())
        Dim totalBytes As Double = Double.Parse(e.TotalBytesToReceive.ToString())
        Dim percentage As Double = bytesIn / totalBytes * 100

        Progress.Value = Int32.Parse(Math.Truncate(percentage).ToString())
        Label1.Text = "Downloading RetroGameFan's Updates for DSTT " + Progress.Value.ToString + "%"
        Label1.Refresh()
    End Sub

    Private Sub dsttdl_DownloadCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.AsyncCompletedEventArgs)
        dsttdl.CancelAsync()
        DSTTExtract()
        SharedC.FlashcartEnd() 'Flashcart Install End Subroutine
        Me.Hide()
    End Sub


    Public Sub DSTTExtract() 'Extraction sub
        Dim DSTT As New SevenZip.SevenZipExtractor(Flashcartmenu.ExtPath + "/temp/dstt.7z")
        Dim TempPath As String = Flashcartmenu.ExtPath + "\temp\"
        Label1.Text = "Extracting RetroGameFan's Updates for DSTT"
        Progress.Value = Progress.Minimum
        DSTT.ExtractArchive(TempPath)
        My.Computer.FileSystem.CopyFile(Flashcartmenu.ExtPath + "\temp\DSTT_DSTTi YSMenu\TTMenu.dat", Flashcartmenu.ExtPath + "\TTMenu.dat")
        My.Computer.FileSystem.CopyDirectory(Flashcartmenu.ExtPath + "\temp\DSTT_DSTTi YSMenu\TTMenu\", Flashcartmenu.ExtPath + "\TTMenu\")
        Progress.Value = Progress.Maximum
    End Sub
End Class