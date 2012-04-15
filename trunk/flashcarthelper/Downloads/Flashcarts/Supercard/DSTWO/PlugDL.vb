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


    Private Sub DSTWOPLUG_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Checks which checkboxes are checked in DSTWOPlugSel
        If DSTWOPlugSel.NDSGBA.Checked = True Then
            NDSGBADL()
        Else
            If DSTWOPlugSel.CATSFC.Checked = True Then
                CATSFCDL()
            Else
                If DSTWOPlugSel.MAME4ALL.Checked = True Then
                    MAME4ALLDL()
                Else
                    If DSTWOPlugSel.MoonShell.Checked = True Then
                        MoonShellDL()
                    Else
                        If DSTWOPlugSel.DS2x86.Checked = True Then
                            DS2x86DL()
                        Else
                            If DSTWOPlugSel.iPlayer.Checked = True Then
                                iPlayerDL()
                            Else
                                If DSTWOPlugSel.iReader.Checked = True Then
                                    'iReaderDL()
                                Else
                                    If DSTWOPlugSel.Slot2.Checked = True Then

                                        'Slot2dl()
                                    Else
                                    DS2Shared.DSTWOEnd()
                                    End If
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        End If
        '  
    End Sub
#Region "Plugin Downloads"
#Region "NDSGBA" 'Code block downloads and extracts NDSGBA
    Private Sub NDSGBADL()
        Dim ndsgbawc As New System.Net.WebClient
        AddHandler ndsgbawc.DownloadProgressChanged, AddressOf NDSGBAdl_ProgressChanged
        AddHandler ndsgbawc.DownloadFileCompleted, AddressOf NDSGBAdl_DownloadCompleted
        ndsgbawc.DownloadFile("http://flashcarthelper.punyman.com/ApplicationDependencies/game_config.txt", Flashcartmenu.ExtPath + "/temp/game_config.txt")
        ndsgbawc.DownloadFileAsync(New Uri("http://filetrip.net/d11694-SuperCard-DSTWO-GBA-EMU-Plug-in-1-21.html"), Flashcartmenu.ExtPath + "/temp/ndsgba.zip")
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
        Dim ndsgba As New SevenZip.SevenZipExtractor(Flashcartmenu.ExtPath + "/temp/ndsgba.zip")
        ndsgba.ExtractArchive(Flashcartmenu.ExtPath)
        Try
            My.Computer.FileSystem.MoveFile(Flashcartmenu.ExtPath + "\temp\game_config.txt", Flashcartmenu.ExtPath + "\NDSGBA\game_config.txt")
        Catch

        End Try
        My.Computer.FileSystem.RenameFile(Flashcartmenu.ExtPath + "/readme.txt", "NDSGBA_README.txt")
        If DSTWOPlugSel.CATSFC.Checked = True Then
            CATSFCDL()
        Else
            If DSTWOPlugSel.MAME4ALL.Checked = True Then
                MAME4ALLDL()
            Else
                If DSTWOPlugSel.MoonShell.Checked = True Then
                    MoonShellDL()
                Else
                    If DSTWOPlugSel.DS2x86.Checked = True Then
                        DS2x86DL()
                    Else
                        If DSTWOPlugSel.iPlayer.Checked = True Then
                            iPlayerDL()
                        Else
                            If DSTWOPlugSel.iReader.Checked = True Then
                                'iReaderDL()
                            Else
                                If DSTWOPlugSel.Slot2.Checked = True Then

                                    'Slot2dl()
                                Else
                                    DS2Shared.DSTWOEnd()
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub
#End Region
#Region "CATSFC" 'Code block downloads and extracts CATSFC
    Private Sub CATSFCDL()
        Dim catsfcwc As New System.Net.WebClient
        AddHandler catsfcwc.DownloadProgressChanged, AddressOf CATSFCdl_ProgressChanged
        AddHandler catsfcwc.DownloadFileCompleted, AddressOf CATSFCdl_DownloadCompleted
        catsfcwc.DownloadFileAsync(New Uri("http://filetrip.net/h35131424-CATSFC.html"), Flashcartmenu.ExtPath + "/temp/catsfc.zip")
    End Sub
    Private Sub CATSFCdl_ProgressChanged(ByVal sender As Object, ByVal e As System.Net.DownloadProgressChangedEventArgs) 'Download Progress
        Dim bytesIn As Double = Double.Parse(e.BytesReceived.ToString())
        Dim totalBytes As Double = Double.Parse(e.TotalBytesToReceive.ToString())
        Dim percentage As Double = bytesIn / totalBytes * 100

        Progress.Value = Int32.Parse(Math.Truncate(percentage).ToString())
        Label1.Text = "Downloading CATSFC " + Progress.Value.ToString + "%"
        Label1.Refresh()
    End Sub

    Private Sub CATSFCdl_DownloadCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.AsyncCompletedEventArgs)
        Dim catsfc As New SevenZip.SevenZipExtractor(Flashcartmenu.ExtPath + "/temp/catsfc.zip")
        catsfc.ExtractArchive(Flashcartmenu.ExtPath)
        My.Computer.FileSystem.MoveFile(Flashcartmenu.ExtPath + "\catsfc.bmp", Flashcartmenu.ExtPath + "\_dstwoplug\catsfc.bmp", True)
        My.Computer.FileSystem.MoveFile(Flashcartmenu.ExtPath + "\catsfc.ini", Flashcartmenu.ExtPath + "\_dstwoplug\catsfc.ini", True)
        My.Computer.FileSystem.MoveFile(Flashcartmenu.ExtPath + "\CATSFC.plg", Flashcartmenu.ExtPath + "\_dstwoplug\CATSFC.plg", True)
        My.Computer.FileSystem.DeleteFile(Flashcartmenu.ExtPath + "/copyright")
        My.Computer.FileSystem.DeleteFile(Flashcartmenu.ExtPath + "/version")
        My.Computer.FileSystem.DeleteFile(Flashcartmenu.ExtPath + "/source.txt")
        My.Computer.FileSystem.DeleteFile(Flashcartmenu.ExtPath + "/installation.txt")
        If DSTWOPlugSel.MAME4ALL.Checked = True Then
            MAME4ALLDL()
        Else
            If DSTWOPlugSel.MoonShell.Checked = True Then
                MoonShellDL()
            Else
                If DSTWOPlugSel.DS2x86.Checked = True Then
                    DS2x86DL()
                Else
                    If DSTWOPlugSel.iPlayer.Checked = True Then
                        iPlayerDL()
                    Else
                        If DSTWOPlugSel.iReader.Checked = True Then
                            'iReaderDL()
                        Else
                            If DSTWOPlugSel.Slot2.Checked = True Then

                                'Slot2dl()
                            Else
                                DS2Shared.DSTWOEnd()
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End Sub
#End Region
#Region "MAME4ALL" 'Code block downloads and extracts CATSFC
    Private Sub MAME4ALLDL()
        Dim mamewc As New System.Net.WebClient
        AddHandler mamewc.DownloadProgressChanged, AddressOf MAME4ALLdl_ProgressChanged
        AddHandler mamewc.DownloadFileCompleted, AddressOf MAME4ALLdl_DownloadCompleted
        mamewc.DownloadFileAsync(New Uri("http://filetrip.net/d22004-MAME4ALL-%28SCDS2%29-1-0.html"), Flashcartmenu.ExtPath + "/temp/mame4all.7z")
    End Sub
    Private Sub MAME4ALLdl_ProgressChanged(ByVal sender As Object, ByVal e As System.Net.DownloadProgressChangedEventArgs) 'Download Progress
        Dim bytesIn As Double = Double.Parse(e.BytesReceived.ToString())
        Dim totalBytes As Double = Double.Parse(e.TotalBytesToReceive.ToString())
        Dim percentage As Double = bytesIn / totalBytes * 100

        Progress.Value = Int32.Parse(Math.Truncate(percentage).ToString())
        Label1.Text = "Downloading MAME4ALL " + Progress.Value.ToString + "%"
        Label1.Refresh()
    End Sub

    Private Sub MAME4ALLdl_DownloadCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.AsyncCompletedEventArgs)
        Dim mame4all As New SevenZip.SevenZipExtractor(Flashcartmenu.ExtPath + "/temp/mame4all.7z")
        mame4all.ExtractArchive(Flashcartmenu.ExtPath)
        My.Computer.FileSystem.MoveFile(Flashcartmenu.ExtPath + "/Mame4AllDsTwo_V10/gamelist.txt", Flashcartmenu.ExtPath + "/MAME4ALLGamelist.txt", True)
        My.Computer.FileSystem.MoveFile(Flashcartmenu.ExtPath + "/Mame4AllDsTwo_V10/readme.txt", Flashcartmenu.ExtPath + "/MAME4ALL_Readme.txt", True)
        My.Computer.FileSystem.MoveFile(Flashcartmenu.ExtPath + "/Mame4AllDsTwo_V10/FAQ.txt", Flashcartmenu.ExtPath + "/MAME4ALL_FAQ.txt", True)
        My.Computer.FileSystem.MoveDirectory(Flashcartmenu.ExtPath + "/Mame4AllDsTwo_V10/_dstwoplug/", Flashcartmenu.ExtPath + "/_dstwoplug/", True)
        My.Computer.FileSystem.MoveDirectory(Flashcartmenu.ExtPath + "/Mame4AllDsTwo_V10/MAME/", Flashcartmenu.ExtPath + "/MAME/", True)
        My.Computer.FileSystem.DeleteDirectory(Flashcartmenu.ExtPath + "/Mame4AllDsTwo_V10/", FileIO.DeleteDirectoryOption.DeleteAllContents)
        If DSTWOPlugSel.MoonShell.Checked = True Then
            MoonShellDL()
        Else
            If DSTWOPlugSel.DS2x86.Checked = True Then
                DS2x86DL()
            Else
                If DSTWOPlugSel.iPlayer.Checked = True Then
                    'iPlayerDL()
                Else
                    If DSTWOPlugSel.iReader.Checked = True Then
                        'iReaderDL()
                    Else
                        If DSTWOPlugSel.Slot2.Checked = True Then

                            'Slot2dl()
                        Else
                            DS2Shared.DSTWOEnd()
                        End If
                    End If
                End If
            End If
        End If
    End Sub
