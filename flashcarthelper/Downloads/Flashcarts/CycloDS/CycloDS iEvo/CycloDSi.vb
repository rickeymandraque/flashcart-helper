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
Public Class iCycloDL
    Dim SharedC As New SharedClass
    Dim cyclodsdl As New System.Net.WebClient
    Public Flashcart = "CycloDSi"
    Public iEvoFlash As MsgBoxResult

    Private Sub CycloDS_Download(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Shown
        SharedC.CheckDirStruct()
        If SharedC.InvalidPath = True Then
            Application.Exit()
        End If
        iEvoFlash = MsgBox("Do you need to flash your CycloDS iEVO?", vbYesNo)
        AddHandler cyclodsdl.DownloadProgressChanged, AddressOf cyclodsdl_ProgressChanged
        AddHandler cyclodsdl.DownloadFileCompleted, AddressOf cyclodsdl_DownloadCompleted
        cyclodsdl.DownloadFileAsync(New Uri("http://filetrip.net/h35131267-CycloDS-iEvolution-Firmware-Stable.html"), Flashcartmenu.ExtPath + "/temp/cyclo.zip")
        Label1.Text = "Downloading CycloDS iEVO Firmware"
    End Sub

    Private Sub cyclodsdl_ProgressChanged(ByVal sender As Object, ByVal e As System.Net.DownloadProgressChangedEventArgs) 'Download Progress
        Dim bytesIn As Double = Double.Parse(e.BytesReceived.ToString())
        Dim totalBytes As Double = Double.Parse(e.TotalBytesToReceive.ToString())
        Dim percentage As Double = bytesIn / totalBytes * 100
        Progress.Value = Int32.Parse(Math.Truncate(percentage).ToString())
        Label1.Text = "Downloading CycloDS iEVO Firmware " + Progress.Value.ToString + "%"
        Label1.Refresh()
    End Sub

    Private Sub cyclodsdl_DownloadCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.AsyncCompletedEventArgs)
        cyclodsdl.CancelAsync()
        CycloExtract()
        If iEvoFlash = vbYes Then
            CycloFlashWiz()
        Else
            SharedC.FlashcartEnd() 'Flashcart Install End Subroutine
        End If

        Me.Hide()
    End Sub

    Private Sub CycloFlashWiz()
        CycloRegionDialog.ShowDialog()
        Label1.Text = "Processing Bootstrap Update, Please Wait"
        My.Computer.Network.DownloadFile("http://flashcarthelper.punyman.com/ApplicationDependencies/" + CycloRegionDialog.CycloRegion + "_BOOTUPDT.EVO", Flashcartmenu.ExtPath + "\BOOTUPDT.EVO")
        SharedC.FlashcartEnd()
    End Sub


    Public Sub CycloExtract() 'Extraction sub
        Dim cyclods As New SevenZip.SevenZipExtractor(Flashcartmenu.ExtPath + "/temp/cyclo.zip")
        Label1.Text = "Extracting CycloDS Firmware"
        Progress.Value = Progress.Minimum
        cyclods.ExtractArchive(Flashcartmenu.ExtPath)
        Progress.Value = Progress.Maximum
    End Sub
End Class