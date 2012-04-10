Public Class DSTWoShared
    Public Sub DSTWOEnd()
        MsgBox("Finished" & vbNewLine & "An Explorer window will open" & vbNewLine & "Please drag all the files to your MicroSD")
        Process.Start("explorer.exe", Flashcartmenu.ExtPath) 'Open Explorer Window
        My.Computer.FileSystem.DeleteDirectory(Flashcartmenu.ExtPath + "/temp/", FileIO.DeleteDirectoryOption.DeleteAllContents) 'File Cleanup
        FHMenu.Show()
    End Sub
End Class