#End Region
#Region "Moonshell"
    Private Sub MoonShellDL()
        Dim mshlwc As New System.Net.WebClient
        AddHandler mshlwc.DownloadProgressChanged, AddressOf Mshldl_ProgressChanged
        AddHandler mshlwc.DownloadFileCompleted, AddressOf mshldl_DownloadCompleted
        mshlwc.DownloadFileAsync(New Uri("http://down.supercard.cn/download/dstwo/plugin/moonshl2_for_DSTWO.zip"), Flashcartmenu.ExtPath + "/temp/mshl2.zip")
    End Sub
    Private Sub Mshldl_ProgressChanged(ByVal sender As Object, ByVal e As System.Net.DownloadProgressChangedEventArgs) 'Download Progress
        Dim bytesIn As Double = Double.Parse(e.BytesReceived.ToString())
        Dim totalBytes As Double = Double.Parse(e.TotalBytesToReceive.ToString())
        Dim percentage As Double = bytesIn / totalBytes * 100

        Progress.Value = Int32.Parse(Math.Truncate(percentage).ToString())
        Label1.Text = "Downloading MoonShell " + Progress.Value.ToString + "%"
        Label1.Refresh()
    End Sub
    Private Sub mshldl_DownloadCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.AsyncCompletedEventArgs)
        Dim mshlext As New SevenZip.SevenZipExtractor(Flashcartmenu.ExtPath + "/temp/mshl2.zip")
        mshlext.ExtractArchive(Flashcartmenu.ExtPath)
        If DSTWOPlugSel.DS2x86.Checked = True Then
            DS2x86DL()
        Else
            If DSTWOPlugSel.iPlayer.Checked = True Then
                iPlayerDL()
            Else
                If DSTWOPlugSel.iReader.Checked = True Then
                    'iReaderDL()
                Else
                    If DSTWOPlugSel.Slot2.Checked = True Then

                        'Slot2dl()
                    Else
                        DS2Shared.DSTWOEnd()
                    End If
                End If
            End If
        End If
    End Sub

