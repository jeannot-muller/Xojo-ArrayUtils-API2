#tag Module
Protected Module UnitTests
	#tag CompatibilityFlags = TargetHasGUI
	#tag Method, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Sub DetailedErrorIf(errCondition As Boolean, details As String)
		  // Unit testing code calls this function to check if an error has
		  // occurred.  If so, report it to the user and then break into
		  // the debugger so he can do something about it.
		  
		  if not errCondition then return
		  
		  MainWindow.Print "Unit test failure: " + details
		  MsgBox "Unit test failure." + EndOfLine + EndOfLine + details
		  
		  
		  break  // OK, now look at the stack to see what went wrong!
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Sub ErrorIf(errCondition As Boolean)
		  // Unit testing code calls this function to check if an error has
		  // occurred.  If so, report it to the user and then break into
		  // the debugger so he can do something about it.
		  
		  if not errCondition then return
		  
		  Dim msg As String
		  msg = "Unit test failure."
		  #if DebugBuild
		    msg = msg + EndOfLine + EndOfLine _
		    + "Click OK to drop into the debugger and examine the stack."
		  #endif
		  MainWindow.Print msg
		  MsgBox msg
		  
		  
		  break  // OK, now look at the stack to see what went wrong!
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ErrorIfNotEqual(arr1() As Double, arr2() As Double)
		  if UBound( arr1 ) <> UBound( arr2 ) then
		    ErrorIf true
		    return
		  end if
		  
		  Dim i As Integer
		  for i = 0 to UBound( arr1 )
		    ErrorIf arr1(i) <> arr2(i)
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ErrorIfNotEqual(actual As Double, expected As Double)
		  DetailedErrorIf Abs(actual - expected) > 1E-12, _
		   "Expected " + str(expected) + ", got " + str(actual) + "."
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ErrorIfNotEqual(arr1() As Integer, arr2() As Integer)
		  if UBound( arr1 ) <> UBound( arr2 ) then
		    ErrorIf true
		    return
		  end if
		  
		  Dim i As Integer
		  for i = 0 to UBound( arr1 )
		    ErrorIf arr1(i) <> arr2(i)
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ErrorIfNotEqual(actual As Integer, expected As Integer)
		  DetailedErrorIf actual <> expected, "Expected " + str(expected) + ", got " + str(actual) + "."
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ErrorIfNotEqual(arr1() As String, arr2() As String)
		  if UBound( arr1 ) <> UBound( arr2 ) then
		    ErrorIf true
		    return
		  end if
		  
		  Dim i As Integer
		  for i = 0 to UBound( arr1 )
		    ErrorIf arr1(i) <> arr2(i)
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Sub Run()
		  // Run all our unit tests.
		  
		  TestAppend
		  TestAverage
		  TestConcat
		  TestClone
		  TestMaxAndMin
		  TestRemoveSlice
		  TestReverse
		  TestSlice
		  TestSplice
		  TestSum
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestAppend()
		  Dim iempty() As Integer
		  Dim ia() As Integer = Array( 1, 2, 3 )
		  Dim ib() As Integer = Array( 4, 5 )
		  Dim itest() As Integer
		  
		  itest = iempty.Clone
		  itest.Append iempty
		  ErrorIfNotEqual itest, iempty
		  
		  itest = ia.Clone
		  itest.Append iempty
		  ErrorIfNotEqual itest, ia
		  
		  itest = iempty.Clone
		  itest.Append ia
		  ErrorIfNotEqual itest, ia
		  
		  itest = ia.Clone
		  itest.Append ib
		  ErrorIfNotEqual itest, Array( 1, 2, 3, 4, 5 )
		  
		  Dim dempty() As Double
		  Dim da() As Double = Array( 1.1, 2.2, 3.3 )
		  Dim db() As Double = Array( 4.4, 5.5 )
		  Dim dtest() As Double
		  
		  dtest = dempty.Clone
		  dtest.Append dempty
		  ErrorIfNotEqual dtest, dempty
		  
		  dtest = da.Clone
		  dtest.Append dempty
		  ErrorIfNotEqual dtest, da
		  
		  dtest = dempty.Clone
		  dtest.Append da
		  ErrorIfNotEqual dtest, da
		  
		  dtest = da.Clone
		  dtest.Append db
		  ErrorIfNotEqual dtest, Array( 1.1, 2.2, 3.3, 4.4, 5.5 )
		  
		  
		  Dim sempty() As String
		  Dim sa() As String = Array( "a", "b", "c" )
		  Dim sb() As String = Array( "d", "e" )
		  Dim stest() As String
		  
		  stest = sempty.Clone
		  stest.Append sempty
		  ErrorIfNotEqual stest, sempty
		  
		  stest = sa.Clone
		  stest.Append sempty
		  ErrorIfNotEqual stest, sa
		  
		  stest = sempty.Clone
		  stest.Append sa
		  ErrorIfNotEqual stest, sa
		  
		  stest = sa.Clone
		  stest.Append sb
		  ErrorIfNotEqual stest, Array( "a", "b", "c", "d", "e" )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestAverage()
		  Dim iarr() As Integer
		  ErrorIfNotEqual iarr.Average, 0.0
		  
		  iarr = Array(42)
		  ErrorIfNotEqual iarr.Average, 42.0
		  
		  iarr = Array(-5, 5, 3, -3)
		  ErrorIfNotEqual iarr.Average, 0.0
		  
		  iarr = Array(3, 2)
		  ErrorIfNotEqual iarr.Average, 2.5
		  
		  Dim darr() As Double
		  ErrorIfNotEqual darr.Average, 0.0
		  
		  darr = Array(40.2)
		  ErrorIfNotEqual darr.Average, 40.2
		  
		  darr = Array(-4.9, 5.1, 3.1, -2.9)
		  ErrorIfNotEqual darr.Average, 0.1
		  
		  darr = Array(3.5, 2.5)
		  ErrorIfNotEqual darr.Average, 3.0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestClone()
		  Dim ia() As Integer = Array( 1, 3, 5 )
		  Dim ib() As Integer = ia.Clone
		  ErrorIfNotEqual ia, ib
		  ia(0) = 42
		  ErrorIf ib(0) = 42
		  
		  Dim da() As Double = Array( 1.1, 3.2, 5.3 )
		  Dim db() As Double = da.Clone
		  ErrorIfNotEqual da, db
		  da(0) = 42
		  ErrorIf db(0) = 42
		  
		  Dim sa() As String = Array( "a", "b", "c" )
		  Dim sb() As String = sa.Clone
		  ErrorIfNotEqual sa, sb
		  sa(0) = "foo"
		  ErrorIf sb(0) = "foo"
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestConcat()
		  Dim iempty() As Integer
		  Dim ia() As Integer = Array( 1, 2, 3 )
		  Dim ib() As Integer = Array( 4, 5 )
		  Dim itest() As Integer
		  
		  ErrorIfNotEqual iempty.Concat( iempty ), iempty
		  ErrorIfNotEqual ia.Concat( iempty ), ia
		  ErrorIfNotEqual iempty.Concat( ia ), ia
		  ErrorIfNotEqual ia.Concat( ib ), Array( 1, 2, 3, 4, 5 )
		  
		  Dim dempty() As Double
		  Dim da() As Double = Array( 1.1, 2.2, 3.3 )
		  Dim db() As Double = Array( 4.4, 5.5 )
		  Dim dtest() As Double
		  
		  ErrorIfNotEqual dempty.Concat( dempty ), dempty
		  ErrorIfNotEqual da.Concat( dempty ), da
		  ErrorIfNotEqual dempty.Concat( da ), da
		  ErrorIfNotEqual da.Concat( db ), Array( 1.1, 2.2, 3.3, 4.4, 5.5 )
		  
		  Dim sempty() As String
		  Dim sa() As String = Array( "1", "2", "3" )
		  Dim sb() As String = Array( "4", "5" )
		  Dim stest() As String
		  
		  ErrorIfNotEqual sempty.Concat( sempty ), sempty
		  ErrorIfNotEqual sa.Concat( sempty ), sa
		  ErrorIfNotEqual sempty.Concat( sa ), sa
		  ErrorIfNotEqual sa.Concat( sb ), Array( "1", "2", "3", "4", "5" )
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestMaxAndMin()
		  
		  Dim iarr() As Integer
		  ErrorIfNotEqual iarr.Max, 0
		  ErrorIfNotEqual iarr.Min, 0
		  
		  iarr = Array(42)
		  ErrorIfNotEqual iarr.Max, 42
		  ErrorIfNotEqual iarr.Min, 42
		  
		  iarr = Array(-1, 2, -3, 4, 5)
		  ErrorIfNotEqual iarr.Max, 5
		  ErrorIfNotEqual iarr.Min, -3
		  
		  Dim darr() As Double
		  ErrorIfNotEqual darr.Max, 0.0
		  ErrorIfNotEqual darr.Min, 0.0
		  
		  darr = Array(42.0)
		  ErrorIfNotEqual darr.Max, 42.0
		  ErrorIfNotEqual darr.Min, 42.0
		  
		  darr = Array(-1.1, 2.2, -3.3, 4.4, 5.5)
		  ErrorIfNotEqual darr.Max, 5.5
		  ErrorIfNotEqual darr.Min, -3.3
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestRemoveSlice()
		  // Integers...
		  
		  Dim ia() As Integer = Array( 10, 11, 12, 13, 14, 15 )
		  Dim ib() As Integer = ia.Clone
		  ib.RemoveSlice 1,4  // remove items 1 through 3
		  ErrorIfNotEqual ib, Array( 10, 14, 15 )
		  
		  ib = ia.Clone
		  ib.RemoveSlice 3   // remove from 3 to the end
		  ErrorIfNotEqual ib, Array( 10, 11, 12 )
		  
		  ib = ia.Clone
		  ib.RemoveSlice -2   // remove the last 2 items
		  ErrorIfNotEqual ib, Array( 10, 11, 12, 13 )
		  
		  ib = ia.Clone
		  ib.RemoveSlice -4, -1  // remove the 4th through 2nd items from the end
		  ErrorIfNotEqual ib, Array( 10, 11, 15 )
		  
		  ib = ia.Clone
		  ib.RemoveSlice 0, 1  // remove just the 1st item
		  ErrorIfNotEqual ib, Array( 11, 12, 13, 14, 15 )
		  
		  ib = ia.Clone
		  ib.RemoveSlice -1  // remove just the last item
		  ErrorIfNotEqual ib, Array( 10, 11, 12, 13, 14 )
		  
		  ib = ia.Clone
		  ib.RemoveSlice 2, -3  // remove just item 2 (specified two ways)
		  ErrorIfNotEqual ib, Array( 10, 11, 13, 14, 15 )
		  
		  // Strings...
		  
		  Dim sa() As String = Array( "10", "11", "12", "13", "14", "15" )
		  Dim sb() As String = sa.Clone
		  sb.RemoveSlice 1,4  // remove items 1 through 3
		  ErrorIfNotEqual sb, Array( "10", "14", "15" )
		  
		  sb = sa.Clone
		  sb.RemoveSlice 3   // remove from 3 to the end
		  ErrorIfNotEqual sb, Array( "10", "11", "12" )
		  
		  sb = sa.Clone
		  sb.RemoveSlice -2   // remove the last 2 items
		  ErrorIfNotEqual sb, Array( "10", "11", "12", "13" )
		  
		  sb = sa.Clone
		  sb.RemoveSlice -4, -1  // remove the 4th through 2nd items from the end
		  ErrorIfNotEqual sb, Array( "10", "11", "15" )
		  
		  sb = sa.Clone
		  sb.RemoveSlice 0, 1  // remove just the 1st item
		  ErrorIfNotEqual sb, Array( "11", "12", "13", "14", "15" )
		  
		  sb = sa.Clone
		  sb.RemoveSlice -1  // remove just the last item
		  ErrorIfNotEqual sb, Array( "10", "11", "12", "13", "14" )
		  
		  sb = sa.Clone
		  sb.RemoveSlice 2, -3  // remove just item 2 (specified two ways)
		  ErrorIfNotEqual sb, Array( "10", "11", "13", "14", "15" )
		  
		  // Doubles...
		  
		  Dim da() As Double = Array( 1.0, 1.1, 1.2, 1.3, 1.4, 1.5 )
		  Dim db() As Double = da.Clone
		  db.RemoveSlice 1,4  // remove items 1 through 3
		  ErrorIfNotEqual db, Array( 1.0, 1.4, 1.5 )
		  
		  db = da.Clone
		  db.RemoveSlice 3   // remove from 3 to the end
		  ErrorIfNotEqual db, Array( 1.0, 1.1, 1.2 )
		  
		  db = da.Clone
		  db.RemoveSlice -2   // remove the last 2 items
		  ErrorIfNotEqual db, Array( 1.0, 1.1, 1.2, 1.3 )
		  
		  db = da.Clone
		  db.RemoveSlice -4, -1  // remove the 4th through 2nd items from the end
		  ErrorIfNotEqual db, Array( 1.0, 1.1, 1.5 )
		  
		  db = da.Clone
		  db.RemoveSlice 0, 1  // remove just the 1st item
		  ErrorIfNotEqual db, Array( 1.1, 1.2, 1.3, 1.4, 1.5 )
		  
		  db = da.Clone
		  db.RemoveSlice -1  // remove just the last item
		  ErrorIfNotEqual db, Array( 1.0, 1.1, 1.2, 1.3, 1.4 )
		  
		  db = da.Clone
		  db.RemoveSlice 2, -3  // remove just item 2 (specified two ways)
		  ErrorIfNotEqual db, Array( 1.0, 1.1, 1.3, 1.4, 1.5 )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestReverse()
		  Dim sa() As String = Array( "a" )
		  sa.Reverse
		  ErrorIfNotEqual sa, Array( "a" )
		  
		  sa() = Array( "a", "b" )
		  sa.Reverse
		  ErrorIfNotEqual sa, Array( "b", "a" )
		  
		  sa() = Array( "a", "b", "c" )
		  sa.Reverse
		  ErrorIfNotEqual sa, Array( "c", "b", "a" )
		  
		  sa() = Array( "a", "b", "c", "d" )
		  sa.Reverse
		  ErrorIfNotEqual sa, Array( "d", "c", "b", "a" )
		  
		  
		  Dim da() As Double = Array( 1.1 )
		  da.Reverse
		  ErrorIfNotEqual da, Array( 1.1 )
		  
		  da() = Array( 1.1, 2.2 )
		  da.Reverse
		  ErrorIfNotEqual da, Array( 2.2, 1.1 )
		  
		  da() = Array( 1.1, 2.2, 3.3 )
		  da.Reverse
		  ErrorIfNotEqual da, Array( 3.3, 2.2, 1.1 )
		  
		  da() = Array( 1.1, 2.2, 3.3, 4.4 )
		  da.Reverse
		  ErrorIfNotEqual da, Array( 4.4, 3.3, 2.2, 1.1 )
		  
		  
		  Dim ia() As Integer = Array( 1 )
		  ia.Reverse
		  ErrorIfNotEqual ia, Array( 1 )
		  
		  ia() = Array( 1, 2 )
		  ia.Reverse
		  ErrorIfNotEqual ia, Array( 2, 1 )
		  
		  ia() = Array( 1, 2, 3 )
		  ia.Reverse
		  ErrorIfNotEqual ia, Array( 3, 2, 1 )
		  
		  ia() = Array( 1, 2, 3, 4 )
		  ia.Reverse
		  ErrorIfNotEqual ia, Array( 4, 3, 2, 1 )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestSlice()
		  Dim ia() As Integer = Array( 1, 2, 3, 4, 5 )
		  ErrorIfNotEqual ia.Slice(2), Array( 3, 4, 5 )
		  ErrorIfNotEqual ia.Slice(-2), Array( 4, 5 )
		  ErrorIfNotEqual ia.Slice(0, 2), Array( 1, 2 )
		  ErrorIfNotEqual ia.Slice, ia
		  ErrorIfNotEqual ia.Slice(0, -3), Array( 1, 2 )
		  
		  Dim da() As Double = Array( 1.1, 2.2, 3.3, 4.4, 5.5 )
		  ErrorIfNotEqual da.Slice(2), Array( 3.3, 4.4, 5.5 )
		  ErrorIfNotEqual da.Slice(-2), Array( 4.4, 5.5 )
		  ErrorIfNotEqual da.Slice(0, 2), Array( 1.1, 2.2 )
		  ErrorIfNotEqual da.Slice, da
		  ErrorIfNotEqual da.Slice(0, -3), Array( 1.1, 2.2 )
		  
		  Dim sa() As String = Array( "a", "b", "c", "d", "e" )
		  ErrorIfNotEqual sa.Slice(2), Array( "c", "d", "e" )
		  ErrorIfNotEqual sa.Slice(-2), Array( "d", "e" )
		  ErrorIfNotEqual sa.Slice(0, 2), Array( "a", "b" )
		  ErrorIfNotEqual sa.Slice, sa
		  ErrorIfNotEqual sa.Slice(0, -3), Array( "a", "b" )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestSplice()
		  Dim ia() As Integer = Array(0,1,2,3,4,5)
		  Dim ib() As Integer = Array(10,11,12)
		  
		  ia.Splice 2,4, ib
		  ErrorIfNotEqual ia, Array(0, 1, 10, 11, 12, 4, 5)
		  
		  ia = Array(0,1,2,3,4,5)
		  ia.Splice 2,4, ib, -2
		  ErrorIfNotEqual ia, Array(0, 1, 11, 12, 4, 5)
		  
		  ia = Array(0,1,2,3,4,5)
		  ia.Splice 2,3, ib
		  ErrorIfNotEqual ia, Array(0, 1, 10, 11, 12, 3, 4, 5)
		  
		  ia = Array(0,1,2,3,4,5)
		  ia.Splice 2,2, ib
		  ErrorIfNotEqual ia, Array(0, 1, 10, 11, 12, 2, 3, 4, 5)
		  
		  Dim da() As Double = Array(0.0,1,2,3,4,5)
		  Dim db() As Double = Array(1.0,1.1,1.2)
		  
		  da.Splice 2,4, db
		  ErrorIfNotEqual da, Array(0, 1, 1.0, 1.1, 1.2, 4, 5)
		  
		  da = Array(0.0,1,2,3,4,5)
		  da.Splice 2,4, db, -2
		  ErrorIfNotEqual da, Array(0, 1, 1.1, 1.2, 4, 5)
		  
		  da = Array(0.0,1,2,3,4,5)
		  da.Splice 2,3, db
		  ErrorIfNotEqual da, Array(0, 1, 1.0, 1.1, 1.2, 3, 4, 5)
		  
		  da = Array(0.0,1,2,3,4,5)
		  da.Splice 2,2, db
		  ErrorIfNotEqual da, Array(0, 1, 1.0, 1.1, 1.2, 2, 3, 4, 5)
		  
		  Dim sa() As String = Array("a","b","c","d","e","f")
		  Dim sb() As String = Array("foo","bar","baz")
		  
		  sa.Splice 2,4, sb
		  ErrorIfNotEqual sa, Array("a", "b", "foo", "bar", "baz", "e", "f")
		  
		  sa = Array("a","b","c","d","e","f")
		  sa.Splice 2,4, sb, -2
		  ErrorIfNotEqual sa, Array("a", "b", "bar", "baz", "e", "f")
		  
		  sa = Array("a","b","c","d","e","f")
		  sa.Splice 2,3, sb
		  ErrorIfNotEqual sa, Array("a", "b", "foo", "bar", "baz", "d", "e", "f")
		  
		  sa = Array("a","b","c","d","e","f")
		  sa.Splice 2,2, sb
		  ErrorIfNotEqual sa, Array("a", "b", "foo", "bar", "baz", "c", "d", "e", "f")
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestSum()
		  
		  Dim iarr() As Integer
		  ErrorIfNotEqual iarr.Total, 0
		  
		  iarr = Array(42)
		  ErrorIfNotEqual iarr.Total, 42
		  
		  iarr = Array(-1, 2, -3, 4, 5)
		  ErrorIfNotEqual iarr.Total, 7
		  
		  Dim darr() As Double
		  ErrorIfNotEqual darr.Total, 0.0
		  
		  darr = Array(42.0)
		  ErrorIfNotEqual darr.Total, 42.0
		  
		  darr = Array(-1.1, 2.2, -3.3, 4.4, 5.5)
		  ErrorIfNotEqual darr.Total, 7.7
		  
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
