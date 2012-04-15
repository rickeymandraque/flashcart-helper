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
Public Class Flashcartmenu
    Public PlugYesNo 'for DSTWO
    Public ExtPath As String
    Dim ExtPathDialog As New System.Windows.Forms.FolderBrowserDialog
    Private Sub Flashcartmenu_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If My.Settings.PreferredExtPath = Nothing Then 'Sets default download path
            ExtPathDialog.SelectedPath = My.Computer.FileSystem.SpecialDirectories.Desktop + "\FlashcartHelper"
        Else
            ExtPathDialog.SelectedPath = My.Settings.PreferredExtPath
        End If

        ExtPath = ExtPathDialog.SelectedPath
        Path.Text = ExtPath
        'Sets tooltips
        AKtip.SetToolTip(AKBtn, "Download AKAIO for the Acekard 2.1, Acekard RPG, or Acekard 2i")
        R4tip.SetToolTip(R4Btn, "Download Wood R4 for the original R4 Revolution")
        DS2tip.SetToolTip(DS2btn, "Download EOS for the Supercard DSTWO")
    End Sub
#Region "Flashcart Buttons"
    Private Sub Ak_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles AKBtn.Click 'AKAIO
        Dim YesNo
        YesNo = MsgBox(Prompt:="Download the firmware for the Acekard?", Title:="Confirm", Buttons:=vbYesNo)
        If YesNo = vbYes Then
            AK2DL.Show()
            Me.Hide()
        End If

    End Sub
    Private Sub R4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles R4Btn.Click
        Dim YesNo
        YesNo = MsgBox(Prompt:="Download the firmware for the R4?", Title:="Confirm", Buttons:=vbYesNo)
        If YesNo = vbYes Then
            R4DL.Show()
            Me.Hide()
        End If
    End Sub
    Private Sub DSTWO_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles DS2btn.Click
        Me.Hide()
        DSWOMenu.Show()
    End Sub
#End Region
    Private Sub ChoosePath_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click

        If ExtPathDialog.ShowDialog() = DialogResult.OK Then
            ExtPath = ExtPathDialog.SelectedPath
            Path.Text = ExtPath
            Path.Refresh()
            My.Settings.PreferredExtPath = ExtPathDialog.SelectedPath
            My.Settings.Save() 'Saves download path to settings
        End If
    End Sub
#Region "Picture of Flashcart" 'Changes picture in Picture box when Tooltip pops up

    Private Sub AKtip_Popup(ByVal sender As System.Object, ByVal e As System.Windows.Forms.PopupEventArgs) Handles AKtip.Popup
        FlashcartBox.Load("http://flashcarthelper.punyman.com/images/f/fd/Acekard2i.jpg")
        FlashcartBox.SizeMode = PictureBoxSizeMode.StretchImage
        FlashcartBox.Refresh()
    End Sub

    Private Sub R4tip_Popup(ByVal sender As System.Object, ByVal e As System.Windows.Forms.PopupEventArgs) Handles R4tip.Popup
        FlashcartBox.Load("http://flashcarthelper.punyman.com/images/d/d4/R4.jpg")
        FlashcartBox.SizeMode = PictureBoxSizeMode.StretchImage
        FlashcartBox.Refresh()
    End Sub



    Private Sub DS2tip_Popup(ByVal sender As System.Object, ByVal e As System.Windows.Forms.PopupEventArgs) Handles DS2tip.Popup
        FlashcartBox.Load("http://flashcarthelper.punyman.com/images/8/8c/DSTWO.jpg")
        FlashcartBox.SizeMode = PictureBoxSizeMode.StretchImage
        FlashcartBox.Refresh()
    End Sub
#End Region

    Private Sub Backbtn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Backbtn.Click
        Me.Hide()
        FHMenu.Show()
    End Sub
End Class