#End Region
#Region "DS2x86"
    Private Sub DS2x86DL()
        Dim ds86wc As New System.Net.WebClient
        AddHandler ds86wc.DownloadProgressChanged, AddressOf ds86wc_ProgressChanged
        AddHandler ds86wc.DownloadFileCompleted, AddressOf ds86wc_DownloadCompleted
        ds86wc.DownloadFileAsync(New Uri("http://filetrip.net/h35131061-DS2x86.html"), Flashcartmenu.ExtPath + "/temp/ds286.7z")
    End Sub
    Private Sub ds86wc_ProgressChanged(ByVal sender As Object, ByVal e As System.Net.DownloadProgressChangedEventArgs) 'Download Progress
        Dim bytesIn As Double = Double.Parse(e.BytesReceived.ToString())
        Dim totalBytes As Double = Double.Parse(e.TotalBytesToReceive.ToString())
        Dim percentage As Double = bytesIn / totalBytes * 100

        Progress.Value = Int32.Parse(Math.Truncate(percentage).ToString())
        Label1.Text = "Downloading DS2x86 " + Progress.Value.ToString + "%"
        Label1.Refresh()
    End Sub
    Private Sub ds86wc_DownloadCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.AsyncCompletedEventArgs)
        Dim ds86depend As New System.Net.WebClient
        ds86depend.DownloadFile("http://flashcarthelper.punyman.com/ApplicationDependencies/4DOS.COM", Flashcartmenu.ExtPath + "/temp/4DOS.com")
        Dim ds286 As New SevenZip.SevenZipExtractor(Flashcartmenu.ExtPath + "/temp/ds286.7z")
        ds286.ExtractArchive(Flashcartmenu.ExtPath)
        My.Computer.FileSystem.MoveFile(Flashcartmenu.ExtPath + "/ds2x86.bmp", Flashcartmenu.ExtPath + "/_dstwoplug/ds2x86.bmp", True)
        My.Computer.FileSystem.MoveFile(Flashcartmenu.ExtPath + "/ds2x86.ini", Flashcartmenu.ExtPath + "/_dstwoplug/ds2x86.ini", True)
        My.Computer.FileSystem.MoveFile(Flashcartmenu.ExtPath + "/ds2x86.plg", Flashcartmenu.ExtPath + "/_dstwoplug/ds2x86.plg", True)
        My.Computer.FileSystem.CreateDirectory(Flashcartmenu.ExtPath + "/data/")
        My.Computer.FileSystem.CreateDirectory(Flashcartmenu.ExtPath + "/data/dsx86/")
        My.Computer.FileSystem.MoveFile(Flashcartmenu.ExtPath + "/temp/4DOS.com", Flashcartmenu.ExtPath + "/data/dsx86/4DOS.com", True)
        ds86depend.DownloadFile("http://dsx86.patrickaalto.com/DSx86.ini", Flashcartmenu.ExtPath + "/data/dsx86/DSx86.ini")

        If DSTWOPlugSel.iPlayer.Checked = True Then
            iPlayerDL()
        Else
            If DSTWOPlugSel.iReader.Checked = True Then
                'iReaderDL()
            Else
                If DSTWOPlugSel.Slot2.Checked = True Then

                    'Slot2dl()
                Else
                    DS2Shared.DSTWOEnd()
                End If
            End If
        End If
    End Sub
