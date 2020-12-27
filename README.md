# Xojo-ArrayUtils-API2

#Homepage

This ArrayUtils module in the API Version 2 is maintained by [TECcompanion GmbH](https://teccompanion.com).
The current administrative contact for it is Jeannot Muller ([jeannot-muller.com](https://jeannot-muller.com)).
You should be able to find the latest version via this URL:

> [https://jeannot-muller.com/](https://jeannot-muller.com/) 
> 
> and on GitHub: 
> 
> [https://github.com/Jeannot-Muller/Xojo-ArrayUtils-API2](https://github.com/Jeannot-Muller/Xojo-ArrayUtils-API2)

# License

This StringUtils module is in the public domain.  You may use it for any purpose
whatsoever, but it comes with no express or implied warranty of correctness or
fitness for any purpose.

Share and enjoy!

# Contributors
Many people have contributed to the development of this module, including:

## API2
Jeannot Muller, [dr@jeannot-muller.com]() (*)

(*) To whom correspondence should be addressed.

## API1
Joe Strout, joe@strout.net 

# Slice Indexing
Several of the methods in this module take two indexes to specify a subset
off an array.  Such a subset is called a "slice" and is involved in methods
such as RemoveSlice, Slice, and Splice.

In such cases, the first index specifies the first element in the slice.  It may
be either an ordinary, non-negative index, in which case 0 means the first
element of the array, 1 means the second element, and so on.  Or it may be
a negative number, in which case we count from the end of the array; -1 is
the last element, -2 is the next-to-last, and so on.

The second index specifies the element AFTER the last one to be included
in the slice.  Again this may be positive or negative, but 0 in this case means
one past the end of the array.

This indexing scheme seems a bit odd at first (unless you are familiar with
Python), but it has a lot of advantages.  Suppose you have an array 'a' with
five elements.  Then you have:

  * a.Slice(0,0) is the entire array
  * a.Slice(0,-1) is all but the last element
  * a.Slice(1,0) is all but the first element
  * a.Slice(0,2) is the first two elements
  * a.Slice(2,0) is everything except the first two elements

Indeed, you can generalize and note that a.Slice(0,n).Concat( a.Slice(n,0) )
always comes out equal to n.  Another advantage is that if you have a loop,
where either the first index is counting down to 0 or the last index is 
counting up (from negative numbers) to 0, it will do the right thing in the
boundary cases (i.e. when the counter hits 0).


# Version History

**2006-JAN-03:**

- Initial release.

**2006-JAN-16:**

- Changed the meaning of the second slice index on Slice and RemoveSlice,
  since careful thought about Splice pointed out how the previous meaning was wrong
  and Guido van Rossum, as usual, was quite right.  See "Slice Indexing" note.
- Renamed AppendArray to Append (this works fine as of RB2006R1).
- Finished the Splice and Append methods.

**2006-JAN-31:**

- Added the Concat method.
- Added the Reverse method.

**2020-DEC-27:**

- Renamed Append to Add 
- Conversion to API2


## Archive
In the folder 'Binaries' you will find the original API version, as .rb file and converted to a Xojo Binary Project. Please don't change the original files for those users, who want to see the original version and try the conversion themselves for education purposes.