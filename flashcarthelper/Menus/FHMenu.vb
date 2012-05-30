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
        Label1.Text = "Version" + My.Application.Info.Version.ToString
        SetUpFlashcartTip.SetToolTip(SetUpFlashcartBtn, "Set up your flashcart")
        AppExitTip.SetToolTip(ExitAppBtn, "Exit FlashcartHelper")
    End Sub

    Private Sub Settingsbtn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Settingsbtn.Click
        Me.Hide()
        Settings.Show()
    End Sub

    Private Sub Button1_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Cheatmenu.Show()
        Me.Hide()
    End Sub
End Class