#End Region
#Region "iPlayer"
    Private Sub iPlayerDL()
        Dim iplayerwc As New System.Net.WebClient
        AddHandler iplayerwc.DownloadProgressChanged, AddressOf iplayerwc_ProgressChanged
        AddHandler iplayerwc.DownloadFileCompleted, AddressOf iplayerwc_DownloadCompleted
        iplayerwc.DownloadFileAsync(New Uri("http://filetrip.net/h35130740-Supercard-DSTWO-iPlayer-Plugin.html"), Flashcartmenu.ExtPath + "/temp/iplayer.zip")
    End Sub
    Private Sub iplayerwc_ProgressChanged(ByVal sender As Object, ByVal e As System.Net.DownloadProgressChangedEventArgs) 'Download Progress
        Dim bytesIn As Double = Double.Parse(e.BytesReceived.ToString())
        Dim totalBytes As Double = Double.Parse(e.TotalBytesToReceive.ToString())
        Dim percentage As Double = bytesIn / totalBytes * 100

        Progress.Value = Int32.Parse(Math.Truncate(percentage).ToString())
        Label1.Text = "Downloading iPlayer " + Progress.Value.ToString + "%"
        Label1.Refresh()
    End Sub
    Private Sub iplayerwc_DownloadCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.AsyncCompletedEventArgs)
        Dim iplayerext As New SevenZip.SevenZipExtractor(Flashcartmenu.ExtPath + "/temp/iplayer.zip")
        iplayerext.ExtractArchive(Flashcartmenu.ExtPath)
        If DSTWOPlugSel.iReader.Checked = True Then
            'iReaderDL()
        Else
            If DSTWOPlugSel.Slot2.Checked = True Then

                'Slot2dl()
            Else
                DS2Shared.DSTWOEnd()
            End If
        End If

    End Sub
#End Region

#End Region ''Plugin Download''

End Class