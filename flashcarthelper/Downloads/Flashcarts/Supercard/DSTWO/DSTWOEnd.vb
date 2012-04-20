'===================
'This is the DSTWO end sub
'===================
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
Public Class DSTWOEnd
    Public Sub DSTWOEnd() 'DSTWO end routine
        My.Computer.FileSystem.DeleteDirectory(Flashcartmenu.ExtPath + "/temp/", FileIO.DeleteDirectoryOption.DeleteAllContents) 'File Cleanup
        If My.Settings.DSTWOIsFlashed = False Then
            IsFlashedDialog.ShowDialog()
        Else
            IsFlashedDialog.IsFlashed = True
        End If
        If IsFlashedDialog.IsFlashed = True Then
            If My.Computer.FileSystem.FileExists(Flashcartmenu.ExtPath + "/ds2boot.dat") Then
                My.Computer.FileSystem.DeleteFile(Flashcartmenu.ExtPath + "/ds2boot.dat")
            End If
        End If
        MsgBox("Finished" & vbNewLine & "An Explorer window will open" & vbNewLine & "Please drag all the files to your MicroSD")
        Process.Start("explorer.exe", Flashcartmenu.ExtPath) 'Open Explorer Window
        DSTWOPLUG.Hide()
        FHMenu.Show()
    End Sub
End Class
