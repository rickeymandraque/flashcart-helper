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
Public Class R4iGoldDL
    Dim SharedC As New SharedClass
    Dim woodr4idl As New System.Net.WebClient
    Public Flashcart = "R4iGold"

    Private Sub R4_Download(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Shown
        SharedC.CheckDirStruct()
        If SharedC.InvalidPath = True Then
            Application.Exit()
        End If
        AddHandler woodr4idl.DownloadProgressChanged, AddressOf woodr4idl_ProgressChanged
        AddHandler woodr4idl.DownloadFileCompleted, AddressOf woodr4idl_DownloadCompleted
        woodr4idl.DownloadFileAsync(New Uri("http://filetrip.net/h35130127-Wood-R4-for-R4i-Gold-%28R4iDS%29.html"), Flashcartmenu.ExtPath + "/temp/woodr4i.rar")
        Label1.Text = "Downloading WoodR4i Gold"
    End Sub

    Private Sub woodr4idl_ProgressChanged(ByVal sender As Object, ByVal e As System.Net.DownloadProgressChangedEventArgs) 'Download Progress
        Dim bytesIn As Double = Double.Parse(e.BytesReceived.ToString())
        Dim totalBytes As Double = Double.Parse(e.TotalBytesToReceive.ToString())
        Dim percentage As Double = bytesIn / totalBytes * 100

        Progress.Value = Int32.Parse(Math.Truncate(percentage).ToString())
        Label1.Text = "Downloading WoodR4iGold " + Progress.Value.ToString + "%"
        Label1.Refresh()
    End Sub

    Private Sub woodr4idl_DownloadCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.AsyncCompletedEventArgs)
        woodr4idl.CancelAsync()
        R4iExtract()
        SharedC.FlashcartEnd() 'Flashcart Install End Subroutine
        Me.Hide()
    End Sub


    Public Sub R4iExtract() 'Extraction sub
        Dim woodr4i As New SevenZip.SevenZipExtractor(Flashcartmenu.ExtPath + "/temp/woodr4i.rar")
        Label1.Text = "Extracting WoodR4i Gold"
        Progress.Value = Progress.Minimum
        woodr4i.ExtractArchive(Flashcartmenu.ExtPath)
        Progress.Value = Progress.Maximum
    End Sub
End Class