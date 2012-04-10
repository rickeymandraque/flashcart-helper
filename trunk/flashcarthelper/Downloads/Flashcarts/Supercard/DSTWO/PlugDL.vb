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
Public Class DSTWOPLUG
    Dim DS2Shared As New DSTWoShared
    Dim SharedC As New SharedClass
    Dim dstwodl As New System.Net.WebClient

    Private Sub DSTWOPLUG_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Checks which checkboxes are checked in DSTWOPlugSel
        If DSTWOPlugSel.NDSGBA.Checked = True Then
            NDSGBADL()
        End If
        If DSTWOPlugSel.CATSFC.Checked = True Then

        End If
        If DSTWOPlugSel.MAME4ALL.Checked = True Then

        End If
        If DSTWOPlugSel.MoonShell.Checked = True Then

        End If
        If DSTWOPlugSel.DS2x86.Checked = True Then

        End If
        If DSTWOPlugSel.iPlayer.Checked = True Then

        End If
        If DSTWOPlugSel.iReader.Checked = True Then

        End If
        If DSTWOPlugSel.Slot2.Checked = True Then

        End If
    End Sub
#Region "NDSGBA" 'Code block downloads and extracts NDSGBA
    Public Sub NDSGBADL()
        AddHandler dstwodl.DownloadProgressChanged, AddressOf NDSGBAdl_ProgressChanged
        AddHandler dstwodl.DownloadFileCompleted, AddressOf NDSGBAdl_DownloadCompleted
        dstwodl.DownloadFile("http://flashcarthelper.punyman.com/ApplicationDependencies/game_config.txt", Flashcartmenu.ExtPath + "/temp/game_config.txt")
        dstwodl.DownloadFileAsync(New Uri("http://filetrip.net/d11694-SuperCard-DSTWO-GBA-EMU-Plug-in-1-21.html"), Flashcartmenu.ExtPath + "/temp/ndsgba.zip")
    End Sub
    Private Sub NDSGBAdl_ProgressChanged(ByVal sender As Object, ByVal e As System.Net.DownloadProgressChangedEventArgs) 'Download Progress
        Dim bytesIn As Double = Double.Parse(e.BytesReceived.ToString())
        Dim totalBytes As Double = Double.Parse(e.TotalBytesToReceive.ToString())
        Dim percentage As Double = bytesIn / totalBytes * 100

        Progress.Value = Int32.Parse(Math.Truncate(percentage).ToString())
        Label1.Text = "Downloading NDSGBA " + Progress.Value.ToString + "%"
        Label1.Refresh()
    End Sub

    Private Sub NDSGBAdl_DownloadCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.AsyncCompletedEventArgs)
        dstwodl.CancelAsync()
        Dim ndsgba As New SevenZip.SevenZipExtractor(Flashcartmenu.ExtPath + "/temp/ndsgba.zip")
        ndsgba.ExtractArchive(Flashcartmenu.ExtPath)
        My.Computer.FileSystem.MoveFile(Flashcartmenu.ExtPath + "/temp/game_config.txt", Flashcartmenu.ExtPath + "/NDSGBA/game_config.txt")
    End Sub
#End Region

End Class