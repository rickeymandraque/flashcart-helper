#Region "Disclaimer"
'The following code is derived from the "DS-Scene Rom Tool v1.0 build 1205 Re-distributable"
'available at http://www.ds-scene.net/?s=viewtopic&nid=11056
'This code is not considered part of FlashcartHelper and is property of its respective owners
'Use of following code is doctrined under fair use laws of respective countries
'Use of following code is used to provide interoperability between the Code Masters Project ("CMP") Cheat Database Changelog file 
'availible at http://files-ds-scene.net/romtool/releases/cmp/changelog_cmp.bin and FlashcartHelper,
'enabling FlashcartHelper to read from it and output the information to the End User
'License(s) either "Open Source", "Proprietary" or of any type nor form has been found  
'for the source code and executable for "DS-Scene Rom Tool v1.0 build 1205 Re-distributable" has been
'found by the coder(s) of FlashcartHelper. If you are the rights holder for the "DS-Scene Rom Tool v1.0 build 1205 Re-distributable" 
'and wish to inquire about this file and associated source code, please send any concerns to ronny6993@gmail.com
#End Region


Imports System.Text
Imports System.Security.Cryptography
Imports System.IO
Imports System.Runtime.InteropServices
Imports System.Globalization

Public Class CMPCheatChangeLogFunctions
    Public Function createDecryptionReadStream(ByVal sKey As String, ByVal fs As FileStream) As CryptoStream
        Dim dESCryptoServiceProvider As Security.Cryptography.DESCryptoServiceProvider = New Security.Cryptography.DESCryptoServiceProvider()
        dESCryptoServiceProvider.Key = Encoding.ASCII.GetBytes(sKey)
        dESCryptoServiceProvider.IV = Encoding.ASCII.GetBytes(sKey)
        Dim cryptoTransform As ICryptoTransform = dESCryptoServiceProvider.CreateDecryptor()
        Dim cryptoStream As CryptoStream = New CryptoStream(fs, cryptoTransform, CryptoStreamMode.Read)
        Return cryptoStream
    End Function
    Public Function addCommasToHex(ByVal hex As String) As String
        Dim str As String = ""
        Dim num As Integer = 0
        For i As Integer = 0 To hex.Length - 1
            str = String.Concat(str, hex.Substring(i, 1))
            If i <> hex.Length - 1 Then
                num += 1
                If num = 2 Then
                    num = 0
                    str = String.Concat(str, ",")
                End If
            End If
        Next
        Return str
    End Function
    Public Function convertHexToEncryptionKey(ByVal hex As String) As String
        If hex.Length < 16 Then
            MessageBox.Show("The application encoded key is incorrect")
            Environment.[Exit](0)
        End If
        Dim str As String = ""
        hex = Me.addCommasToHex(hex)
        Dim chrArray As Char() = New Char(0) {}
        chrArray(0) = ","c
        Dim strArrays As String() = hex.Split(chrArray)
        For i As Integer = 0 To 7
            Dim num As UInteger = UInteger.Parse(strArrays(i), NumberStyles.HexNumber)
            str = String.Concat(str, Encoding.UTF32.GetString(BitConverter.GetBytes(num)))
        Next
        Return str
    End Function
    Public Function hexToSingleCharString(ByVal hex As String) As String
        Dim num As Integer = Convert.ToInt32(hex, 16)
        Return String.Concat(ChrW(CUShort(num)))
    End Function
    Public Function reversehex(ByVal hex As String, ByVal len As Integer) As String
        Dim str As String = ""
        If hex Is Nothing Then
            str = hex
        Else
            While hex.Length < len
                hex = String.Concat(hex, "0")
            End While
            Dim num As Integer = len - 2
            While num >= 0
                Dim str1 As String = hex.Substring(num, 2)
                str = String.Concat(str, str1)
                num = num - 2
            End While
        End If
        Return str
    End Function
    Public Function reversestring(ByVal str As String) As String
        Dim str1 As String = ""
        For i As Integer = str.Length - 1 To 0 Step -1
            str1 = String.Concat(str1, str.Substring(i, 1))
        Next
        Return str1
    End Function
#Region "Modify ChangeLogTextBox"
    Public Sub ChangeLogTxt()
        Dim str As String
        Dim str1 As String = ""
        Try

            str = "changelog_cmp.bin"

            Dim fileStream As IO.FileStream = New IO.FileStream(String.Concat(Cheatmenu.ExtPath + "/temp/", str), FileMode.Open, FileAccess.Read)
            Dim encryptionKey As String = convertHexToEncryptionKey("790077003F0028003F0050003F003F00")
            encryptionKey = convertHexToEncryptionKey("3F006F003F003F001000000069003F00")
            Dim cryptoStream As Security.Cryptography.CryptoStream = createDecryptionReadStream(encryptionKey, fileStream)
            Using streamReader As StreamReader = New StreamReader(cryptoStream)
                While True
                    Dim str2 As String = streamReader.ReadLine()
                    Dim str3 As String = str2
                    If (str2 = Nothing) Then
                        Exit While
                    End If
                    str1 = String.Concat(str1, str3, "" & vbCrLf & "")
                End While
                streamReader.Close()
            End Using
            fileStream.Close()
        Catch exception As Exception
            'str1 = String.Concat(str1, "{\rtf1\ansi\ansicpg1252\deff0\deflang2057{\fonttbl{\f0\fnil\fcharset0 Verdana;}}\r\n")
            'str1 = String.Concat(str1, "{\*\generator Msftedit 5.41.21.2509;}\viewkind4\uc1\pard\sa200\sl276\slmult1\lang9\b\f0\fs28 DS-Scene Rom Tool Change Log\par\r\n")
        End Try

        Dim str4 As String = Replace(str1, "DS-Scene Rom Tool CMP Database Change Log", "CMP Database Change Log")
        CMPCheatChangeLog.rtf.Rtf = str4

    End Sub
#End Region
End Class


