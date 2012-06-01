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

Public Class FHMenu

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SetUpFlashcartBtn.Click
        Flashcartmenu.Show()
        Me.Hide()
    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ExitAppBtn.Click
        Application.Exit()
    End Sub

    Private Sub FHMenu_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Label1.Text = "Version " + My.Application.Info.Version.ToString
        SetUpFlashcartTip.SetToolTip(SetUpFlashcartBtn, "Set up your flashcart")
        AppExitTip.SetToolTip(ExitAppBtn, "Exit FlashcartHelper")
        CheatDBTip.SetToolTip(Cheatbtn, "Download the latest Cheats for your flashcart")
    End Sub

    Private Sub Settingsbtn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Settingsbtn.Click
        Me.Hide()
        Settings.Show()
    End Sub

    Private Sub CheatMenu_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Cheatbtn.Click
        Cheatmenu.Show()
        Me.Hide()
    End Sub

    'shh..It's a secret
    Private Sub Label1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Label1.Click
        MsgBox("Never gonna give you up" + vbNewLine + "Never gonna let you down" + vbNewLine + "Never gonna run around and desert you" + vbNewLine + "Never gonna make you cry" + vbNewLine + "Never gonna say goodbye" + vbNewLine + "Never gonna tell a lie and hurt you", Title:="You've got Rickrolled!")
    End Sub

#Region "Menubar"
    Private Sub InstallAKAIOToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles InstallAKAIOToolStripMenuItem.Click
        If My.Settings.PreferredExtPath = Nothing Then
            Flashcartmenu.ExtPath = My.Computer.FileSystem.SpecialDirectories.Desktop + "\FlashcartHelper\"
        Else
            Flashcartmenu.ExtPath = My.Settings.PreferredExtPath
        End If
        Me.Hide()
        AK2DL.Show()
    End Sub
    Private Sub InstallWoodR4ToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles InstallWoodR4ToolStripMenuItem.Click
        If My.Settings.PreferredExtPath = Nothing Then
            Flashcartmenu.ExtPath = My.Computer.FileSystem.SpecialDirectories.Desktop + "\FlashcartHelper\"
        Else
            Flashcartmenu.ExtPath = My.Settings.PreferredExtPath
        End If
        Me.Hide()
        R4DL.Show()
    End Sub

    Private Sub InstallWoodR4iGoldToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles InstallWoodR4iGoldToolStripMenuItem.Click
        If My.Settings.PreferredExtPath = Nothing Then
            Flashcartmenu.ExtPath = My.Computer.FileSystem.SpecialDirectories.Desktop + "\FlashcartHelper\"
        Else
            Flashcartmenu.ExtPath = My.Settings.PreferredExtPath
        End If
        Me.Hide()
        R4iGoldDL.Show()
    End Sub

    Private Sub InstallWoodR4iDSNToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles InstallWoodR4iDSNToolStripMenuItem.Click
        If My.Settings.PreferredExtPath = Nothing Then
            Flashcartmenu.ExtPath = My.Computer.FileSystem.SpecialDirectories.Desktop + "\FlashcartHelper\"
        Else
            Flashcartmenu.ExtPath = My.Settings.PreferredExtPath
        End If
        Me.Hide()
        DSNDL.Show()
    End Sub

    Private Sub InstallRetroGameFansUpdatesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles InstallRetroGameFansUpdatesToolStripMenuItem.Click
        If My.Settings.PreferredExtPath = Nothing Then
            Flashcartmenu.ExtPath = My.Computer.FileSystem.SpecialDirectories.Desktop + "\FlashcartHelper\"
        Else
            Flashcartmenu.ExtPath = My.Settings.PreferredExtPath
        End If
        Me.Hide()
        DSTTDL.Show()
    End Sub


    Private Sub InstallEOSToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles InstallEOSToolStripMenuItem.Click
        If My.Settings.PreferredExtPath = Nothing Then
            Flashcartmenu.ExtPath = My.Computer.FileSystem.SpecialDirectories.Desktop + "\FlashcartHelper\"
        Else
            Flashcartmenu.ExtPath = My.Settings.PreferredExtPath
        End If
        Me.Hide()
        DSTWODL.Show()
    End Sub

    Private Sub InstallPluginsToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles InstallPluginsToolStripMenuItem.Click
        If My.Settings.PreferredExtPath = Nothing Then
            Flashcartmenu.ExtPath = My.Computer.FileSystem.SpecialDirectories.Desktop + "\FlashcartHelper\"
        Else
            Flashcartmenu.ExtPath = My.Settings.PreferredExtPath
        End If
        Me.Hide()
        DSTWOPlugSel.Show()
    End Sub

    Private Sub InstallFirmToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles InstallFirmToolStripMenuItem.Click
        If My.Settings.PreferredExtPath = Nothing Then
            Flashcartmenu.ExtPath = My.Computer.FileSystem.SpecialDirectories.Desktop + "\FlashcartHelper\"
        Else
            Flashcartmenu.ExtPath = My.Settings.PreferredExtPath
        End If
        Me.Hide()
        CycloDL.Show()
    End Sub

    Private Sub ExitToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ExitToolStripMenuItem.Click
        Application.Exit()
    End Sub

    Private Sub InstallUsrcheatdatToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles InstallUsrcheatdatToolStripMenuItem.Click
        If My.Settings.PreferredCheatExtPath = Nothing Then
            Cheatmenu.ExtPath = My.Computer.FileSystem.SpecialDirectories.Desktop + "\FlashcartHelper\Cheats\"
        Else
            Cheatmenu.ExtPath = My.Settings.PreferredCheatExtPath
        End If
        Cheatmenu.CheatType = "USRCheat"
        CheatDown.Show()
    End Sub

    Private Sub InstallEDGECheatsToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles InstallEDGECheatsToolStripMenuItem.Click
        If My.Settings.PreferredCheatExtPath = Nothing Then
            Cheatmenu.ExtPath = My.Computer.FileSystem.SpecialDirectories.Desktop + "\FlashcartHelper\Cheats\"
        Else
            Cheatmenu.ExtPath = My.Settings.PreferredCheatExtPath
        End If
        Cheatmenu.CheatType = "Edge"
        CheatDown.Show()
    End Sub

    Private Sub InstallCycloDSCheatsToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles InstallCycloDSCheatsToolStripMenuItem.Click
        If My.Settings.PreferredCheatExtPath = Nothing Then
            Cheatmenu.ExtPath = My.Computer.FileSystem.SpecialDirectories.Desktop + "\FlashcartHelper\Cheats\"
        Else
            Cheatmenu.ExtPath = My.Settings.PreferredCheatExtPath
        End If
        Cheatmenu.CheatType = "CycloDS"
        CheatDown.Show()
    End Sub

    Private Sub AboutFlashcartHelperToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles AboutFlashcartHelperToolStripMenuItem.Click
        AboutBox1.ShowDialog()
    End Sub

    Private Sub ShowIsDSTWOFlashedMessageToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ShowIsDSTWOFlashedMessageToolStripMenuItem.Click
        ShowIsDSTWOFlashedMessageToolStripMenuItem.CheckOnClick = True
        If ShowIsDSTWOFlashedMessageToolStripMenuItem.Checked = False Then
            My.Settings.DSTWOIsFlashed = True
        Else
            My.Settings.DSTWOIsFlashed = False
        End If
    End Sub
    Private Sub ViewCheatDBChangelogToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ViewCheatDBChangelogToolStripMenuItem.Click
        CMPCheatChangeLog.ShowDialog()
    End Sub
#End Region

 

End Class