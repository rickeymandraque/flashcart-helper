'=============
'DSTWO Plugin Selection UI
'Checkboxes are cross-referenced in Class DSTWOPLUG
'To determine which plugins are downloaded
'============
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
Public Class DSTWOPlugSel

    Private Sub DSTWOPlugSel_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Flashcartmenu.CheckBox1.Checked = True Then 'Auto checks Moonshell box if user checks it at Flashcartmenu
            MoonShell.Checked = True
        End If
        'Tootips for boxes
        NDSGBATip.SetToolTip(NDSGBA, "NDSGBA is the DSTWO GBA emulator")
        CATSFCTip.SetToolTip(CATSFC, "CATSFC is the DSTWO SNES emulator")
        MoonShellTip.SetToolTip(MoonShell, "MoonShell 2 is a multimedia application for the Nintendo DS")
        MAME4Alltip.SetToolTip(MAME4ALL, "MAME4ALL is a MAME (Multiple Arcade Machine Emulator) for the DSTWO. BIOS files may be required, FlashcartHelper will not supply these")
        DS2x86tip.SetToolTip(DS2x86, "DS2x86 is a DOS emulator for the DSTWO")
        iPlayerTip.SetToolTip(iPlayer, "iPlayer is a multimedia application for the DSTWO. It can play some certain formats not supported by MoonShell. It is recommended to install both")
        iReaderTip.SetToolTip(iReader, "iReader is a eBook reader for the DSTWO")
        SLOT2Tip.SetToolTip(Slot2, "Install this to access the device in SLOT-2. Not Supported by DSi and 3DS")

    End Sub

    Private Sub Confirm(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ConfBtn.Click
        Me.Hide()
        DSTWOPLUG.Show()
    End Sub

    Private Sub SelectAll_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SelectAll.Click
        'Checks all when button is pressed
        NDSGBA.Checked = True
        CATSFC.Checked = True
        MoonShell.Checked = True
        MAME4ALL.Checked = True
        DS2x86.Checked = True
        iPlayer.Checked = True
        iReader.Checked = True
        Slot2.Checked = True
    End Sub

    Private Sub SelectNone_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SelectNone.Click
        'Unchecks all if pressed
        NDSGBA.Checked = False
        CATSFC.Checked = False
        MoonShell.Checked = False
        MAME4ALL.Checked = False
        DS2x86.Checked = False
        iPlayer.Checked = False
        iReader.Checked = False
        Slot2.Checked = False
    End Sub
End Class