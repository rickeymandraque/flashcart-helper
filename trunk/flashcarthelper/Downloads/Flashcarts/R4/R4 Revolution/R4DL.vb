'Wood R4 has  a special dir structure that is handled by a script
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
Public Class R4DL
    Dim SharedC As New SharedClass
    Public Flashcart = "R4"
    Dim r4dl As New System.Net.WebClient


    Private Sub r4_Download(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Shown
        SharedC.CheckDirStruct()
        If SharedC.InvalidPath = True Then
            Application.Exit()
        End If
        AddHandler r4dl.DownloadProgressChanged, AddressOf r4_ProgressChanged
        AddHandler r4dl.DownloadFileCompleted, AddressOf r4_DownloadCompleted
        r4dl.DownloadFileAsync(New Uri("http://filetrip.net/h25123666-Wood-R4.html"), Flashcartmenu.ExtPath + "/temp/woodr4.7z")
        Label1.Text = "Downloading Wood R4"
    End Sub
    Private Sub r4_ProgressChanged(ByVal sender As Object, ByVal e As System.Net.DownloadProgressChangedEventArgs) 'Download Progress
        Dim bytesIn As Double = Double.Parse(e.BytesReceived.ToString())
        Dim totalBytes As Double = Double.Parse(e.TotalBytesToReceive.ToString())
        Dim percentage As Double = bytesIn / totalBytes * 100

        Progress.Value = Int32.Parse(Math.Truncate(percentage).ToString())
        Label1.Text = "Downloading Wood R4 " + Progress.Value.ToString + "%"
        Label1.Refresh()
    End Sub

    Private Sub r4_DownloadCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.AsyncCompletedEventArgs)
        r4dl.CancelAsync()
        ExtR4()
        InstWood()
        SharedC.FlashcartEnd()
        Me.Hide()
    End Sub

    Public Sub ExtR4() 'Exraction sub
        Dim r4 As New SevenZip.SevenZipExtractor(Flashcartmenu.ExtPath + "/temp/woodr4.7z")
        Label1.Text = "Extracting Wood R4"
        Progress.Value = Progress.Minimum
        r4.ExtractArchive(Flashcartmenu.ExtPath)
        Progress.Value = Progress.Maximum
    End Sub


    Public Sub InstWood() 'Renames Wood Directory to "woodr4"
        If My.Computer.FileSystem.DirectoryExists(Flashcartmenu.ExtPath + "/woodr4/") Then
            My.Computer.FileSystem.DeleteDirectory(Flashcartmenu.ExtPath + "/woodr4/", FileIO.DeleteDirectoryOption.DeleteAllContents) 'Deletes "woodr4" if exist"
        End If
        My.Computer.FileSystem.WriteAllText(Flashcartmenu.ExtPath + "/temp/woodren.bat", "title WoodRen" + vbNewLine + "cd %1\woodr4_v*.**" + vbNewLine + "set WoodPath=%cd%" + vbNewLine + "cd .." + vbNewLine + "ren %woodpath% woodr4" + vbNewLine + "title WoodRen", False) 'Writes woodren.bat for wood renaming
        Dim WoodRenScript As New ProcessStartInfo
        WoodRenScript.WorkingDirectory = Flashcartmenu.ExtPath
        WoodRenScript.FileName = Flashcartmenu.ExtPath + "/temp/woodren.bat"
        WoodRenScript.Arguments = Flashcartmenu.ExtPath
        WoodRenScript.WindowStyle = ProcessWindowStyle.Hidden
        Process.Start(WoodRenScript).WaitForExit() 'BAT script renames WoodR4 Directory to Code-Friendly "woodr4"
        My.Computer.FileSystem.MoveFile(Flashcartmenu.ExtPath + "/woodr4/_DS_MENU.DAT", Flashcartmenu.ExtPath + "/_DS_MENU.DAT", True)
        My.Computer.FileSystem.MoveDirectory(Flashcartmenu.ExtPath + "/woodr4/__rpg/", Flashcartmenu.ExtPath + "/__rpg", True)
        My.Computer.FileSystem.DeleteDirectory(Flashcartmenu.ExtPath + "/woodr4/", FileIO.DeleteDirectoryOption.DeleteAllContents)
    End Sub
End Class