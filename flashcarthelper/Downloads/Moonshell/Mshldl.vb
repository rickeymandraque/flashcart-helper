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

Public Class Moonshell
    Dim mshldl As New System.Net.WebClient
    Public Sub Moonshelldl(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Shown
        AddHandler mshldl.DownloadProgressChanged, AddressOf mshldl_ProgressChanged
        AddHandler mshldl.DownloadFileCompleted, AddressOf mshldl_DownloadCompleted
        Label1.Text = "Downloading MoonShell"
        mshldl.DownloadFileAsync(New Uri("http://filetrip.net/d27227-MoonShell-2-10-Stable-%28ZIP-package%29.html"), Flashcartmenu.ExtPath + "/temp/mshl.zip")
    End Sub

    Public Sub mshldl_ProgressChanged(ByVal sender As Object, ByVal e As System.Net.DownloadProgressChangedEventArgs)
        Dim bytesIn As Double = Double.Parse(e.BytesReceived.ToString())
        Dim totalBytes As Double = Double.Parse(e.TotalBytesToReceive.ToString())
        Dim percentage As Double = bytesIn / totalBytes * 100

        Progress.Value = Int32.Parse(Math.Truncate(percentage).ToString())
        Label1.Text = "Downloading Moonshell " + Progress.Value.ToString + "%"
        Label1.Refresh()
    End Sub

    Public Sub mshldl_DownloadCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.AsyncCompletedEventArgs)
        mshldl.CancelAsync()
        ExtMshl()
        EndMshl()
    End Sub
    Public Sub EndMshl()
        MsgBox("Finished" & vbNewLine & "An Explorer window will open" & vbNewLine & "Please drag all the files to your MicroSD")
        My.Computer.FileSystem.DeleteDirectory(Flashcartmenu.ExtPath + "/temp/", FileIO.DeleteDirectoryOption.DeleteAllContents)
        Process.Start("explorer.exe", Flashcartmenu.ExtPath)
        Me.Hide()
        FHMenu.Show()
    End Sub

    Public Sub ExtMshl()
        Dim mshl As New SevenZip.SevenZipExtractor(Flashcartmenu.ExtPath + "/temp/mshl.zip")
        mshl.ExtractArchive(Flashcartmenu.ExtPath)
    End Sub
End Class