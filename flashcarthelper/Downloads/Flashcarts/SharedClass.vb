'=================================
'This is a class that stores shared functions for download
'Usage: Dim As new SharedClass
'Invoke SharedClass.{sub}
'=================================
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

Public Class SharedClass
    Public InvalidPath As Boolean
    Public Sub FlashcartEnd()
        If Flashcartmenu.CheckBox1.Checked = True Then
            Moonshell.Show() 'Calling Moonshell download form
        Else
            MsgBox("Finished" & vbNewLine & "An Explorer window will open" & vbNewLine & "Please drag all the files to your MicroSD")
            Process.Start("explorer.exe", Flashcartmenu.ExtPath) 'Open Explorer Window
            My.Computer.FileSystem.DeleteDirectory(Flashcartmenu.ExtPath + "/temp/", FileIO.DeleteDirectoryOption.DeleteAllContents) 'File Cleanup
            FHMenu.Show()
        End If
    End Sub
    Public Sub CheckDirStruct()
        'This subroutine checks if selected path is Desktop,Documents,or Program files.
        'If not, then subroutine checks if selected path has folders and queries user to delete
        'If not, subroutine checks if path exists and file structure exists, if not, will create
        '=======Begin Special Path Checks======
        If Flashcartmenu.ExtPath = My.Computer.FileSystem.SpecialDirectories.Desktop Then
            MsgBox("Please select another directory")
            InvalidPath = True
        End If
        If Flashcartmenu.ExtPath = My.Computer.FileSystem.SpecialDirectories.MyDocuments Then
            MsgBox("Please select another directory")
            InvalidPath = True
        End If
        If Flashcartmenu.ExtPath = My.Computer.FileSystem.SpecialDirectories.ProgramFiles Then
            MsgBox("Please select another directory")
            InvalidPath = True
        End If
        If Flashcartmenu.ExtPath = System.Environment.SystemDirectory Then
            MsgBox("Please select another directory")
            InvalidPath = True
        End If
        If Flashcartmenu.ExtPath = "C:\" Then
            MsgBox("Please select another directory")
            InvalidPath = True
        End If
        '======End Special Path Checks======
        '======Start Folder is not empty checks======
        If InvalidPath = False Then
            If Not IfEmpty(Flashcartmenu.ExtPath) Or IsFolderEmpty(Flashcartmenu.ExtPath) = False Then
                Dim FilesExistDelete
                FilesExistDelete = MsgBox(Prompt:="There are files/folders in this directory" + vbNewLine + "Do you want to delete these files/folders?", Title:="Confirm", Buttons:=vbYesNo)
                If FilesExistDelete = vbNo Then
                    Dim MessyInstall
                    MessyInstall = MsgBox(Prompt:="Do you want to try to continue with files/folders in the directory?", Title:="Confirm", Buttons:=vbYesNo)
                    If MessyInstall = vbNo Then
                        InvalidPath = True
                    End If
                End If

                If FilesExistDelete = vbYes Then
                    Dim FilesDeleteConfirm
                    FilesDeleteConfirm = MsgBox(Prompt:="Are you sure you want to delete these files?", Title:="Confirm", Buttons:=vbYesNo)
                    If FilesDeleteConfirm = vbYes Then
                        For Each foundFile As String In My.Computer.FileSystem.GetFiles(Flashcartmenu.ExtPath, FileIO.SearchOption.SearchTopLevelOnly, "*.*")
                            My.Computer.FileSystem.DeleteFile(foundFile, FileIO.UIOption.OnlyErrorDialogs, FileIO.RecycleOption.SendToRecycleBin)
                        Next
                        For Each foundDir As String In My.Computer.FileSystem.GetDirectories(Flashcartmenu.ExtPath, FileIO.SearchOption.SearchTopLevelOnly, "*.*")
                            My.Computer.FileSystem.DeleteDirectory(foundDir, FileIO.DeleteDirectoryOption.DeleteAllContents)
                        Next
                    Else
                        InvalidPath = True
                    End If
                End If
            End If
        End If
        '======End Folder is not empty checks======
        '======Start Directory Structure tests======
        Try
            If Not My.Computer.FileSystem.DirectoryExists(Flashcartmenu.ExtPath) Then 'Creates FileStructure if not exist
                My.Computer.FileSystem.CreateDirectory(Flashcartmenu.ExtPath)
            End If
            If Not My.Computer.FileSystem.DirectoryExists(Flashcartmenu.ExtPath + "/temp/") Then
                My.Computer.FileSystem.CreateDirectory(Flashcartmenu.ExtPath + "/temp/")
            End If
        Catch ex As Exception
            Flashcartmenu.ExtPath = My.Computer.FileSystem.SpecialDirectories.Desktop + "\FlashcartHelper\Cheats\"
        End Try


        '======End======
    End Sub
    Public Function IfEmpty(ByVal MyPath As String) As Boolean 'Checks for files in Flashcartmenu.ExtPath
        IfEmpty = (Dir(MyPath & "\*.*") = "")
    End Function
    Public Function IsFolderEmpty(ByVal strPath As String) As Boolean 'Checks for directories in Flashcartemenu.ExtPath
        Dim s As String

        'add final slash from path 
        If Right(strPath, 1) <> "\" Then strPath = strPath & "\"
        'check directory contents (files and subfolders) 
        s = Dir(strPath, vbNormal Or vbDirectory)
        IsFolderEmpty = True
        Do While s <> ""
            'if the directory contains something other than system folders 
            'then it's not empty 
            If s <> "." And s <> ".." Then
                IsFolderEmpty = False
                Exit Do
            End If
            'continue enum 
            s = Dir()
        Loop
    End Function
End Class