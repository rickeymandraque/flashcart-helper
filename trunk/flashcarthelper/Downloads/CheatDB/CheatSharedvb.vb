Public Class CheatSharedvb
    Public InvalidPath As Boolean
    Public Sub CheckDirStruct()
        'This subroutine checks if selected path is Desktop,Documents,or Program files.
        'If not, then subroutine checks if selected path has folders and queries user to delete
        'If not, subroutine checks if path exists and file structure exists, if not, will create
        '=======Begin Special Path Checks======
        If Cheatmenu.ExtPath = My.Computer.FileSystem.SpecialDirectories.Desktop Then
            MsgBox("Please select another directory")
            InvalidPath = True
        End If
        If Cheatmenu.ExtPath = My.Computer.FileSystem.SpecialDirectories.MyDocuments Then
            MsgBox("Please select another directory")
            InvalidPath = True
        End If
        If Cheatmenu.ExtPath = My.Computer.FileSystem.SpecialDirectories.ProgramFiles Then
            MsgBox("Please select another directory")
            InvalidPath = True
        End If
        If Cheatmenu.ExtPath = System.Environment.SystemDirectory Then
            MsgBox("Please select another directory")
            InvalidPath = True
        End If
        If Cheatmenu.ExtPath = "C:\" Then
            MsgBox("Please select another directory")
            InvalidPath = True
        End If
        '======End Special Path Checks======
        '======Start Folder is not empty checks======
        If InvalidPath = False Then
            If Not IfEmpty(Cheatmenu.ExtPath) Or IsFolderEmpty(Cheatmenu.ExtPath) = False Then
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
                        For Each foundFile As String In My.Computer.FileSystem.GetFiles(Cheatmenu.ExtPath, FileIO.SearchOption.SearchTopLevelOnly, "*.*")
                            My.Computer.FileSystem.DeleteFile(foundFile, FileIO.UIOption.OnlyErrorDialogs, FileIO.RecycleOption.SendToRecycleBin)
                        Next
                        For Each foundDir As String In My.Computer.FileSystem.GetDirectories(Cheatmenu.ExtPath, FileIO.SearchOption.SearchTopLevelOnly, "*.*")
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
        If Not My.Computer.FileSystem.DirectoryExists(Cheatmenu.ExtPath) Then 'Creates FileStructure if not exist
            My.Computer.FileSystem.CreateDirectory(Cheatmenu.ExtPath)
        End If
        If Not My.Computer.FileSystem.DirectoryExists(Cheatmenu.ExtPath + "/temp/") Then
            My.Computer.FileSystem.CreateDirectory(Cheatmenu.ExtPath + "/temp/")
        End If
        '======End======
    End Sub
    Public Function IfEmpty(ByVal MyPath As String) As Boolean 'Checks for files in Cheatmenu.ExtPath
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
